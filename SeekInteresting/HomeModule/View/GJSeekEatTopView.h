//
//  GJSeekEatTopView.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/15.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJSeekEatTopView : UIView

+ (GJSeekEatTopView *)installTitle:(NSString *)title detail:(NSString *)detail type:(SelectPageType)pageType;

@end

@interface GJSeekLRBtn : UIButton

- (instancetype)initLeft:(NSString *)left right:(NSString *)right type:(SelectPageType)pageType;

@property (nonatomic, copy) void (^blockClickLeft)(void);
@property (nonatomic, copy) void (^blockClickRight)(void);

@end
