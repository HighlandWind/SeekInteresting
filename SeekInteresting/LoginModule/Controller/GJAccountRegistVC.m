//
//  GJAccountRegistVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/19.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJAccountRegistVC.h"
#import "GJNickNameVC.h"
#import "GJAlertRemindView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface GJAccountRegistVC ()
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UILabel *detailLB;
@property (strong, nonatomic) UIButton *startBtn;
@property (strong, nonatomic) UILabel *remindLB;
@property (strong, nonatomic) UIButton *backBtn;
@end

@implementation GJAccountRegistVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).with.offset(-AdaptatSize(40));
        make.left.equalTo(self.view).with.offset(AdaptatSize(15));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(15));
        make.height.mas_equalTo(AdaptatSize(40));
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.startBtn.mas_top).with.offset(-AdaptatSize(90));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.detailLB.mas_top).with.offset(-AdaptatSize(30));
    }];
    [_remindLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.startBtn.mas_bottom).with.offset(AdaptatSize(30));
    }];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.remindLB);
        make.left.equalTo(self.remindLB.mas_right);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return NO;
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    self.fd_interactivePopDisabled = YES;
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self allowBackWithImage:@"arrow_back_white"];
    [self addSubview:self.titleLB];
    [self addSubview:self.detailLB];
    [self addSubview:self.startBtn];
    [self addSubview:self.remindLB];
    [self addSubview:self.backBtn];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)backAction {
//    [super backAction];
    
}

- (void)startBtnClick {
    GJNickNameVC *vc = [GJNickNameVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backBtnClick {
    __weak typeof(self)weakSelf = self;
    [GJAlertRemindView showAlertBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self backBtnClick];
    }
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"账号注册";
        _titleLB.textColor = [UIColor colorWithRGB:185 g:219 b:254];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (UILabel *)detailLB {
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.text = @"创建新账户，只需简单几步就可以完成！";
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_detailLB sizeToFit];
    }
    return _detailLB;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] init];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startBtn setBackgroundColor:[UIColor colorWithRGB:185 g:219 b:254]];
        _startBtn.layer.cornerRadius = AdaptatSize(40) / 2;
        _startBtn.clipsToBounds = YES;
        _startBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

- (UILabel *)remindLB {
    if (!_remindLB) {
        _remindLB = [[UILabel alloc] init];
        _remindLB.text = @"已经有账户了？";
        _remindLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        _remindLB.textColor = APP_CONFIG.grayTextColor;
        [_remindLB sizeToFit];
    }
    return _remindLB;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"登录或返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.font = _remindLB.font;
        [_backBtn setTitleColor:[UIColor colorWithRGB:185 g:219 b:254] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
