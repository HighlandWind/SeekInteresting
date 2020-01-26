//
//  GJLoginController.m
//  SeekInteresting
//
//  Created by LiuGJ on 2018/3/29.
//  Copyright © 2018年 LiuGJ. All rights reserved.
//

#import "GJLoginController.h"
#import "GJLoginApi.h"
#import "GJLoginView.h"
#import "GJAccountRegistVC.h"
#import "GJBaseNavigationController.h"
#import "TKWebMedia.h"

@interface GJLoginController ()
@property (nonatomic, copy) LoginSuccessBlcok loginBlock;
@property (nonatomic, copy) LogoutSuccessBlcok logoutBlock;
@property (strong, nonatomic) GJLoginApi *loginApi;
@property (strong, nonatomic) UIButton *closeBtn;
@property (strong, nonatomic) GJLoginView *loginView;
@property (strong, nonatomic) NSString *tempTelePhoneNum;
@end

@implementation GJLoginController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat btmOffset = AdaptatSize(25);
    if (IPHONE_X) {
        btmOffset += AdaptatSize(30);
    }
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-btmOffset);
        make.right.equalTo(self.view).with.offset(-AdaptatSize(40));
        make.left.equalTo(self.view).with.offset(AdaptatSize(40));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showShadorOnNaviBar:NO];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _loginApi = [GJLoginApi new];
}

- (void)initializationSubView {
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItem = close;
    [self addSubview:self.loginView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _loginView.blockClickRegister = ^{
        GJAccountRegistVC *vc = [GJAccountRegistVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    _loginView.blockClickLogin = ^(NSString * _Nonnull phone, NSString * _Nonnull code) {
        [weakSelf requestLogin:phone code:code];
    };
    _loginView.blockClickCode = ^(NSString * _Nonnull phone) {
        [weakSelf sendSMSCode:phone];
    };
    _loginView.blockClickProtocol = ^{
        [weakSelf procotolBtnClick];
    };
    _loginView.blockClickWechat = ^{
        
    };
}

#pragma mark - Request Handle
- (void)sendSMSCode:(NSString *)phone {
    _tempTelePhoneNum = phone;
    [self.loginApi loginByTelePhone:phone smsCode:nil success:^(NSURLResponse *urlResponse, id response) {
        ShowWaringAlertHUD(@"验证码发送成功", nil);
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        ShowWaringAlertHUD(error.localizedDescription, nil);
    }];
}

- (void)requestLogin:(NSString *)phone code:(NSString *)code {
//    if (![phone isEqualToString:_tempTelePhoneNum]) {
//        ShowWaringAlertHUD(@"请先获取验证码", self.view);
//        return;
//    }
    ShowProgressHUDWithText(YES, self.view, @"登录中...");
//    [self.loginApi loginByTelePhone:phone smsCode:code success:^(NSURLResponse *urlResponse, id response) {
        ShowProgressHUDWithText(NO, self.view, nil);
//        [APP_USER loginSucess:response];
        BLOCK_SAFE(self.loginBlock)();
        [self closeBtnClick];
//    } failure:^(NSURLResponse *urlResponse, NSError *error) {
//        ShowProgressHUDWithText(NO, self.view, nil);
//        ShowWaringAlertHUD(error.localizedDescription, nil);
//    }];
}

#pragma mark - Event response
- (void)procotolBtnClick {
    [TKWebMedia customPresentWebViewJumpUrl:@"https://www.baidu.com/" title:nil controller:self];
}

- (void)closeBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Class Function
+ (BOOL)needLoginSucessBlcok:(LoginSuccessBlcok)success {
    if ([APP_USER isLoginStatus]) {
        BLOCK_SAFE(success)();
        return NO;
    }
    // 访客登录
    [[GJLoginApi new] loginWithVisitorSuccess:^(NSURLResponse *urlResponse, id response) {
        [APP_USER loginSucess:response];
        BLOCK_SAFE(success)();
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        
    }];
    return YES;
}

+ (BOOL)needLoginPresentWithVC:(UIViewController *)controller loginSucessBlcok:(LoginSuccessBlcok)success {
    if ([APP_USER isLoginStatus]) {
        BLOCK_SAFE(success)();
        return NO;
    }
    [APP_USER loginOut];
    GJLoginController *loginController = [[GJLoginController alloc] init];
    loginController.loginBlock = success;
    UIViewController *fromVc = controller ? controller : [GJFunctionManager CurrentTopViewcontroller];
    GJBaseNavigationController *naviVC = [[GJBaseNavigationController alloc] initWithRootViewController:loginController];
    [fromVc presentViewController:naviVC animated:YES completion:nil];
    return YES;
}

+ (void)logOutPresentLoginControllerByVC:(UIViewController *)controller loginSucessBlcok:(LogoutSuccessBlcok)success {
    [APP_USER loginOut];
}

#pragma mark - Getter/Setter
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (GJLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[GJLoginView alloc] init];
    }
    return _loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
