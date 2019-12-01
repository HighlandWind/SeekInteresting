//
//  GJNormalTBVCell.h
//  ZHYK
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseTableViewCell.h"
#import "GJNormalCellModel.h"

@interface GJNormalTBVCell : GJBaseTableViewCell

@property (strong, nonatomic) GJNormalCellModel *cellModel;

- (void)settingShowSpeatLine:(BOOL)show;
- (void)settingShowSpeatLine:(BOOL)show withColor:(UIColor *)color;
- (void)centerTitle;

@end
