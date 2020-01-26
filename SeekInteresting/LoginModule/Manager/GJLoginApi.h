//
//  GJLoginApi.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDeviceIdentifier.h"
#import "GJUserDeviceInfo.h"
#import "GJUserScanHistoryData.h"

@interface GJLoginApi : NSObject

/**
 用户认证 - 终端获取token（IOS、Android）
 */
- (void)loginWithVisitorSuccess:(HTTPTaskSuccessBlock)successBlock
                        failure:(HTTPTaskFailureBlock)failureBlock;

/**
 通过手机号、验证码登录
 
 @param telePhone 手机号
 @param smsCode 手机收到的验证码，如未传递此参数则为验证码发送。24小时内只能发送5条验证码，如认证成功，则重置
 */
- (void)loginByTelePhone:(NSString *)telePhone
                 smsCode:(NSString *)smsCode
                 success:(HTTPTaskSuccessBlock)successBlock
                 failure:(HTTPTaskFailureBlock)failureBlock;

- (void)loginSendPhoneCode:(NSString *)smsCode
                   success:(HTTPTaskSuccessBlock)successBlock
                   failure:(HTTPTaskFailureBlock)failureBlock;

/**
 用户信息（获取）
 */
- (void)requestGetUserInfo:(void (^)(void))success;

/**
 用户信息（更新）

 @param param 用户信息
 */
- (void)requestPostUserInfoParam:(GJUserInfoData *)param
                         success:(HTTPTaskSuccessBlock)successBlock
                         failure:(HTTPTaskFailureBlock)failureBlock;

/**
 用户设备信息（查询）
 */
- (void)requestGetUserDeviceInfoSuccess:(void (^)(GJUserDeviceInfo *info))successBlock
                                failure:(HTTPTaskFailureBlock)failureBlock;

/**
 用户设备信息（更新）
 
 @param param 设备参数
 */
- (void)requestPostUserDeviceInfoParam:(GJUserDeviceInfo *)param
                               success:(HTTPTaskSuccessBlock)successBlock
                               failure:(HTTPTaskFailureBlock)failureBlock;

/**
 上传用户浏览记录
 
 @param params json数组字符串：用户未浏览Play分类json，id：分类id，time：跳过时的时间戳
 */
- (void)requestPostUserHistoryParam:(NSArray <GJUserScanHistoryData *> *)params
                            success:(HTTPTaskSuccessBlock)successBlock
                            failure:(HTTPTaskFailureBlock)failureBlock;

@end
