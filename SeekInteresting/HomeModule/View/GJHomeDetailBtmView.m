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
    BLOCK_SAFE(_blockClickBtnIdx)(btn.tag - 100);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *btnArr = @[@"xiayige", @"like_shi", @"wechat_black", @"zhuanfa"];
        CGFloat w = 60;
        CGFloat h = 48;
        [btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(SCREEN_W - (btnArr.count - idx) * w, 1, w, h);
            btn.tag = 100 + idx;
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
            [btn setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }];
    }
    return self;
}

@end
