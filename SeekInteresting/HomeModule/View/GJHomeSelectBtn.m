//
//  GJHomeSelectBtn.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/3.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJHomeSelectBtn.h"

@interface GJHomeSelectBtn ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@property (nonatomic, strong) UIButton *gotoBtn;
@end

@implementation GJHomeSelectBtn

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(38));
        make.bottom.equalTo(self.mas_centerY);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLB);
        make.left.equalTo(self.titleLB.mas_right).with.offset(AdaptatSize(10));
    }];
    [_gotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLB);
        make.top.equalTo(self.mas_centerY);
        make.width.mas_equalTo(AdaptatSize(90));
        make.height.mas_equalTo(AdaptatSize(26));
    }];
}

- (void)gotoBtnClick {
    BLOCK_SAFE(_blockClickGoto)();
}

- (instancetype)initWithType:(SelectPageType)pageType {
    self = [super init];
    if (self) {
        if (pageType == SelectPageType_Eat) {
            [self createViewsImg:@"index_food_girl" title:@"找点吃的" action:@"立即行动"];
        }
        if (pageType == SelectPageType_Event) {
            [self createViewsImg:@"index_work_girl" title:@"找点事做" action:@"立即点击"];
        }
    }
    return self;
}

- (void)createViewsImg:(NSString *)img title:(NSString *)title action:(NSString *)action {
    [self setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateHighlighted];
    _backView = [[UIView alloc] init];
    _backView.userInteractionEnabled = NO;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
    _titleLB.text = title;
    _titleLB.textColor = APP_CONFIG.whiteGrayColor;
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:12];
    _detailLB.text = title;
    _detailLB.textColor = APP_CONFIG.whiteGrayColor;
    [_detailLB sizeToFit];
    
    _gotoBtn = [[UIButton alloc] init];
    _gotoBtn.titleLabel.font = [APP_CONFIG appFontOfSize:14];
    [_gotoBtn setTitle:action forState:UIControlStateNormal];
    [_gotoBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
    _gotoBtn.layer.cornerRadius = AdaptatSize(26) / 2;
    _gotoBtn.clipsToBounds = YES;
    _gotoBtn.layer.borderWidth = 1;
    _gotoBtn.layer.borderColor = APP_CONFIG.whiteGrayColor.CGColor;
    [_gotoBtn addTarget:self action:@selector(gotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_backView];
    [self addSubview:_titleLB];
    [self addSubview:_detailLB];
    [self addSubview:_gotoBtn];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    if ([_titleLB.text isEqualToString:@"找点吃的"]) {
//        [GJFunctionManager colorGraduallyChange:_backView
//                                          color:[UIColor colorWithRGB:255 g:171 b:171]
//                                        toColor:[UIColor colorWithRGB:253 g:223 b:151]];
//    }else {
//        [GJFunctionManager colorGraduallyChange:_backView
//                                          color:[UIColor colorWithRGB:165 g:181 b:251]
//                                        toColor:[UIColor colorWithRGB:211 g:221 b:255]];
//    }
//
//    _backView.layer.cornerRadius = self.height / 2;
//    _backView.clipsToBounds = YES;
//    self.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.layer.shadowOpacity = 0.8;
//    self.layer.shadowRadius = 5.f;
//    self.layer.shadowOffset = CGSizeMake(0,0);
}

@end


@interface GJHomeTopView ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@end

@implementation GJHomeTopView

+ (GJHomeTopView *)install {
    GJHomeTopView *v = [[GJHomeTopView alloc] init];
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
        _titleLB.text = @"你想干嘛呢？";
        [_titleLB sizeToFit];
        
        _detailLB = [[UILabel alloc] init];
        _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.text = @"一个人的时候";
        [_detailLB sizeToFit];
        
        [self addSubview:_titleLB];
        [self addSubview:_detailLB];
    }
    return self;
}

@end

