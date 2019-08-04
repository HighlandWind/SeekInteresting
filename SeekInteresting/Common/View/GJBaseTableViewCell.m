//
//  GJBaseTableViewCell.m
//  ZHYK
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"

@interface GJBaseTableViewCell ()

@end

@implementation GJBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:[[self class] expectingStyle] reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {}

+ (NSString *)reuseIndentifier {
    return [NSString stringWithFormat:@"com.lgj.%@",[self class]];
}

+ (UITableViewCellStyle)expectingStyle {
    return UITableViewCellStyleDefault;
}

- (void)showBottomLine {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APP_CONFIG.separatorLineColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-AdaptatSize(15));
        make.left.equalTo(self).with.offset(AdaptatSize(15));
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

@end
