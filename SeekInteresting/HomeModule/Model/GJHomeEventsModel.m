//
//  GJHomeEventsModel.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJHomeEventsModel.h"

@implementation GJHomeEventsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation GJHomeEventsData

@end

@implementation GJHomeEventsDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : GJHomeEventsData.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end


@implementation GJHomeEventsDetailRequest

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

+ (GJHomeEventsDetailRequest *)dataWithID:(NSString *)ID token:(NSString *)token format:(NSString *)format fields:(NSString *)fields page:(NSInteger)page perpage:(NSInteger)perpage weather:(NSString *)weather areacode:(NSString *)areacode sort:(NSString *)sort expand:(NSString *)expand {
    GJHomeEventsDetailRequest *d = [GJHomeEventsDetailRequest new];
    d.ID = ID;
    d.token = token;
    d.format = format;
    d.fields = fields;
    d.page = page;
    d.perpage = perpage;
    d.weather = weather;
    d.areacode = areacode;
    d.sort = sort;
    d.expand = expand;
    return d;
}

@end
