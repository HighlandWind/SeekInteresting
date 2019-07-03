//
//  GJSeekEventController.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/14.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJCustomPresentController.h"

@class GJHomeEventsModel;

@interface GJSeekEventController : GJCustomPresentController

@property (nonatomic, strong) NSArray <GJHomeEventsModel *> *eventsModel;

@end
