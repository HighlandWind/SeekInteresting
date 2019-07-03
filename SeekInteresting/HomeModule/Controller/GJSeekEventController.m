//
//  GJSeekEventController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/14.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEventController.h"
#import "GJSeekEatTopView.h"
#import "GJArticleDetailController.h"
#import "GJHomeEventsModel.h"
#import "GJHomeManager.h"

@interface GJSeekEventController ()
@property (nonatomic, strong) GJSeekEatTopView *topView;
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) GJSeekLRBtn *bottomBtn;
@property (nonatomic, strong) UIButton *seeElseBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIImageView *contentImgV;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation GJSeekEventController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
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
    [_contentImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCREEN_W - AdaptatSize(80));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.centerImgView).with.offset(AdaptatSize(25));
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
    _homeManager = [[GJHomeManager alloc] init];
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self allowBackWithImage:@""];
    [self.navigationController.navigationBar setBackgroundImage:CreatImageWithColor([UIColor clearColor]) forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self addSubview:self.centerImgView];
    [self addSubview:self.contentImgV];
    [self addSubview:self.topView];
    [self addSubview:self.bottomBtn];
    [self addSubview:self.seeElseBtn];
    [self addSubview:self.shareBtn];
    [self addSubview:self.contentImgV];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    if (!self.eventsModel) {
        [self.view.loadingView startAnimation];
        [_homeManager requestGetHomePlayCategorySuccess:^(NSArray<GJHomeEventsModel *> *data) {
            [self.view.loadingView stopAnimation];
            self.eventsModel = data;
            [self loadData];
        } failure:^(NSURLResponse *urlResponse, NSError *error) {
            [self.view.loadingView stopAnimation];
        }];
    }else {
        [self loadData];
    }
}

#pragma mark - Request Handle
- (void)loadData {
//    NSArray *_contentArray = @[@"看视频", @"看文章", @"看新闻", @"聊天", @"听音乐"];
    
    _pageNum = 0;
    [self showCurrentData];
    
}

#pragma mark - Private methods
- (void)showCurrentData {
    _topView.titleText = _eventsModel[_pageNum].name;
    _topView.detailText = _eventsModel[_pageNum].slogan;
    [_contentImgV sd_setImageWithURL:[NSURL URLWithString:_eventsModel[_pageNum].icon]];
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomBtn.blockClickLeft = ^{
        GJArticleDetailController *vc = [[GJArticleDetailController alloc] init];
        vc.eventModel = weakSelf.eventsModel[weakSelf.pageNum];
        [vc pushPageWith:weakSelf];
    };
    _bottomBtn.blockClickRight = ^{
        ++ weakSelf.pageNum;
        if (weakSelf.pageNum >= weakSelf.eventsModel.count) {
            // TODO - 数据看完了
            weakSelf.pageNum = 0;
        }
        [weakSelf showCurrentData];
    };
}

- (void)seeElseBtnClick {
    
}

- (void)shareBtnBtnClick {
    
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (GJSeekEatTopView *)topView {
    if (!_topView) {
        _topView = [GJSeekEatTopView installType: SelectPageType_Event];
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
        _bottomBtn = [[GJSeekLRBtn alloc] initLeft:@"看一看" right:@"" type: SelectPageType_Event];
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

- (UIImageView *)contentImgV {
    if (!_contentImgV) {
        _contentImgV = [[UIImageView alloc] init];
        _contentImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _contentImgV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
