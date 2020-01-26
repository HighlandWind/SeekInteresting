//
//  GJLoginView.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/19.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJLoginView : UIView

@property (nonatomic, copy) void (^blockClickRegister)(void);
@property (nonatomic, copy) void (^blockClickLogin)(NSString *phone, NSString *code);
@property (nonatomic, copy) void (^blockClickCode)(NSString *phone);
@property (nonatomic, copy) void (^blockClickProtocol)(void);
@property (nonatomic, copy) void (^blockClickWechat)(void);

@end

NS_ASSUME_NONNULL_END
