//
//  GJLoginApi.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDeviceIdentifier.h"

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

@end
