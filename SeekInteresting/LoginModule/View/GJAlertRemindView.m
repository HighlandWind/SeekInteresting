//
//  GJAlertRemindView.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/19.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJAlertRemindView.h"

@interface GJAlertRemindView ()
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *continueBtn;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@end

@implementation GJAlertRemindView

- (void)sureBtnClick {
    [self bgBtnClick];
    BLOCK_SAFE(_blockClickSure)();
}

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        [self addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _bgBtn = [[UIButton alloc] init];
        _bgBtn.backgroundColor = [UIColor whiteColor];
        _bgBtn.layer.cornerRadius = 5;
        _bgBtn.clipsToBounds = YES;
        
        _sureBtn = [[UIButton alloc] init];
        _sureBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithRGB:159 g:187 b:252] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _continueBtn = [[UIButton alloc] init];
        _continueBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        [_continueBtn setTitle:@"继续创建" forState:UIControlStateNormal];
        [_continueBtn setTitleColor:APP_CONFIG.grayTextColor forState:UIControlStateNormal];
        [_continueBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"取消创建用户";
        _titleLB.textColor = APP_CONFIG.blackTextColor;
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        [_titleLB sizeToFit];
        
        _detailLB = [[UILabel alloc] init];
        _detailLB.text = @"确定取消创建用户吗？您已经输入的资料将会丢失。";
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        _detailLB.numberOfLines = 3;
        [_detailLB sizeToFit];
        
        [self addSubview:_bgBtn];
        [self addSubview:_sureBtn];
        [self addSubview:_continueBtn];
        [self addSubview:_titleLB];
        [self addSubview:_detailLB];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(20));
        make.right.equalTo(self).with.offset(-AdaptatSize(20));
        make.center.equalTo(self);
        make.height.mas_equalTo(AdaptatSize(200));
    }];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.bgBtn);
        make.width.mas_equalTo(AdaptatSize(80));
        make.height.mas_equalTo(AdaptatSize(60));
    }];
    [_continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sureBtn.mas_left);
        make.centerY.equalTo(self.sureBtn);
        make.width.mas_equalTo(AdaptatSize(100));
        make.height.mas_equalTo(AdaptatSize(60));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgBtn).with.offset(AdaptatSize(20));
        make.top.equalTo(self.bgBtn).with.offset(AdaptatSize(30));
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLB);
        make.right.equalTo(self.bgBtn).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.titleLB.mas_bottom).with.offset(AdaptatSize(25));
    }];
}

+ (void)showAlertBlock:(void (^)(void))sure {
    GJAlertRemindView *v = [GJAlertRemindView new];
    v.blockClickSure = sure;
    [[UIApplication sharedApplication].keyWindow addSubview:v];
}

- (void)bgBtnClick {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

@end
