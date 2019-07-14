//
//  GJLoginController.m
//  SeekInteresting
//
//  Created by LiuGJ on 2018/3/29.
//  Copyright © 2018年 LiuGJ. All rights reserved.
//

#import "GJLoginController.h"
#import "GJLoginApi.h"

@interface GJLoginController ()
@property (nonatomic, copy) LoginSuccessBlcok loginBlock;
@property (nonatomic, copy) LogoutSuccessBlcok logoutBlock;
@property (strong, nonatomic) GJLoginApi *loginApi;
@end

@implementation GJLoginController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BLOCK_SAFE(self.logoutBlock)();
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _loginApi = [GJLoginApi new];
}

- (void)initializationSubView {
    
}

- (void)initializationNetWorking {}

#pragma mark - event response


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
    [fromVc presentViewController:loginController animated:YES completion:nil];
    return YES;
}

+ (void)logOutPresentLoginControllerByVC:(UIViewController *)controller loginSucessBlcok:(LogoutSuccessBlcok)success {
    [APP_USER loginOut];
    GJLoginController *loginController = [[GJLoginController alloc] init];
    loginController.logoutBlock = success;
    
    while (controller.presentingViewController) {
        controller = controller.presentingViewController;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    [controller presentViewController:loginController animated:YES completion:^{
        ShowWaringAlertHUD(@"已退出登录", nil);
    }];
}

#pragma mark - Custom delegate
// GJLoginViewDelegate
- (void)submitBtnClick {
    
}

- (void)requestLogin:(NSString *)phone code:(NSString *)code {
//    [self.loginApi loginByTelePhone:phone smsCode:code success:^(NSURLResponse *urlResponse, id response) {
//        ShowProgressHUDWithText(NO, self.view, nil);
//        [APP_USER loginSucess:response];
//        BLOCK_SAFE(_loginBlock)();
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } failure:^(NSURLResponse *urlResponse, NSError *error) {
//        ShowProgressHUDWithText(NO, self.view, nil);
//        ShowWaringAlertHUD(error.localizedDescription, nil);
//    }];
}

- (void)procotolBtnClick {
//    [TKWebMedia customPresentWebViewJumpUrl:@"http://www.qzylcn.com/7/6" title:nil controller:self];
}

#pragma mark - Getter/Setter


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
