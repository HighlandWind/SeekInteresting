//
//  GJFeedbackTBVCell.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/12/1.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJFeedbackTBVCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AlertManager.h"
#import "SGImagePickerController.h"

@interface GJFeedbackTBVCell () <UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeLB;
@end

@implementation GJFeedbackTBVCell

- (void)commonInit {
    _textView = [UITextView new];
    _textView.delegate = self;
    _textView.font = [APP_CONFIG appAdaptFontOfSize:15];
    
    _placeLB = [UILabel new];
    _placeLB.text = @"请输入反馈内容";
    _placeLB.font = [APP_CONFIG appAdaptFontOfSize:16];
    _placeLB.textColor = APP_CONFIG.grayTextColor;
    [_placeLB sizeToFit];
    
    [self.contentView addSubview:_textView];
}

- (CGFloat)height {
    return AdaptatSize(200);
}

- (NSString *)text {
    return _textView.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    _placeLB.hidden = textView.text.length != 0;
}

- (void)layoutSubviews {
    [self.contentView addSubview:_placeLB];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
    }];
    [_placeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView).with.offset(4);
        make.top.equalTo(self.textView).with.offset(7);
    }];
}

@end

@interface GJFeedbackTBVCell_2 ()
@property (nonatomic, strong) UIButton *addImgBtn;
@property (nonatomic, strong) UILabel *remindLB;
@end

@implementation GJFeedbackTBVCell_2

- (void)addImageBtnClick {
    __weak typeof(self)weakself = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
            [AlertManager showAlertTitle:@"提示" content:@"请前往设置->隐私->照片授权应用相册权限" viecontroller:self.context cancel:@"取消" sure:@"确定" cancelHandle:nil sureHandle:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
        }else {
            SGImagePickerController *pickerAlbum = [[SGImagePickerController alloc] init];
            pickerAlbum.maxCount = MAX_UPLOAD_IMAGES;
            // Thumbnails
            [pickerAlbum setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
                [weakself.readyToUploadImagesThumbnails addObjectsFromArray:thumbnails];
                [weakself judgeUploadLimitAndRefresh];
            }];
            // Original images
            [pickerAlbum setDidFinishSelectImages:^(NSArray *images) {
                [weakself.readyToUploadImages addObjectsFromArray:images];
                if (weakself.readyToUploadImages.count > MAX_UPLOAD_IMAGES) {
                    weakself.readyToUploadImages = [weakself.readyToUploadImages subarrayWithRange:NSMakeRange(0, MAX_UPLOAD_IMAGES)].mutableCopy;
                }
            }];
            [self.context presentViewController:pickerAlbum animated:YES completion:nil];
        }
    }
}

- (void)judgeUploadLimitAndRefresh {
    if (_readyToUploadImagesThumbnails.count > MAX_UPLOAD_IMAGES) {
        _readyToUploadImagesThumbnails = [_readyToUploadImagesThumbnails subarrayWithRange:NSMakeRange(0, MAX_UPLOAD_IMAGES)].mutableCopy;
        ShowWaringAlertHUD([NSString stringWithFormat:@"最多上传%d张图片", MAX_UPLOAD_IMAGES], nil);
    }
    
    // 刷新页面
    
}

- (void)commonInit {
    _readyToUploadImages = @[].mutableCopy;
    _readyToUploadImagesThumbnails = @[].mutableCopy;
    
    _addImgBtn = [[UIButton alloc] init];
    [_addImgBtn setImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
    [_addImgBtn addTarget:self action:@selector(addImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _remindLB = [UILabel new];
    _remindLB.text = [NSString stringWithFormat:@"图片上传（最多%d张照片）", MAX_UPLOAD_IMAGES];
    _remindLB.textColor = APP_CONFIG.grayTextColor;
    _remindLB.font = [APP_CONFIG appAdaptFontOfSize:14];
    [_remindLB sizeToFit];
    
    [self addSubview:_addImgBtn];
}

- (CGFloat)height {
    return AdaptatSize(80);
}

- (void)layoutSubviews {
    [_addImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(10));
        make.top.equalTo(self).with.offset(AdaptatSize(10));
        make.width.height.mas_equalTo(AdaptatSize(60));
    }];
    [self addSubview:_remindLB];
    [_remindLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.addImgBtn.mas_right).with.offset(AdaptatSize(10));
        make.right.equalTo(self).with.offset(-AdaptatSize(10));
    }];
}

@end

@interface GJFeedbackTBVCell_3 ()
@property (nonatomic, strong) UILabel *contactLB;
@property (nonatomic, strong) UITextField *phoneTF;
@end

@implementation GJFeedbackTBVCell_3

- (void)commonInit {
    _contactLB = [UILabel new];
    _contactLB.text = @"联系方式（选填）：";
    _contactLB.textColor = APP_CONFIG.darkTextColor;
    _contactLB.font = [APP_CONFIG appAdaptFontOfSize:16];
    [_contactLB sizeToFit];
    
    _phoneTF = [UITextField new];
    _phoneTF.placeholder = @"手机号码、Email、QQ";
    _phoneTF.font = [UIFont systemFontOfSize:16];
    _phoneTF.keyboardType = UIKeyboardTypeEmailAddress;
}

- (CGFloat)height {
    return AdaptatSize(65);
}

- (void)layoutSubviews {
    [self.contentView addSubview:_contactLB];
    [self.contentView addSubview:_phoneTF];
    
    // ContentHuggingPriority                 ==> 表示当前的Label的内容不想被拉伸
    // ContentCompressionResistancePriority   ==> 表示当前的Label的内容不想被收缩
    [_contactLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_contactLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(AdaptatSize(15));
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.contactLB.mas_right);
        make.right.equalTo(self).with.offset(-AdaptatSize(10));
    }];
}

@end

@interface GJFeedbackTBVCell_4 ()
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation GJFeedbackTBVCell_4

- (void)submitBtnClick {
    
}

- (void)commonInit {
    _submitBtn = [[UIButton alloc] init];
    _submitBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
    [_submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[UIColor colorWithRGB:230 g:240 b:255]];
    _submitBtn.layer.cornerRadius = AdaptatSize(44) / 2;
    _submitBtn.clipsToBounds = YES;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_submitBtn];
}

- (CGFloat)height {
    return AdaptatSize(80);
}

- (void)layoutSubviews {
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AdaptatSize(44));
        make.center.equalTo(self);
        make.left.equalTo(self).with.offset(AdaptatSize(50));
        make.right.equalTo(self).with.offset(-AdaptatSize(50));
    }];
}

@end
