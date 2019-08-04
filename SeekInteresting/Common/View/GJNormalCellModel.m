//
//  GJNormalCellModel.m
//  ZHYK
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJNormalCellModel.h"

@implementation GJNormalCellModel
+(GJNormalCellModel *)cellModelTitle:(NSString *)title detail:(NSString *)detail imageName:(NSString *)imageName acessoryType:(UITableViewCellAccessoryType)acessoryType {
    GJNormalCellModel *cellModel = [[GJNormalCellModel alloc] init];
    cellModel.title = title;
    cellModel.detail = detail;
    cellModel.imgName = imageName;
    cellModel.acessoryType = acessoryType;
    return cellModel;
}
@end
