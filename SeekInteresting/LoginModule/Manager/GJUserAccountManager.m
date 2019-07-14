//
//  GJUserAccountManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJUserAccountManager.h"
#import "GJUserDefaults.h"

#define UserInfoModelFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userInfo.data"]

NSString *const kUserLoginStatuNotice = @"com.lgj.UserLoginStatuNotice";

@implementation GJUserAccountManager
SYNTHESIZE_SINGLETON_FOR_CLASS(GJUserAccountManager)

- (instancetype)init {
    if (self = [super init]) {
        self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoModelFile];
//        self.regionData = [NSKeyedUnarchiver unarchiveObjectWithFile:RegionDataFile];
    }
    return self;
}

-(void)saveLoginUserInfo:(GJUserInfoData *)userInfo {
    if (self.userInfo) {
        self.userInfo = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:UserInfoModelFile error:nil];
    }
    self.userInfo = userInfo;
    [NSKeyedArchiver archiveRootObject:self.userInfo toFile:UserInfoModelFile];
}

- (BOOL)isLoginStatus {
    if (self.userInfo) {
        return YES;
    }
    return NO;
}

-(void)loginOut {
    self.userInfo = nil;
    [[NSFileManager defaultManager] removeItemAtPath:UserInfoModelFile error:nil];
    
//    [GJUserDefaults removeValueBy:HTTP_SESSION_ID];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginStatuNotice object:@(NO)];
    
    // background setting id
//    [GJLauncherApi  requestAppVersionCodeUpdateWithSuccess:NULL failure:NULL];
//    [JPUSHService setTags:[NSSet setWithObject:@"buyer"] completion:nil seq:0];
//    [JPUSHService deleteAlias:nil seq:1];
    
}

- (void)loginSucess:(NSDictionary *)info {
    self.userInfo  = [GJUserInfoData yy_modelWithJSON:info];
    [self saveLoginUserInfo:self.userInfo];
}

// 省市区数据
//-(void)saveRegionData:(GJRegionData *)regionData {
//    if (self.regionData) {
//        self.regionData = nil;
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        [fileManager removeItemAtPath:RegionDataFile error:nil];
//    }
//    self.regionData = regionData;
//    [NSKeyedArchiver archiveRootObject:self.regionData toFile:RegionDataFile];
//}
//
- (void)clearRegionData {
//    self.regionData = nil;
//    [[NSFileManager defaultManager] removeItemAtPath:RegionDataFile error:nil];
}

//- (NSArray *)getProvinces {
//    NSMutableArray *arr = @[].mutableCopy;
//    [APP_USER.regionData.data enumerateObjectsUsingBlock:^(Province * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arr addObject:obj.province_name];
//    }];
//    return arr;
//}
//
//- (NSArray *)getCityInProvince:(Province *)province {
//    NSMutableArray *arr = @[].mutableCopy;
//    [province.city enumerateObjectsUsingBlock:^(City * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.city_name) {
//            [arr addObject:obj.city_name];
//        }else {
//            [arr addObject:province.province_name];
//        }
//    }];
//    return arr;
//}
//
//- (NSArray *)getDistrictInCity:(City *)city {
//    NSMutableArray *arr = @[].mutableCopy;
//    [city.district enumerateObjectsUsingBlock:^(District * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arr addObject:obj.district_name];
//    }];
//    return arr;
//}

@end
