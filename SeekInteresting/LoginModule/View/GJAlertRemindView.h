//
//  GJAlertRemindView.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/19.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJAlertRemindView : UIButton

@property (nonatomic, copy) void (^blockClickSure)(void);

+ (void)showAlertBlock:(void (^)(void))sure;

@end

NS_ASSUME_NONNULL_END
