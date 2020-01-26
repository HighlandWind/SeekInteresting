//
//  GJHomeTabbarView.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/20.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeTabbarView.h"

@interface CustomBtn : UIButton

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color image:(NSString *)image;

@end

@interface GJHomeTabbarView ()
@property (nonatomic, strong) CustomBtn *button1;
@property (nonatomic, strong) CustomBtn *button2;
@property (nonatomic, strong) CustomBtn *button3;
@property (nonatomic, strong) UIViewController *tabbarVC;
@end

@implementation GJHomeTabbarView

+ (GJHomeTabbarView *)installContext:(UIViewController *)vc {
    CGFloat height = vc.tabBarController.tabBar.frame.size.height + 1;
    GJHomeTabbarView *v = [[GJHomeTabbarView alloc] initWithFrame:CGRectMake(0, SCREEN_H - height, SCREEN_W, height)];
    v.hidden = YES;
    v.tabbarVC = vc;
    [vc.tabBarController addSubview:v];
    return v;
}

- (void)buttonClick:(UIButton *)btn {
    if (btn == _button1) {
        self.hidden = NO;
        _tabbarVC.tabBarController.selectedIndex = 0;
    }
    if (btn == _button2) {
        self.hidden = YES;
        _tabbarVC.tabBarController.selectedIndex = 1;
    }
    if (btn == _button3) {
        self.hidden = YES;
        _tabbarVC.tabBarController.selectedIndex = 2;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _button1 = [[CustomBtn alloc] initWithTitle:@"首页" color:[UIColor whiteColor] image:@"home"];
        _button2 = [[CustomBtn alloc] initWithTitle:@"任务" color:[UIColor lightTextColor] image:@"收藏W"];
        _button3 = [[CustomBtn alloc] initWithTitle:@"我的" color:[UIColor lightTextColor] image:@"我的W"];
        
        [_button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button1];
        [self addSubview:_button2];
        [self addSubview:_button3];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_W / 3);
    }];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.bottom.equalTo(self.button2);
        make.right.equalTo(self.button2.mas_left);
    }];
    [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.bottom.equalTo(self.button2);
        make.left.equalTo(self.button2.mas_right);
    }];
}

@end


@implementation CustomBtn

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color image:(NSString *)image
{
    self = [super init];
    if (self) {
        UILabel *titleLB = [[UILabel alloc] init];
        titleLB.text = title;
        titleLB.textColor = color;
        titleLB.font = [APP_CONFIG appAdaptFontOfSize:10];
        [titleLB sizeToFit];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:image];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:titleLB];
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(5);
            make.centerX.equalTo(self);
        }];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageV.mas_bottom);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

@end


@implementation GJGraduateColorView

- (void)setGraduteColorTop:(UIColor *)top btm:(UIColor *)btm {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [self.layer insertSublayer:gradient atIndex:0];
    gradient.colors = @[(__bridge id)top.CGColor, (__bridge id)btm.CGColor];
    gradient.locations = @[@0,@1];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1.0);
    gradient.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    [self.layer insertSublayer:gradient atIndex:0];
//    gradient.colors = @[(__bridge id)[UIColor colorWithHexRGB:@"#ff7840"].CGColor, (__bridge id)[UIColor colorWithHexRGB:@"#ff3936"].CGColor];
//    gradient.locations = @[@0,@1];
//    gradient.startPoint = CGPointMake(0, 1);
//    gradient.endPoint = CGPointMake(1.0, 1.0);
//    gradient.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
