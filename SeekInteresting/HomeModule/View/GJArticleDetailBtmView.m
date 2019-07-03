//
//  GJArticleDetailBtmView.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJArticleDetailBtmView.h"

@implementation GJArticleDetailBtmView

- (void)buttonClick:(UIButton *)btn {
    BLOCK_SAFE(_blockClickButtonIdx)(btn.tag - 100);
}

- (CGFloat)height {
    return 50;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 1)];
        topLine.backgroundColor = [UIColor colorWithRGB:242 g:242 b:242];
        [self addSubview:topLine];
        
        NSArray <NSString *> *btnTitles = @[@"喜欢", @"换类型", @"下一个", @"转发"];
        __block CGFloat width = SCREEN_W / btnTitles.count;
        __block UIView *tmpV;
        
        [btnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [[UIButton alloc] init];
            button.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:11];
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
            [button setTitleColor:APP_CONFIG.darkTextColor forState:UIControlStateNormal];
            [button setTitleColor:APP_CONFIG.grayTextColor forState:UIControlStateHighlighted];
            [button setTitle:obj forState:UIControlStateNormal];
            button.tag = 100 + idx;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_wx"]];
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            imgV.userInteractionEnabled = NO;
            [self addSubview:imgV];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).with.offset(4);
                make.height.equalTo(self);
                make.width.mas_equalTo(width);
                if (tmpV) {
                    make.left.equalTo(tmpV.mas_right);
                }else {
                    make.left.equalTo(self);
                }
                tmpV = button;
            }];
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button);
                make.width.height.mas_equalTo(30);
                make.top.equalTo(button);
            }];
        }];
    }
    return self;
}

@end
