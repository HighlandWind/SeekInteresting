//
//  GJLoginController.h
//  SeekInteresting
//
//  Created by LiuGJ on 2018/3/29.
//  Copyright © 2018年 LiuGJ. All rights reserved.
//

#import "GJBaseViewController.h"

typedef void(^LoginSuccessBlcok)(void);
typedef void(^LogoutSuccessBlcok)(void);

@interface GJLoginController : GJBaseViewController

// 需要登录的地方使用此方法检测 并弹出登录界面 业务逻辑在 sucess 处理
+ (BOOL)needLoginPresentWithVC:(UIViewController *)controller loginSucessBlcok:(LoginSuccessBlcok)success;

// 访客登录
+ (BOOL)needLoginSucessBlcok:(LoginSuccessBlcok)success;

// 登出
+ (void)logOutPresentLoginControllerByVC:(UIViewController *)controller loginSucessBlcok:(LogoutSuccessBlcok)success;

@end
