//
//  GJHomeSelectBtn.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/3.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJHomeSelectBtn : UIButton

- (instancetype)initWithType:(SelectPageType)pageType;

@property (nonatomic, assign) BOOL isMan;
@property (nonatomic, copy) void (^blockClickGoto)(void);

@end

@interface GJHomeTopView : UIView

@property (nonatomic, assign) BOOL isMan;
+ (GJHomeTopView *)install;

@end
