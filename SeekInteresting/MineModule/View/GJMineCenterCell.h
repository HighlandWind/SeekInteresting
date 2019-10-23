//
//  GJMineCenterCell.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/8/4.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GJMineCenterCell : GJBaseTableViewCell

@property(nonatomic, copy) void (^blockClickMineInfo)(void);
@property(nonatomic, copy) void (^blockClickLikes)(void);
@property(nonatomic, copy) void (^blockClickStar)(void);
@property(nonatomic, copy) void (^blockClickHistory)(void);

@property (nonatomic, strong) NSString *model;

@end

NS_ASSUME_NONNULL_END
