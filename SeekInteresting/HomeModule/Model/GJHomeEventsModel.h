//
//  GJHomeEventsModel.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJHomeEventsModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slogan;

@end


@interface GJHomeEventsDetailModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *media;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;

@end
