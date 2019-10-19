//
//  GJVerifyButton.m
//  ZHYK
//
//  Created by Arlenly on 2018/3/29.
//  Copyright © 2018年 LiuGJ. All rights reserved.
//

#import "GJVerifyButton.h"

static NSInteger kVerifyTime = 60;

@interface GJVerifyButton ()
@property (nonatomic,strong) NSString *normalTitle;
@property (assign, nonatomic) NSInteger verifyTime;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@end

@implementation GJVerifyButton

- (id)initWithFrame:(CGRect)frame verifyTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _normalTitle = title;
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _normalTitle = @"发送验证码";
        [self setup];
    }
    return self;
}

- (BOOL)isHighlighted {
    return NO;
}

- (void)setup {
    _verifyTime = kVerifyTime;
    self.adjustsImageWhenHighlighted = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [APP_CONFIG appFontOfSize:13];
    [self setTitle:_normalTitle forState:UIControlStateNormal];
    [self setTitle:_normalTitle forState:UIControlStateDisabled];
    [self setTitleColor:APP_CONFIG.grayTextColor forState:UIControlStateNormal];
    [self addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.hidesWhenStopped = YES;
    [self addSubview:self.activityView];
}

- (void)settingEnable:(BOOL)enable {
    self.enabled = enable;
//    self.layer.borderColor =  enable ? [APP_CONFIG grayTextColor].CGColor : [APP_CONFIG grayTextColor].CGColor;
}

- (void)touchBtn:(UIButton *)button {
    BLOCK_SAFE(_clickBtnHandle)();
}

- (void)showActive:(BOOL)show {
    show ? [self.activityView startAnimating] : [self.activityView stopAnimating];
}

- (void)startEndTime {
    NSString *endTime = [NSString stringWithFormat:@"%lds",(long)_verifyTime];
    [self setTitle:endTime forState:UIControlStateDisabled];
    [self settingEnable:NO];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerStart:(NSTimer *)timer {
    _verifyTime -= 1;
    if (_verifyTime == 0) {
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitle:@"重新获取" forState:UIControlStateDisabled];
        _verifyTime = kVerifyTime;
        [self settingEnable:YES];
        [_timer invalidate];
        _timer = nil;
    }else {
        NSString *str = [NSString stringWithFormat:@"%lds",(long)_verifyTime];
        [self setTitle:str forState:UIControlStateDisabled];
    }
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.activityView.center = self.boundsCenter;
}

@end
