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
        make.left.bottom.equalTo(self);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:28];
        _titleLB.textColor = APP_CONFIG.blackTextColor;
        [_titleLB sizeToFit];
        
        _detailLB = [[UILabel alloc] init];
        _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        _detailLB.textColor = APP_CONFIG.grayTextColor;
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
        _leftBtn.backgroundColor = APP_CONFIG.lightTextColor;
        _leftBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        [_leftBtn setTitleColor:APP_CONFIG.grayTextColor forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:right forState:UIControlStateNormal];
        _rightBtn.backgroundColor = APP_CONFIG.appMainColor;
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
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX).with.offset(-AdaptatSize(10));
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_centerX).with.offset(AdaptatSize(10));
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _leftBtn.layer.cornerRadius = self.height / 2;
    _rightBtn.layer.cornerRadius = self.height / 2;
    _leftBtn.clipsToBounds = _rightBtn.clipsToBounds = YES;
}

@end
