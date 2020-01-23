//
//  GJHomeCardView.h
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/21.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJHomeCardView : UIButton

@property (nonatomic, assign) CGRect orginRect;
@property (nonatomic, assign) CGRect frontRect;
@property (nonatomic, assign) CGRect backRect;
@property (nonatomic, assign) CGRect backRectF;
@property (nonatomic, assign) CGFloat ratio;
- (void)moveChangeWidth:(CGFloat)dis;

@end

NS_ASSUME_NONNULL_END
