//
//  GJHomeCardView.h
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/21.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GJHomeEventsModel;

@interface GJHomeCardView : UIImageView

@property (nonatomic, strong) GJHomeEventsModel *model;
@property (nonatomic, assign) CGRect initRect;
@property (nonatomic, assign) CGRect frontRect;
@property (nonatomic, assign) CGRect backRect;
@property (nonatomic, assign) CGRect nextRect;
@property (nonatomic, assign) CGRect lastRect;
@property (nonatomic, assign) CGFloat ratio;

- (void)moveChangeWidth:(CGFloat)dis dcY:(CGFloat)dcy cX:(CGFloat)cx;

@end

NS_ASSUME_NONNULL_END
