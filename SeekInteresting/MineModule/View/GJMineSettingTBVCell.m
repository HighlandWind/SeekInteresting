//
//  GJMineSettingTBVCell.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/12/1.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJMineSettingTBVCell.h"

@interface GJMineSettingTBVCell ()
@property(nonatomic, strong) UILabel *titleLB;
@property(nonatomic, strong) UILabel *detailLB;
@property(nonatomic, strong) UISwitch *switchBtn;
@property(nonatomic, strong) UIButton *fontBtn;
@end

@implementation GJMineSettingTBVCell

- (void)fontBtnClick {
    NSLog(@"font");
}

- (void)switchBtnClick:(UISwitch *)sender {
    NSLog(@"%d", sender.on);
}

- (void)commonInit {
    [super commonInit];
    
    self.textLabel.hidden = YES;
    self.detailTextLabel.hidden = YES;
    
    _titleLB = [UILabel new];
    _titleLB.textColor = self.textLabel.textColor;
    _titleLB.font = [APP_CONFIG appAdaptFontOfSize:18];
    
    _detailLB = [UILabel new];
    _detailLB.textColor = APP_CONFIG.appMainRedColor;
    _detailLB.font = [APP_CONFIG appAdaptFontOfSize:12];
    [_detailLB sizeToFit];
    
    _switchBtn = [UISwitch new];
    [_switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCellModel:(GJNormalCellModel *)cellModel {
    [super setCellModel:cellModel];
    _titleLB.text = cellModel.title;
    _detailLB.text = cellModel.detail;
    [self.contentView addSubview:_switchBtn];
    [self.contentView addSubview:_titleLB];
    if (_isFont) {
        _fontBtn = [UIButton new];
        _fontBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:14];
        [_fontBtn setTitleColor:APP_CONFIG.grayTextColor forState:UIControlStateNormal];
        [_fontBtn addTarget:self action:@selector(fontBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_fontBtn setTitle:cellModel.detail forState:UIControlStateNormal];
        [self.contentView addSubview:_fontBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    BOOL showDetail = !JudgeContainerCountIsNull(self.cellModel.detail);
    if (_isFont) {
        showDetail = NO;
        self.switchBtn.hidden = YES;
    }
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(15));
        if (showDetail) {
            make.bottom.equalTo(self.mas_centerY).with.offset(2);
        }else {
            make.centerY.equalTo(self);
        }
    }];
    if (showDetail) {
        [self.contentView addSubview:_detailLB];
        [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB).with.offset(AdaptatSize(11));
            make.top.equalTo(self.mas_centerY).with.offset(2);
        }];
    }
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-AdaptatSize(15));
    }];
    if (_isFont) {
        [_fontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).with.offset(-AdaptatSize(15));
        }];
    }
}


@end
