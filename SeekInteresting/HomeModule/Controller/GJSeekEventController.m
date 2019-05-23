//
//  GJSeekEventController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/14.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEventController.h"
#import "GJSeekEatTopView.h"
#import "HDeviceIdentifier.h"

@interface GJSeekEventController ()
@property (nonatomic, strong) GJSeekEatTopView *topView;
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) GJSeekLRBtn *bottomBtn;
@property (nonatomic, strong) UIButton *seeElseBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@end

@implementation GJSeekEventController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(20));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.view).with.offset(AdaptatSize(20));
        make.height.mas_equalTo(AdaptatSize(65));
    }];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
//        make.bottom.equalTo(self.selectEatBtn.mas_top).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.topView.mas_bottom).with.offset(AdaptatSize(40));
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(50));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(50));
        make.height.mas_equalTo(AdaptatSize(38));
        make.top.equalTo(self.centerImgView.mas_bottom).with.offset(AdaptatSize(50));
    }];
    [_seeElseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bottomBtn.mas_bottom).with.offset(AdaptatSize(12));
    }];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.seeElseBtn.mas_bottom).with.offset(AdaptatSize(12));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
}

- (void)initializationSubView {
    self.title = @"找点事做";
    [self showShadorOnNaviBar:NO];
    [self addSubview:self.topView];
    [self addSubview:self.centerImgView];
    [self addSubview:self.bottomBtn];
    [self addSubview:self.seeElseBtn];
    [self addSubview:self.shareBtn];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
//    __weak typeof(self)weakSelf = self;
    _bottomBtn.blockClickLeft = ^{
        NSLog(@"left");
    };
    _bottomBtn.blockClickRight = ^{
        NSLog(@"right");
    };
}

- (void)seeElseBtnClick {
    
}

- (void)shareBtnBtnClick {
    
    NSString *UDID = [HDeviceIdentifier deviceIdentifier];
    
    NSLog(@"UUID:%@",UDID);
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (GJSeekEatTopView *)topView {
    if (!_topView) {
        _topView = [GJSeekEatTopView installTitle:@"看看视频" detail:@"看看视频娱乐一下"];
    }
    return _topView;
}

- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seek_video"]];
        _centerImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _centerImgView;
}

- (GJSeekLRBtn *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[GJSeekLRBtn alloc] initLeft:@"拒绝" right:@"确定"];
    }
    return _bottomBtn;
}

- (UIButton *)seeElseBtn {
    if (!_seeElseBtn) {
        _seeElseBtn = [[UIButton alloc] init];
        _seeElseBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:13];
        [_seeElseBtn setTitle:@"看看其他小伙伴无聊的时候做些什么" forState:UIControlStateNormal];
        [_seeElseBtn setTitleColor:[UIColor colorWithRGB:74 g:144 b:226] forState:UIControlStateNormal];
        [_seeElseBtn addTarget:self action:@selector(seeElseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_seeElseBtn sizeToFit];
    }
    return _seeElseBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        _shareBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:13];
        [_shareBtn setTitle:@"分享我的操作" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:APP_CONFIG.grayTextColor forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn sizeToFit];
    }
    return _shareBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
