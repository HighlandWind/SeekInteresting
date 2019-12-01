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
@end

@interface GJFeedbackTBVCell_2 : GJBaseTableViewCell
@property (nonatomic, strong) UIViewController *context;
@property (nonatomic, strong) NSMutableArray *readyToUploadImagesThumbnails;    // 刷新页面
@property (nonatomic, strong) NSMutableArray *readyToUploadImages;              // 上传原图
@end

@interface GJFeedbackTBVCell_3 : GJBaseTableViewCell

@end

@interface GJFeedbackTBVCell_4 : GJBaseTableViewCell

@end

NS_ASSUME_NONNULL_END
