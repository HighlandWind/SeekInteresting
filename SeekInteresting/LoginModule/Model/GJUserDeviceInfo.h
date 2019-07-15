//
//  GJUserDeviceInfo.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/7/15.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJUserDeviceInfo : NSObject

@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *screenWidth;
@property (nonatomic, strong) NSString *screenHeight;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *system;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *fontSize;

@end
