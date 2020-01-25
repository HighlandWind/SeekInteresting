//
//  GJHomeTabbarView.h
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/20.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJHomeTabbarView : UIView

+ (GJHomeTabbarView *)install;

@end

@interface GJGraduateColorView : UIView

- (void)setGraduteColorTop:(UIColor *)top btm:(UIColor *)btm;

@end

NS_ASSUME_NONNULL_END
