//
//  GJUserInfoData.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJUserInfoData.h"

@implementation GJUserInfoData

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.lastname forKey:@"lastname"];
    [encoder encodeObject:self.firstname forKey:@"firstname"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.birthdate forKey:@"birthdate"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.gender forKey:@"gender"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:self.province forKey:@"province"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.language forKey:@"language"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.token = [decoder decodeObjectForKey:@"token"];
        self.lastname = [decoder decodeObjectForKey:@"lastname"];
        self.firstname = [decoder decodeObjectForKey:@"firstname"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.birthdate = [decoder decodeObjectForKey:@"birthdate"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.gender = [decoder decodeObjectForKey:@"gender"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.province = [decoder decodeObjectForKey:@"province"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.language = [decoder decodeObjectForKey:@"language"];
    }
    return self;
}

@end
