//
//  AppDelegate+Config.m
//  ZHYK
//
//  Created by hsrd on 2018/3/16.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "AppDelegate+Config.h"
#import "GJRootViewController.h"
#import "AlertManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CoreTelephony/CTCellularData.h>
//#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation AppDelegate (Config)

- (void)setupMainInterface {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    UIViewController *rootVC;
    rootVC = [[GJRootViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}

- (void)setupThirdApy {
//    [AMapServices sharedServices].apiKey = AMap_APPKEY;
    
    /* UMSocial */
//    [[UMSocialManager defaultManager] openLog:YES];
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UMeng_APPKEY];
    [self configUSharePlatforms];
    
    /* IQKeyboardManager */
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
//    [WXApi registerApp:WeChat_APPKEY];
}

- (void)setupUnify {
    APP_CONFIG = [[GJAppConfigure alloc] init];
}

- (void)checkNetwork {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            UIViewController *vc = [GJFunctionManager CurrentTopViewcontroller];
            if (vc.presentingViewController) {
                [vc.presentingViewController dismissViewControllerAnimated:YES completion:^{
                    [self showNetworkFailureAlert];
                }];
            }else {
                [self showNetworkFailureAlert];
            }
        }
    }];
    [manager startMonitoring];
}

- (void)showNetworkFailureAlert {
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    [AlertManager showAlertTitle:[NSString stringWithFormat:@"已为“%@”关闭蜂窝移动数据", name] content:@"您可以在“设置”中为此应用打开蜂窝移动数据" viecontroller:nil cancel:@"设置" sure:@"好" cancelHandle:^{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } sureHandle:^{
    }];
}

#pragma mark - UMSocial paltform settings.
- (void)configUSharePlatforms {
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
//                                          appKey:WeChat_APPKEY
//                                       appSecret:WeChat_SECRET
//                                     redirectURL:WeChat_REDIRECT];

//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine
//                                          appKey:WeChat_APPKEY
//                                       appSecret:WeChat_SECRET
//                                     redirectURL:WeChat_REDIRECT];

//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
//                                          appKey:QQ_APPID
//                                       appSecret:QQ_APPKEY
//                                     redirectURL:QQ_REDIRECT];
}

- (BOOL)handelThirePayOpenURL:(NSURL *)url {
    BOOL ret = NO;
    if ([url.host isEqualToString:@"safepay"]) {
        // Jump to Alipay and handle pay result.
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:AliPaySucessNotice object:resultDic];
//        }];
        ret = YES;
    }
    if ([url.host isEqualToString:@"pay"]) {
//        ret = [WXApi handleOpenURL:url delegate:[[GJWeChatPayModel alloc] init]];
    }
    
    return ret;
}


- (void)setupLogger {
    
}

@end

