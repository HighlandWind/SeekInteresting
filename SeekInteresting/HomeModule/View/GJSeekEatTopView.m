//
//  GJSeekEatTopView.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/15.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEatTopView.h"

@interface GJSeekEatTopView ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@end

@implementation GJSeekEatTopView

+ (GJSeekEatTopView *)installTitle:(NSString *)title detail:(NSString *)detail {
    GJSeekEatTopView *v = [[GJSeekEatTopView alloc] init];
    v.titleLB.text = title;
    v.detailLB.text = detail;
    return v;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AdaptatSize(22));
        CGFloat w = 15 * self.detailLB.text.length + 40;
        make.width.mas_equalTo(AdaptatSize(w));
        make.bottom.equalTo(self);
        make.left.equalTo(self.titleLB);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:25];
        _titleLB.textColor = APP_CONFIG.whiteGrayColor;
        [_titleLB sizeToFit];
        
        _detailLB = [[UILabel alloc] init];
        _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:13];
        _detailLB.textColor = [UIColor colorWithRGB:200 g:209 b:254];
        _detailLB.textAlignment = NSTextAlignmentCenter;
        _detailLB.layer.cornerRadius = AdaptatSize(22) / 2;
        _detailLB.clipsToBounds = YES;
        _detailLB.backgroundColor = [UIColor whiteColor];
        [_detailLB sizeToFit];
        
        [self addSubview:_titleLB];
        [self addSubview:_detailLB];
    }
    return self;
}

@end



@interface GJSeekLRBtn ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation GJSeekLRBtn

- (void)leftBtnClick {
    BLOCK_SAFE(_blockClickLeft)();
}

- (void)rightBtnClick {
    BLOCK_SAFE(_blockClickRight)();
}

- (instancetype)initLeft:(NSString *)left right:(NSString *)right {
    self = [super init];
    if (self) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:left forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateHighlighted];
        _leftBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        [_leftBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent:)];
        longPress.minimumPressDuration = 0.1;
        [_leftBtn addGestureRecognizer:longPress];
        
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:right forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateHighlighted];
        _rightBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        [_rightBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_leftBtn];
        [self addSubview:_rightBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(self);
        make.width.height.mas_equalTo(AdaptatSize(36));
    }];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.rightBtn.mas_left).with.offset(-5);
    }];
}

- (void)longPressEvent:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [_leftBtn shakeViewCallback:^{
            BLOCK_SAFE(_blockClickLeft)();
        }];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _leftBtn.layer.cornerRadius = self.leftBtn.height / 2;
    _rightBtn.layer.cornerRadius = self.rightBtn.height / 2;
    _leftBtn.clipsToBounds = _rightBtn.clipsToBounds = YES;
}

@end
