//
//  GJHomeDetailVC.h
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/25.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJCustomPresentController.h"

NS_ASSUME_NONNULL_BEGIN

@class GJHomeEventsModel;

@interface GJHomeDetailVC : GJCustomPresentController

@property (nonatomic, strong) GJHomeEventsModel *model;

@end

NS_ASSUME_NONNULL_END
