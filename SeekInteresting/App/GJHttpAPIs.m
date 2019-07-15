//
//  GJHttpAPIs.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJHttpAPIs.h"

@implementation GJHttpAPIs

// Login
NSString *const Login_Get_Token = @"user/app";
NSString *const Login_By_TelePhone = @"users";
NSString *const UserInfo = @"userinfo";
NSString *const UserDeviceInfo = @"user/devices";
NSString *const UploadUserHistory = @"user/history";

// Home
NSString *const Event_Data = @"play/category";
NSString *const Event_Data_Detail = @"play/content";

@end
