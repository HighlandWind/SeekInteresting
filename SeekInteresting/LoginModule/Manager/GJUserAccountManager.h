//
//  GJUserAccountManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/17.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJUserInfoData.h"
//#import "GJRegionData.h"

UIKIT_EXTERN NSString *const kUserLoginStatuNotice;
#define APP_USER  [GJUserAccountManager sharedGJUserAccountManager]

@interface GJUserAccountManager : NSObject
DECLARE_SINGLETON_FOR_CLASS(GJUserAccountManager)

/**
 *  当前登陆用户信息
 */
@property (nonatomic, strong) GJUserInfoData *userInfo;


/**
 省市区数据
 */
//@property (nonatomic, strong) GJRegionData *regionData;
//- (NSArray *)getProvinces;
//- (NSArray *)getCityInProvince:(Province *)province;
//- (NSArray *)getDistrictInCity:(City *)city;


/**
 保存、清除省市区数据
 */
//-(void)saveRegionData:(GJRegionData *)regionData;
- (void)clearRegionData;

/**
 *  保存登陆用户信息
 *
 *  @param userInfo 用户信息
 */
- (void)saveLoginUserInfo:(GJUserInfoData *)userInfo;

/**
 *  获取登录状态
 *
 *  @return 是否登录
 */
- (BOOL)isLoginStatus;

/**
 *  退出登录
 */
- (void)loginOut;

/**
 登录成功处理用户信息 进行本地保存处理
 
 @param info 用户信息
 */
- (void)loginSucess:(NSDictionary *)info;

@end
