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
@property (nonatomic, strong) UIImageView *rightImgV;
@property (nonatomic, assign) SelectPageType selectType;
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
    [_rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.detailLB.mas_right);
    }];
}

- (void)gotoBtnClick {
    BLOCK_SAFE(_blockClickGoto)();
}

- (instancetype)initWithType:(SelectPageType)pageType {
    self = [super init];
    if (self) {
        _selectType = pageType;
        if (pageType == SelectPageType_Eat) {
            [self createViewsImg:@"index_food_btn" title:@"找点吃的" detail:@"比如喝个下午茶吧" action:@"立即行动"];
        }
        if (pageType == SelectPageType_Event) {
            [self createViewsImg:@"index_work_btn" title:@"找点事做" detail:@"听一首舒心的歌曲吧" action:@"立即点击"];
        }
    }
    return self;
}

- (void)createViewsImg:(NSString *)img title:(NSString *)title detail:(NSString *)detail action:(NSString *)action {
    self.imageView.image = [UIImage imageNamed:img];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    _backView = [[UIView alloc] init];
    _backView.userInteractionEnabled = NO;
    
    _rightImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:img]];
    _rightImgV.contentMode = UIViewContentModeScaleAspectFit;
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [APP_CONFIG appAdaptFontOfSize:18];
    _titleLB.text = title;
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = [APP_CONFIG appAdaptFontOfSize:11];
    _detailLB.text = detail;
    [_detailLB sizeToFit];
    
    _gotoBtn = [[UIButton alloc] init];
    _gotoBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
    [_gotoBtn setTitle:action forState:UIControlStateNormal];
    _gotoBtn.layer.cornerRadius = AdaptatSize(26) / 2;
    _gotoBtn.clipsToBounds = YES;
    _gotoBtn.layer.borderWidth = 1;
    [_gotoBtn addTarget:self action:@selector(gotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(gotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent:)];
    longPress.minimumPressDuration = 0.1;
    [self addGestureRecognizer:longPress];
    
    [self addSubview:_backView];
    [self addSubview:_rightImgV];
    [self addSubview:_titleLB];
    [self addSubview:_detailLB];
    [self addSubview:_gotoBtn];
}

- (void)setIsMan:(BOOL)isMan {
    _isMan = isMan;
    
    if (_isMan) {
        _titleLB.textColor = [UIColor colorWithRGB:169 g:183 b:255];
        [_gotoBtn setTitleColor:[UIColor colorWithRGB:169 g:183 b:255] forState:UIControlStateNormal];
        _detailLB.textColor = [UIColor colorWithRGB:169 g:183 b:255];
    }else {
        _titleLB.textColor = [UIColor colorWithRGB:215 g:177 b:126];
        [_gotoBtn setTitleColor:[UIColor colorWithRGB:215 g:177 b:126] forState:UIControlStateNormal];
        _detailLB.textColor = [UIColor colorWithRGB:215 g:177 b:126];
    }
    _gotoBtn.layer.borderColor = _gotoBtn.titleLabel.textColor.CGColor;
}

- (void)longPressEvent:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeScale(1.2, 0.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformMakeScale(0.8, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.09 animations:^{
                    self.transform = CGAffineTransformMakeScale(0.9, 0.9);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.08 animations:^{
                        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.08 animations:^{
                            self.transform = CGAffineTransformMakeScale(0.95, 0.95);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.08 animations:^{
                                self.transform = CGAffineTransformMakeScale(1.05, 1.05);
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.08 animations:^{
                                    self.transform = CGAffineTransformMakeScale(1, 1);
                                } completion:^(BOOL finished) {
                                    [self gotoBtnClick];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }else {
    }
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

- (void)setIsMan:(BOOL)isMan {
    _isMan = isMan;
    if (isMan) {
        _titleLB.textColor = APP_CONFIG.whiteGrayColor;
        _detailLB.textColor = APP_CONFIG.whiteGrayColor;
    }else {
        _titleLB.textColor = [UIColor colorWithRGB:177 g:122 b:38];
        _detailLB.textColor = [UIColor colorWithRGB:177 g:122 b:38];
    }
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
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:25];
        _titleLB.text = @"你想干嘛呢？";
        [_titleLB sizeToFit];
        
        _detailLB = [[UILabel alloc] init];
        _detailLB.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        _detailLB.text = @"一个人的时候";
        [_detailLB sizeToFit];
        
        [self addSubview:_titleLB];
        [self addSubview:_detailLB];
    }
    return self;
}

@end

