//
//  GJHomeManager.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJHomeManager.h"

@implementation GJHomeManager

- (void)requestGetHomePlayCategorySuccess:(void (^)(NSArray<GJHomeEventsModel *> *))success failure:(HTTPTaskFailureBlock)failure {
    NSString *token = APP_USER.userInfo.token ? APP_USER.userInfo.token : @"";
    [[GJHttpNetworkingManager sharedInstance] requestGetWithPathUrl:Event_Data andParaDic:@{@"token":token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSArray <GJHomeEventsModel *> *models = [NSArray yy_modelArrayWithClass:GJHomeEventsModel.class json:response];
        success(models);
    } andFailedCallback:failure];
}

- (void)requestGetHomePlayContentParam:(GJHomeEventsDetailRequest *)param success:(void (^)(NSArray<GJHomeEventsDetailModel *> *))success failure:(HTTPTaskFailureBlock)failure {
    param.token = APP_USER.userInfo.token ? APP_USER.userInfo.token : @"";
    NSDictionary *p = [param yy_modelToJSONObject];
    
    [[GJHttpNetworkingManager sharedInstance] requestGetWithPathUrl:Event_Data_Detail andParaDic:p andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        NSArray <GJHomeEventsDetailModel *> *models = [NSArray yy_modelArrayWithClass:GJHomeEventsDetailModel.class json:response];
        success(models);
    } andFailedCallback:failure];
}

@end
