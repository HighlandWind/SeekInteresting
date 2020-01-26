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
        // 手机收到的验证码，如未传递此参数则为验证码发送。24小时内只能发送5条验证码，如认证成功，则重置
        [param addEntriesFromDictionary:@{@"code":smsCode}];
    }
    [[GJHttpNetworkingManager sharedInstance] requestAllDataPostWithPathUrl:Login_By_TelePhone andParaDic:param andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

- (void)loginSendPhoneCode:(NSString *)smsCode success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    
}

- (void)requestGetUserInfo:(void (^)(void))success {
    NSMutableDictionary *param = @{}.mutableCopy;
    if (APP_USER.userInfo.token) {
        [param addEntriesFromDictionary:@{@"token":APP_USER.userInfo.token}];
    }
    // 可选参数：format、fields(id,name-设置返回的字段，用“，”分割)
    
    [[GJHttpNetworkingManager sharedInstance] requestGetWithPathUrl:UserInfo andParaDic:param andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJUserInfoData *info = [GJUserInfoData yy_modelWithJSON:response];
        info.token = APP_USER.userInfo.token;
        [APP_USER saveLoginUserInfo:info];
        BLOCK_SAFE(success)();
    } andFailedCallback:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(success)();
    }];
}

- (void)requestPostUserInfoParam:(GJUserInfoData *)param success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    
    param.lastname = nil;
    param.firstname = nil;
    param.sex = nil;
    NSDictionary *p = [param yy_modelToJSONObject];
    // 可选参数：format、fields(id,name-设置返回的字段，用“，”分割)
    
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:UserInfo andParaDic:p andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

- (void)requestGetUserDeviceInfoSuccess:(void (^)(GJUserDeviceInfo *))successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSMutableDictionary *param = @{}.mutableCopy;
    if (APP_USER.userInfo.token) {
        [param addEntriesFromDictionary:@{@"token":APP_USER.userInfo.token}];
    }
    
    [[GJHttpNetworkingManager sharedInstance] requestGetWithPathUrl:UserDeviceInfo andParaDic:param andSucceedCallback:^(NSURLResponse *urlResponse, id response) {
        GJUserDeviceInfo *info = [GJUserDeviceInfo yy_modelWithJSON:response];
        successBlock(info);
    } andFailedCallback:failureBlock];
}

- (void)requestPostUserDeviceInfoParam:(GJUserDeviceInfo *)param success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    if (param.screenWidth) {
        [dic addEntriesFromDictionary:@{@"screen_width":param.screenWidth}];
    }
    if (param.screenHeight) {
        [dic addEntriesFromDictionary:@{@"screen_height":param.screenHeight}];
    }
    if (param.fontSize) {
        [dic addEntriesFromDictionary:@{@"font_size":param.fontSize}];
    }
    
    param.screenWidth = nil;
    param.screenHeight = nil;
    param.fontSize = nil;
    
    NSMutableDictionary *p = [param yy_modelToJSONObject];
    [p addEntriesFromDictionary:dic];
    if (APP_USER.userInfo.token) {
        [p addEntriesFromDictionary:@{@"token":APP_USER.userInfo.token}];
    }
    
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:UserDeviceInfo andParaDic:p andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

- (void)requestPostUserHistoryParam:(NSArray<GJUserScanHistoryData *> *)params success:(HTTPTaskSuccessBlock)successBlock failure:(HTTPTaskFailureBlock)failureBlock {
    NSMutableDictionary *ppp = @{}.mutableCopy;
    if (APP_USER.userInfo.token) {
        [ppp addEntriesFromDictionary:@{@"token":APP_USER.userInfo.token}];
    }
    [ppp addEntriesFromDictionary:@{@"format":@"json"}];
    // 数据类型："play.unread.category":  "用户跳过的分类（play）"
    [ppp addEntriesFromDictionary:@{@"method":@"play.unread.category"}];
    
    NSString *data = [params yy_modelToJSONString];
    [ppp addEntriesFromDictionary:@{@"data":data}];
    
    [[GJHttpNetworkingManager sharedInstance] requestFormTypePostWithPathUrl:UploadUserHistory andParaDic:ppp andSucceedCallback:successBlock andFailedCallback:failureBlock];
}

@end
