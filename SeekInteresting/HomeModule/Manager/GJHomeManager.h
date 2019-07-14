//
//  GJHomeManager.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJHomeEventsModel.h"

@interface GJHomeManager : NSObject

/**
 首页找点事做内容
 */
- (void)requestGetHomePlayCategorySuccess:(void (^)(NSArray <GJHomeEventsModel *> *data))success
                                  failure:(HTTPTaskFailureBlock)failure;

/**
 内容点赞（查询用户点赞的内容列表）
 */
- (void)requestGetContentListSuccess:(void (^)(GJHomeEventsDetailModel *data))success
                               failure:(HTTPTaskFailureBlock)failure;

@end
