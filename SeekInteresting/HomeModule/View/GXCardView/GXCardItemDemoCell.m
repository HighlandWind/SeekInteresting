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
        [self addSubview:_imageV];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
