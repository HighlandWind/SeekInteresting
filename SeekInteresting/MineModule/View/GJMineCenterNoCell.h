//
//  GJMineCenterNoCell.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/21.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GJMineCenterNoCell : GJBaseTableViewCell

@property(nonatomic, copy) void (^blockClickLogin)(void);

@end

@interface GJCustomNoButton : UIButton

@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) CGFloat image_edge;
@property (nonatomic, strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
