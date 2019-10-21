//
//  GJLoginView.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/19.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJLoginView.h"
#import "GJVerifyButton.h"

@interface GJLoginView ()
@property (strong, nonatomic) UIImageView *logoImgV;

@property (strong, nonatomic) UITextField *phoneTF;
@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) GJVerifyButton *getCodeBtn;
@property (strong, nonatomic) UITextField *codeTF;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) UIButton *wechatBtn;
@property (strong, nonatomic) UIButton *registerBtn;
@property (strong, nonatomic) UIButton *protocolBtn;
@property (strong, nonatomic) UIButton *policeBtn;
@property (strong, nonatomic) UILabel *leftLine;
@property (strong, nonatomic) UILabel *rightLine;
@property (strong, nonatomic) UILabel *lineLB;
@property (strong, nonatomic) UILabel *regLB;
@property (strong, nonatomic) UILabel *heLB;
@end

@implementation GJLoginView

- (void)getCodeBtnClick {
    
}

- (void)loginBtnClick {
    BLOCK_SAFE(_blockClickLogin)();
}

- (void)wechatBtnClick {
    
}

- (void)registerBtnClick {
    BLOCK_SAFE(_blockClickRegister)();
}

- (void)protocolBtnClick {
    
}

- (void)policeBtnClick {
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // top
        _logoImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        
        // middle
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.placeholder = @"手机号";
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.font = [APP_CONFIG appAdaptFontOfSize:17];
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.tintColor = APP_CONFIG.appMainColor;
        
        _getCodeBtn = [[GJVerifyButton alloc] initWithFrame:CGRectZero verifyTitle:@"获取验证码"];
        [_getCodeBtn setTitleColor:APP_CONFIG.lightTextColor forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = AdapFont([APP_CONFIG appFontOfSize:13]);
        _getCodeBtn.selected = NO;
        [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _line1 = [[UIView alloc] init];
        _line2 = [[UIView alloc] init];
        _line1.backgroundColor = _line2.backgroundColor = APP_CONFIG.lightTextColor;
        
        _codeTF = [[UITextField alloc] init];
        _codeTF.placeholder = @"短信验证码";
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.font = _phoneTF.font;
        _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTF.tintColor = APP_CONFIG.appMainColor;
        
        _loginBtn = [[UIButton alloc] init];
        _loginBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor colorWithRGB:230 g:240 b:255]];
        _loginBtn.layer.cornerRadius = AdaptatSize(46) / 2;
        _loginBtn.clipsToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        // bottom
        _wechatBtn = [[UIButton alloc] init];
        _wechatBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:18];
        [_wechatBtn setTitle:@"  微信登录" forState:UIControlStateNormal];
        [_wechatBtn setTitleColor:[UIColor colorWithRGB:154 g:216 b:158] forState:UIControlStateNormal];
        [_wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        [_wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = APP_CONFIG.lightTextColor;
        
        _lineLB = [[UILabel alloc] init];
        _lineLB.text = @"或";
        _lineLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        _lineLB.textColor = APP_CONFIG.lightTextColor;
        [_lineLB sizeToFit];
        
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = APP_CONFIG.lightTextColor;
        
        _registerBtn = [[UIButton alloc] init];
        _registerBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:18];
        [_registerBtn setTitleColor:[UIColor colorWithRGB:159 g:187 b:252] forState:UIControlStateNormal];
        [_registerBtn setTitle:@"创建新用户" forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _regLB = [[UILabel alloc] init];
        _regLB.font = [APP_CONFIG appAdaptFontOfSize:13];
        _regLB.text = @"注册即代表同意";
        _regLB.textColor = APP_CONFIG.grayTextColor;
        [_regLB sizeToFit];
        
        _protocolBtn = [[UIButton alloc] init];
        _protocolBtn.titleLabel.font = _regLB.font;
        [_protocolBtn setTitleColor:_registerBtn.titleLabel.textColor forState:UIControlStateNormal];
        [_protocolBtn setTitle:@"'用户协议'" forState:UIControlStateNormal];
        [_protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _heLB = [[UILabel alloc] init];
        _heLB.font = _regLB.font;
        _heLB.text = @"和";
        _heLB.textColor = _regLB.textColor;
        [_heLB sizeToFit];
        
        _policeBtn = [[UIButton alloc] init];
        _policeBtn.titleLabel.font = _regLB.font;
        [_policeBtn setTitleColor:_protocolBtn.titleLabel.textColor forState:UIControlStateNormal];
        [_policeBtn setTitle:@"'隐私政策'" forState:UIControlStateNormal];
        [_policeBtn addTarget:self action:@selector(policeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_logoImgV];
        [self addSubview:_phoneTF];
        [self addSubview:_line1];
        [self addSubview:_getCodeBtn];
        [self addSubview:_codeTF];
        [self addSubview:_line2];
        [self addSubview:_loginBtn];
        [self addSubview:_wechatBtn];
        [self addSubview:_leftLine];
        [self addSubview:_lineLB];
        [self addSubview:_rightLine];
        [self addSubview:_registerBtn];
        [self addSubview:_regLB];
        [self addSubview:_protocolBtn];
        [self addSubview:_heLB];
        [self addSubview:_policeBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // top
    [_logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.width.height.mas_equalTo(AdaptatSize(200));
    }];
    
    // middle
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneTF);
        make.right.equalTo(self);
        make.height.mas_equalTo(AdaptatSize(30));
        make.width.mas_equalTo(AdaptatSize(80));
    }];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IPHONE_X) {
            make.top.equalTo(self.logoImgV.mas_bottom).with.offset(AdaptatSize(30));
        }else {
            make.top.equalTo(self.logoImgV.mas_bottom);
        }
        make.left.equalTo(self);
        make.right.equalTo(self.getCodeBtn.mas_left);
        make.height.mas_equalTo(AdaptatSize(50));
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.phoneTF);
        make.right.equalTo(self.getCodeBtn);
        make.height.mas_equalTo(0.7);
    }];
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTF.mas_bottom).with.offset(AdaptatSize(30));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(AdaptatSize(50));
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.codeTF);
        make.height.mas_equalTo(0.7);
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_centerY).with.offset(AdaptatSize(70));
        make.height.mas_equalTo(AdaptatSize(46));
    }];
    
    // bottom
    [_regLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).with.offset(-10);
        make.bottom.equalTo(self);
    }];
    [_protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.regLB.mas_right);
        make.centerY.equalTo(self.regLB);
    }];
    [_heLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.protocolBtn.mas_right);
        make.centerY.equalTo(self.regLB);
    }];
    [_policeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.heLB.mas_right);
        make.centerY.equalTo(self.regLB);
    }];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.regLB.mas_top).with.offset(-5);
    }];
    [_lineLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.registerBtn.mas_top).with.offset(-10);
    }];
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lineLB);
        make.height.mas_equalTo(0.7);
        make.right.equalTo(self.lineLB.mas_left).with.offset(-10);
        make.left.equalTo(self).with.offset(10);
    }];
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lineLB);
        make.height.mas_equalTo(0.7);
        make.left.equalTo(self.lineLB.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
    }];
    [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.lineLB.mas_top).with.offset(-AdaptatSize(25));
    }];
}

@end
