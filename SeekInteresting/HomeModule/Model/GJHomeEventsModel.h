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


@interface GJHomeEventsDetailRequest : NSObject
@property (nonatomic, strong) NSString *token;  // 必须
@property (nonatomic, strong) NSString *ID;     // 必须
@property (nonatomic, strong) NSString *format; // 格式化数据，可选值json、xml，默认json
@property (nonatomic, strong) NSString *fields; // d,name  设置返回的字段，用“，”分割
@property (nonatomic, assign) NSInteger page;   // 天气情况json字符串  字段：areaCode： 地区行政编码（示例：110000） humidity： 相对湿度【无符号】（示例：80） temperature： 温度【摄氏度，无符号】（示例：23） weather： 天气现象（示例：晴） winddirection： 风向（示例：东南风） windpower： 风力【无符号】（示例：3）
@property (nonatomic, assign) NSInteger perpage;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *areacode;
@property (nonatomic, strong) NSString *sort;   // id  数据排序，字段 ： 正序；-字段 ：倒序

+ (GJHomeEventsDetailRequest *)dataWithID:(NSString *)ID token:(NSString *)token format:(NSString *)format fields:(NSString *)fields page:(NSInteger )page perpage:(NSInteger)perpage weather:(NSString *)weather areacode:(NSString *)areacode sort:(NSString *)sort;
@end
