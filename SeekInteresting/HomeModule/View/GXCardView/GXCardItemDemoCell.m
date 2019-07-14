//
//  GXCardItemDemoCell.m
//  GXCardViewDemo
//
//  Created by Gin on 2018/8/3.
//  Copyright © 2018年 gin. All rights reserved.
//

#import "GXCardItemDemoCell.h"

@implementation GXCardItemDemoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageV = [[UIImageView alloc] init];
        _imageV.hidden = YES;
        
        _topView = [GJSeekEatTopView installType: SelectPageType_Event];
        
        [self addSubview:self.imageV];
        [self addSubview:self.topView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = SCREEN_W - AdaptatSize(80);
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(w);
        make.centerX.bottom.equalTo(self);
    }];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self).with.offset(-AdaptatSize(20));
        make.top.equalTo(self).with.offset(AdaptatSize(20));
        make.height.mas_equalTo(AdaptatSize(65));
    }];
}

@end
