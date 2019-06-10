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
@property (nonatomic, strong) NSArray *contentArray;
@end

@implementation GJSeekEventController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
    }];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(20));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.view).with.offset(NavBar_H - AdaptatSize(25));
        make.height.mas_equalTo(AdaptatSize(65));
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(30));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(30));
        make.height.mas_equalTo(AdaptatSize(65));
        make.bottom.equalTo(self.centerImgView.mas_bottom).with.offset(AdaptatSize(10));
    }];
    [_seeElseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bottomBtn.mas_bottom).with.offset(AdaptatSize(12));
    }];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.seeElseBtn.mas_bottom);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _contentArray = @[@"看视频", @"看文章", @"看新闻", @"聊天", @"听音乐"];
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self addSubview:self.centerImgView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomBtn];
    [self addSubview:self.seeElseBtn];
    [self addSubview:self.shareBtn];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    UIImageView *contentImgV = [[UIImageView alloc] init];
    contentImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:contentImgV];
    contentImgV.image = [UIImage imageNamed:_contentArray[0]];
    [contentImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.centerY.equalTo(self.centerImgView).with.offset(AdaptatSize(25));
    }];
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
        _topView = [GJSeekEatTopView installTitle:@"看看视频" detail:@"娱乐一下"];
    }
    return _topView;
}

- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
        _centerImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _centerImgView;
}

- (GJSeekLRBtn *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[GJSeekLRBtn alloc] initLeft:@"看一看" right:@""];
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
