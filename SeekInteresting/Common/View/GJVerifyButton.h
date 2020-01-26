//
//  GJVerifyButton.h
//  ZHYK
//
//  Created by Arlenly on 2018/3/29.
//  Copyright © 2018年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJVerifyButton : UIButton

@property (copy, nonatomic) void(^clickBtnHandle)(void);

- (id)initWithFrame:(CGRect)frame verifyTitle:(NSString *)title;
- (void)showActive:(BOOL)show;
- (void)startEndTime;

@end
