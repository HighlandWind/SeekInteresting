//
//  GJHomeEmojView.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/25.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeEmojView.h"
#import "GJMineCenterNoCell.h"

@interface GJEmojButton : UIButton
@property (nonatomic, strong) UIImageView *btnImg;
@property (nonatomic, strong) UILabel *btnLB;
@end

@implementation GJEmojButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        _btnImg = [[UIImageView alloc] init];
        _btnImg.userInteractionEnabled = NO;
        _btnImg.contentMode = UIViewContentModeScaleAspectFit;
        
        _btnLB = [[UILabel alloc] init];
        _btnLB.font = [APP_CONFIG appAdaptFontOfSize:14];
        _btnLB.textColor = APP_CONFIG.grayTextColor;
        
        [self addSubview:_btnImg];
        [self addSubview:_btnLB];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_btnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY).with.offset(0);
        make.width.height.mas_equalTo(30);
    }];
    [_btnLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_centerY).with.offset(5);
    }];
}

@end


@interface GJHomeEmojView ()
@property (nonatomic, copy) void (^blockClick)(NSInteger idx);
@end

@implementation GJHomeEmojView

+ (void)showContext:(UIViewController *)vc block:(nonnull void (^)(NSInteger))block {
    GJHomeEmojView *v = [[GJHomeEmojView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    v.blockClick = block;
    [vc.tabBarController.view addSubview:v];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        self.userInteractionEnabled = YES;
        self.tag = 999;
        UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tClick)];
        t.numberOfTapsRequired = 1;
        [self addGestureRecognizer:t];
        
        UIButton *view = [[UIButton alloc] init];
        if (IPHONE_X) {
            view.frame = CGRectMake(0, 0, SCREEN_W - 70, 170);
            view.center = CGPointMake(self.center.x, self.center.y + 10);
        }else {
            view.frame = CGRectMake(0, 0, SCREEN_W - 100, 150);
            view.center = self.center;
        }
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        [self addSubview:view];
        
        NSArray *titleArr = @[@"失眠", @"无聊", @"开心", @"沮丧", @"忧伤", @"生气", @"寂寞", @"面无表情"];
        NSArray *imageArr = @[@"失眠黑", @"无聊黑", @"开心黑", @"沮丧黑", @"忧伤黑", @"生气黑", @"寂寞黑", @"面无表情黑"];
        CGFloat w = 64;
        if (IPHONE_X) w += 7;
        CGFloat h = view.height / 2;
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GJEmojButton *btn = [[GJEmojButton alloc] init];
            if (idx <= 3) {
                btn.frame = CGRectMake(idx * w + 10, 10, w, h);
            }else {
                btn.frame = CGRectMake((idx - 4) * w + 10, h, w, h);
            }
            btn.tag = 200 + idx;
            btn.btnImg.image = [UIImage imageNamed:imageArr[idx]];
            btn.btnLB.text = obj;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }];
    }
    return self;
}

- (void)btnClick:(UIButton *)btn {
    [self tClick];
    BLOCK_SAFE(_blockClick)(btn.tag - 200);
}

- (void)tClick {
    [[[GJFunctionManager CurrentTopViewcontroller].tabBarController.view viewWithTag:999] removeFromSuperview];
}

@end
