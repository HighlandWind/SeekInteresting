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
 Play分类
 */
- (void)requestGetHomePlayCategorySuccess:(void (^)(NSArray <GJHomeEventsModel *> *data))success
                                  failure:(HTTPTaskFailureBlock)failure;

/**
 Play内容详情
 */
- (void)requestGetHomePlayContentParam:(GJHomeEventsDetailRequest* )param
                               success:(void (^)(NSArray <GJHomeEventsDetailModel *> *data))success
                                failure:(HTTPTaskFailureBlock)failure;

@end
