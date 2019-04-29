//
//  AppDelegate+Config.h
//  ZHYK
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//


#import "AppDelegate.h"
//#import <UMSocialCore/UMSocialCore.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (Config)

- (void)setupMainInterface;
- (void)setupThirdApy;
- (void)setupUnify;
- (BOOL)handelThirePayOpenURL:(NSURL *)url;
- (void)checkNetwork;
- (void)setupLogger;

@end
