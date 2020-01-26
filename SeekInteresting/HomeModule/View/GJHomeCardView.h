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
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *btmColor;

@property (nonatomic, assign) CGRect initRect;
@property (nonatomic, assign) CGRect frontRect;
@property (nonatomic, assign) CGRect backRect;
@property (nonatomic, assign) CGRect nextRect;
@property (nonatomic, assign) CGRect lastRect;
@property (nonatomic, assign) CGFloat ratio;

@property (nonatomic, copy) void (^blockClickCard)(void);

- (void)moveChangeWidth:(CGFloat)dis dcY:(CGFloat)dcy cX:(CGFloat)cx;

@end

@interface GJHomeRightBtn : UIButton

@end

NS_ASSUME_NONNULL_END
