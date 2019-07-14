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
    NSString *token = @"xZ0_o_vKawt-ftAHQK1Je7tXd361S1EJ";
    [[GJHttpNetworkingManager sharedInstance] requestGetWithPathUrl:Event_Data andParaDic:@{@"token":token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        
        NSArray <GJHomeEventsModel *> *models = [NSArray yy_modelArrayWithClass:GJHomeEventsModel.class json:response];
        
        success(models);
    } andFailedCallback:failure];
}

- (void)requestGetContentListSuccess:(void (^)(GJHomeEventsDetailModel *))success failure:(HTTPTaskFailureBlock)failure {
    NSString *token = @"xZ0_o_vKawt-ftAHQK1Je7tXd361S1EJ";
    [[GJHttpNetworkingManager sharedInstance] requestGetWithPathUrl:Event_Data_Detail andParaDic:@{@"token":token} andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        
        GJHomeEventsDetailModel *model = [GJHomeEventsDetailModel yy_modelWithJSON:response];
        
        success(model);
    } andFailedCallback:failure];
}

@end
