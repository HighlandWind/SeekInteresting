//
//  GJMineSettingVC.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJCustomPresentController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GJMineSettingVC : GJCustomPresentController

@property (nonatomic, copy) void (^blockClickLogout)(void);

@end

NS_ASSUME_NONNULL_END
