//
//  GJMineInfoTBVCell.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/12/9.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJMineInfoTBVCell.h"

@interface GJMineInfoTBVCell ()

@end

@implementation GJMineInfoTBVCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)commonInit {
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.font = [APP_CONFIG appFontOfSize:16];
    self.textLabel.textColor = [APP_CONFIG darkTextColor];
    self.detailTextLabel.textColor = [APP_CONFIG grayTextColor];
    self.detailTextLabel.font =[APP_CONFIG appFontOfSize:14];
}

- (void)showBottomLine {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APP_CONFIG.appBackgroundColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(1.5);
    }];
}

@end
