//
//  GJNormalCellModel.h
//  ZHYK
//
//  Created by hsrd on 2018/3/20.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJBaseModel.h"

@interface GJNormalCellModel : GJBaseModel
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * detail;
@property (strong, nonatomic) NSString * imgName;
@property (assign, nonatomic) UITableViewCellAccessoryType acessoryType;
@property (copy, nonatomic) void(^didSelectBlock)(NSIndexPath *indexPath);

+(GJNormalCellModel *)cellModelTitle:(NSString *)title detail:(NSString *)detail imageName:(NSString *)imageName acessoryType:(UITableViewCellAccessoryType)acessoryType;
@end
