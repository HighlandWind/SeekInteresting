//
//  GJCodeVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/20.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJCodeVC.h"

@interface GJCodeVC () <UITextFieldDelegate>
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UITextField *inputTF;
@property (strong, nonatomic) UILabel *detailLB;
@property (strong, nonatomic) UIButton *nextBtn;
@end

@implementation GJCodeVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(NavBar_H+AdaptatSize(60));
    }];
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLB.mas_bottom).with.offset(AdaptatSize(60));
        make.left.equalTo(self.view).with.offset(AdaptatSize(15));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(15));
        make.height.mas_equalTo(AdaptatSize(50));
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.inputTF.mas_bottom).with.offset(AdaptatSize(30));
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputTF.mas_bottom).with.offset(AdaptatSize(30));
        make.left.equalTo(self.view).with.offset(AdaptatSize(15));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(15));
        make.height.mas_equalTo(AdaptatSize(40));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self allowBackWithImage:@"arrow_back_white"];
    [self addSubview:self.titleLB];
    [self addSubview:self.inputTF];
    [self addSubview:self.detailLB];
    [self addSubview:self.nextBtn];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)nextBtnClick {
    [_inputTF resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Custom delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *textStr = [textField.text changeCharactersInRange:range replacementString:string];
    
    _nextBtn.hidden = textStr.length < 1;
    _detailLB.hidden = !_nextBtn.hidden;
    
    return YES;
}

#pragma mark - Getter/Setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"请输入验证码";
        _titleLB.textColor = [UIColor colorWithRGB:185 g:219 b:254];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:20];
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (UITextField *)inputTF {
    if (!_inputTF) {
        _inputTF = [[UITextField alloc] init];
        _inputTF.placeholder = @"验证码";
        _inputTF.keyboardType = UIKeyboardTypeNumberPad;
        _inputTF.backgroundColor = [UIColor colorWithRGB:247 g:247 b:247];
        _inputTF.layer.cornerRadius = 5;
        _inputTF.clipsToBounds = YES;
        _inputTF.delegate = self;
        _inputTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptatSize(30), 0)];
        _inputTF.leftView.userInteractionEnabled = NO;
        _inputTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _inputTF;
}

- (UILabel *)detailLB {
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.text = [NSString stringWithFormat:@"输入手机号 %@ 接收到的验证码", _phone];
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_detailLB sizeToFit];
    }
    return _detailLB;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"继续" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:[UIColor colorWithRGB:185 g:219 b:254]];
        _nextBtn.layer.cornerRadius = AdaptatSize(40) / 2;
        _nextBtn.clipsToBounds = YES;
        _nextBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = YES;
    }
    return _nextBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
