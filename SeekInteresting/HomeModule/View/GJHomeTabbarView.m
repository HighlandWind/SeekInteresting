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
@end

@implementation GJHomeTabbarView

- (void)buttonClick:(UIButton *)btn {
    if (btn == _button1) {
        BLOCK_SAFE(_blockClickButton)(0);
    }
    if (btn == _button2) {
        BLOCK_SAFE(_blockClickButton)(1);
    }
    if (btn == _button3) {
        BLOCK_SAFE(_blockClickButton)(2);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
        make.top.bottom.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_W / 3);
    }];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.button2.mas_left);
    }];
    [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
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
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-1);
            make.centerX.equalTo(self);
        }];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(titleLB.mas_top).with.offset(-2);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

@end
