//
//  GJHomeDetailBtmView.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/25.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeDetailBtmView.h"

@implementation GJHomeDetailBtmView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.borderColor = APP_CONFIG.separatorLineColor.CGColor;
    self.borderWhich = LGJViewBorderTop;
}

- (void)btnClick:(UIButton *)btn {
    NSInteger tag = btn.tag - 100;
    if (tag == 1) {
        [btn shakeViewCallback:nil];
    }
    BLOCK_SAFE(_blockClickBtnIdx)(tag);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray <NSString *> *btnArr = @[@"xiayige", @"like_shi", @"wechat_black", @"zhuanfa"];
        CGFloat w = 60;
        CGFloat h = 48;
        [btnArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(SCREEN_W - (btnArr.count - idx) * w, 1, w, h);
            btn.tag = 100 + idx;
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            if ([obj isEqualToString:@"wechat_black"]) {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
            }else if ([obj isEqualToString:@"xiayige"]) {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 0)];
            }else {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(14, 0, 14, 0)];
            }
            [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }];
    }
    return self;
}

@end
