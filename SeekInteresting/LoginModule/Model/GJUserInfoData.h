//
//  GJUserInfoData.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJUserInfoData : NSObject <NSCoding>

@property (nonatomic, strong) NSString *token;

// GET
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *birthdate;
@property (nonatomic, strong) NSString *address;

// POST
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *language;   // zh_CN

@end
