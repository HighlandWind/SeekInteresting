//
//  GJLoginApi.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJLoginApi.h"

@implementation GJLoginApi

- (void)loginWithVisitorSuccess:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSString *UDID = [HDeviceIdentifier deviceIdentifier];
    NSDictionary *para = @{@"code":UDID, @"type":@"ios"};
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Login_Get_Token andParaDic:para andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

- (void)loginByTelePhone:(NSString *)telePhone smsCode:(NSString *)smsCode success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    if (!telePhone) return;
    NSMutableDictionary *param = @{@"number":telePhone}.mutableCopy;
    if (smsCode) {
        [param addEntriesFromDictionary:@{@"code":smsCode}];
    }
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:Login_By_TelePhone andParaDic:param andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

@end
