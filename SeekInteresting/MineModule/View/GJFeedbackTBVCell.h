//
//  GJFeedbackTBVCell.h
//  SeekInteresting
//
//  Created by Arlenly on 2019/12/1.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJBaseTableViewCell.h"

// 最多可选择图片张数
#define MAX_UPLOAD_IMAGES 10

NS_ASSUME_NONNULL_BEGIN

@interface GJFeedbackTBVCell : GJBaseTableViewCell
@property (nonatomic, strong) NSString *text;
@property (nonatomic, copy) void (^blockRefreshSubmitBtn)(BOOL is);
@end

@interface GJFeedbackTBVCell_2 : GJBaseTableViewCell
@property (nonatomic, strong) UIViewController *context;
@property (nonatomic, strong) NSMutableArray *readyToUploadImages;              // 上传原图
@property (nonatomic, copy) void (^blockRefreshHeight)(void);
@end

@interface GJFeedbackTBVCell_3 : GJBaseTableViewCell
@property (nonatomic, strong) NSString *text;
@end

@interface GJFeedbackTBVCell_4 : GJBaseTableViewCell
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, copy) void (^blockClickSubmit)(void);
@end

NS_ASSUME_NONNULL_END
