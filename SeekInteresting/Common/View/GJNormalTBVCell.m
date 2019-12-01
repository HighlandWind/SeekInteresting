//
//  GJNormalTBVCell.m
//  ZHYK
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJNormalTBVCell.h"

@interface GJNormalTBVCell ()
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UILabel *titleCenterLB;
@end

@implementation GJNormalTBVCell

+ (UITableViewCellStyle)expectingStyle
{
    return UITableViewCellStyleValue1;
}

- (void)commonInit {
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.font = [APP_CONFIG appFontOfSize:14];
    self.textLabel.textColor = [APP_CONFIG darkTextColor];
    self.detailTextLabel.textColor = [APP_CONFIG grayTextColor];
    self.detailTextLabel.font =[APP_CONFIG appFontOfSize:14];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.hidden = YES;
    [self addSubview:self.bottomLine];
}

- (void)setCellModel:(GJNormalCellModel *)cellModel {
    _cellModel = cellModel;
    self.accessoryType = _cellModel.acessoryType;
    self.detailTextLabel.text = _cellModel.detail;
    self.textLabel.text = _cellModel.title;
    if (!JudgeContainerCountIsNull(cellModel.imgName)) {
        self.imageView.image = [UIImage imageNamed:cellModel.imgName];
    }
    if (_titleCenterLB) {
        _titleCenterLB.text = self.textLabel.text;
        _titleCenterLB.textColor = self.textLabel.textColor;
        _titleCenterLB.font = self.textLabel.font;
    }
}

- (void)settingShowSpeatLine:(BOOL)show {
    self.bottomLine.backgroundColor = APP_CONFIG.appBackgroundColor;
    self.bottomLine.hidden = !show;
}

- (void)settingShowSpeatLine:(BOOL)show withColor:(UIColor *)color {
    self.bottomLine.hidden = !show;
    self.bottomLine.backgroundColor = color;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

- (void)centerTitle {
    self.textLabel.hidden = YES;
    _titleCenterLB = [UILabel new];
    [self addSubview:_titleCenterLB];
    [_titleCenterLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

@end
