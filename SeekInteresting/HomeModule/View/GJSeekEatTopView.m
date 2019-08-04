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
@property (nonatomic, assign) SelectPageType pageType;
@end

@implementation GJSeekEatTopView

+ (GJSeekEatTopView *)installType:(SelectPageType)pageType {
    GJSeekEatTopView *v = [[GJSeekEatTopView alloc] init];
    v.pageType = pageType;
    return v;
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLB.text = titleText;
}

- (void)setDetailText:(NSString *)detailText {
    _detailText = detailText;
    _detailLB.text = detailText;
    
    [_detailLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AdaptatSize(22));
        CGFloat w = 15 * self.detailLB.text.length + 30;
        make.width.mas_equalTo(AdaptatSize(w));
        make.bottom.equalTo(self);
        make.left.equalTo(self.titleLB);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
    }];
}

- (void)setPageType:(SelectPageType)pageType {
    _pageType = pageType;
    if (pageType == SelectPageType_Event) {
        _titleLB.textColor = APP_CONFIG.whiteGrayColor;
        _detailLB.textColor = [UIColor colorWithRGB:200 g:209 b:254];
        _detailLB.textAlignment = NSTextAlignmentCenter;
        _detailLB.layer.cornerRadius = AdaptatSize(22) / 2;
        _detailLB.clipsToBounds = YES;
        _detailLB.backgroundColor = [UIColor whiteColor];
    }else {
        _titleLB.textColor = APP_CONFIG.blackTextColor;
        _detailLB.textColor = APP_CONFIG.grayTextColor;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:25];
        [_titleLB sizeToFit];
        
        _detailLB = [[UILabel alloc] init];
        _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:13];
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
@property (nonatomic, assign) SelectPageType pageType;
@end

@implementation GJSeekLRBtn

- (void)leftBtnClick {
    BLOCK_SAFE(_blockClickLeft)();
}

- (void)rightBtnClick {
    BLOCK_SAFE(_blockClickRight)();
}

- (instancetype)initLeft:(NSString *)left right:(NSString *)right type:(SelectPageType)pageType {
    self = [super init];
    if (self) {
        _pageType = pageType;
        
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:left forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent:)];
        longPress.minimumPressDuration = 0.1;
        [_leftBtn addGestureRecognizer:longPress];
        
        _rightBtn = [[UIButton alloc] init];
        _rightBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        if (_pageType == SelectPageType_Event) {
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateHighlighted];
            [_leftBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateHighlighted];
            [_rightBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
        }else {
            _leftBtn.backgroundColor = APP_CONFIG.lightTextColor;
            [_rightBtn setTitle:right forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
            [_rightBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
            _rightBtn.backgroundColor = APP_CONFIG.appMainColor;
        }
        
        [self addSubview:_leftBtn];
        [self addSubview:_rightBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_pageType == SelectPageType_Event) {
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(self);
            make.width.height.mas_equalTo(AdaptatSize(36));
        }];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.rightBtn.mas_left).with.offset(-5);
        }];
    }else {
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.mas_centerX).with.offset(-AdaptatSize(10));
        }];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_centerX).with.offset(AdaptatSize(10));
        }];
    }
}

- (void)longPressEvent:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.leftBtn shakeViewCallback:^{
            BLOCK_SAFE(self.blockClickLeft)();
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
