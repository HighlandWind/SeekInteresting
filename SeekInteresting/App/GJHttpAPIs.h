//
//  GJHttpAPIs.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJHttpAPIs : NSObject

// Login
FOUNDATION_EXPORT NSString *const Login_Get_Token;
FOUNDATION_EXPORT NSString *const Login_By_TelePhone;

// Home
FOUNDATION_EXPORT NSString *const Event_Data;
FOUNDATION_EXPORT NSString *const Event_Data_Detail;

@end
