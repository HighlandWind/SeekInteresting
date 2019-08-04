//
//  GJBaseTableViewCell.h
//  ZHYK
//
//  Created by hsrd on 2018/3/19.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJBaseTableViewCell : UITableViewCell
+ (NSString *)reuseIndentifier;
- (void)commonInit;
+ (UITableViewCellStyle)expectingStyle;
- (void)showBottomLine;
@end
