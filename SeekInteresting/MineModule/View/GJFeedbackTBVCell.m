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

#define TAG_ADDED_IMAGES 999

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
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat btnHeight;
@property (nonatomic, assign) CGFloat edgeWidth;
@property (nonatomic, strong) NSMutableArray *readyThumbnails;    // 刷新页面
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
                [weakself.readyThumbnails addObjectsFromArray:thumbnails];
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
    if (_readyThumbnails.count > MAX_UPLOAD_IMAGES) {
        _readyThumbnails = [_readyThumbnails subarrayWithRange:NSMakeRange(0, MAX_UPLOAD_IMAGES)].mutableCopy;
        ShowWaringAlertHUD([NSString stringWithFormat:@"最多上传%d张图片", MAX_UPLOAD_IMAGES], nil);
    }
    NSLog(@"========%@", _readyThumbnails);
    
    // 刷新页面 2行x5列
    _remindLB.hidden = _readyThumbnails.count != 0;
    _addImgBtn.hidden = _readyThumbnails.count >= MAX_UPLOAD_IMAGES;
    for (int i = 0; i < self.contentView.subviews.count; i ++) {
        UIView *tmpV = self.contentView.subviews[i];
        if (tmpV.tag >= TAG_ADDED_IMAGES) {
            [tmpV removeFromSuperview];
        }
    }
    CGFloat column = 5;
    if (_readyThumbnails.count > 0 && _readyThumbnails.count <= MAX_UPLOAD_IMAGES) {
        if (_readyThumbnails.count < column) {
            for (int i = 0; i < _readyThumbnails.count; i ++) {
                [self addImageIndex:i x:_edgeWidth y:_edgeWidth image:_readyThumbnails[i]];
            }
            [self updateAddBtnLeft:_edgeWidth + _readyThumbnails.count * (_btnHeight + _edgeWidth) top:_edgeWidth];
        }
        if (_readyThumbnails.count >= column) {
            _cellHeight = AdaptatSize(150);
            BLOCK_SAFE(_blockRefreshHeight)();
            for (int i = 0; i < column; i ++) {
                [self addImageIndex:i x:_edgeWidth y:_edgeWidth image:_readyThumbnails[i]];
            }
            if (_readyThumbnails.count == column) {
                [self updateAddBtnLeft:_edgeWidth top:_edgeWidth * 2 + _btnHeight];
            }else {
                for (int i = column; i < _readyThumbnails.count; i ++) {
                    [self addImageIndex:i - column x:_edgeWidth y:_edgeWidth * 2 + _btnHeight image:_readyThumbnails[i]];
                }
                if (_readyThumbnails.count < MAX_UPLOAD_IMAGES) {
                    [self updateAddBtnLeft:_edgeWidth + (_readyThumbnails.count - column) * (_btnHeight + _edgeWidth) top:_edgeWidth * 2 + self.btnHeight];
                }
            }
        }
    }
}

- (void)updateAddBtnLeft:(CGFloat)left top:(CGFloat)top {
    [_addImgBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(top);
        make.left.equalTo(self).with.offset(left);
        make.width.height.mas_equalTo(self.btnHeight);
    }];
}

// 根据图片的x、y并添加UIImageView
- (void)addImageIndex:(int)index x:(int)x y:(int)y image:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.tag = TAG_ADDED_IMAGES + index;
    imageView.image = image;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.btnHeight);
        make.top.equalTo(self).with.offset(y);
        make.left.equalTo(self).with.offset(x + index * (self.btnHeight + x));
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellHeight = AdaptatSize(80);
        _btnHeight = AdaptatSize(60);
        _edgeWidth = AdaptatSize(10);
        
        _readyToUploadImages = @[].mutableCopy;
        _readyThumbnails = @[].mutableCopy;
        
        _addImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(_edgeWidth, _edgeWidth, _btnHeight, _btnHeight)];
        [_addImgBtn setImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
        [_addImgBtn addTarget:self action:@selector(addImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _remindLB = [UILabel new];
        _remindLB.textColor = APP_CONFIG.grayTextColor;
        _remindLB.font = [APP_CONFIG appAdaptFontOfSize:14];
        [_remindLB sizeToFit];
        
        [self addSubview:_remindLB];
        [self addSubview:_addImgBtn];
    }
    return self;
}

- (CGFloat)height {
    return _cellHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _remindLB.text = [NSString stringWithFormat:@"图片上传（最多%d张照片）", MAX_UPLOAD_IMAGES];
    [_remindLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addImgBtn);
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
