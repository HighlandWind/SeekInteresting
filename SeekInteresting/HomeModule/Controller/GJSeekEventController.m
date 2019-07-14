//
//  GJSeekEventController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/14.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEventController.h"
#import "GJArticleDetailController.h"
#import "GJHomeEventsModel.h"
#import "GJHomeManager.h"
#import "GXCardView.h"
#import "GXCardItemDemoCell.h"

@interface GJSeekEventController () <GXCardViewDataSource, GXCardViewDelegate, UITableViewDelegate>
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) GJSeekLRBtn *bottomBtn;
@property (nonatomic, strong) UIButton *seeElseBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIScrollView *contentImgV;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) GXCardView *cardView;
@end

@implementation GJSeekEventController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
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

#pragma mark - Iniitalization methods
- (void)initializationData {
    _homeManager = [[GJHomeManager alloc] init];
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self allowBackWithImage:@""];
    [self.navigationController.navigationBar setBackgroundImage:CreatImageWithColor([UIColor clearColor]) forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self addSubview:self.centerImgView];
    [self addSubview:self.seeElseBtn];
    [self addSubview:self.shareBtn];
    [self addSubview:self.cardView];
    [self addSubview:self.bottomBtn];
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
    _cardView.visibleCount = _eventsModel.count;
    [self.cardView reloadData];
}

#pragma mark - Private methods
- (void)showCurrentData:(GXCardItemDemoCell *)cell {
    NSInteger _pageNum = _cardView.currentFirstIndex;
    cell.topView.titleText = _eventsModel[_pageNum].name;
    cell.topView.detailText = _eventsModel[_pageNum].slogan;
    
    cell.imageV.hidden = NO;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:_eventsModel[_pageNum].icon]];
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _bottomBtn.blockClickLeft = ^{
        GJArticleDetailController *vc = [[GJArticleDetailController alloc] init];
        vc.eventModel = weakSelf.eventsModel[weakSelf.cardView.currentFirstIndex];
        [vc pushPageWith:weakSelf];
    };
    _bottomBtn.blockClickRight = ^{
        [weakSelf refreshNextClick];
    };
}

- (void)seeElseBtnClick {
    
}

- (void)shareBtnBtnClick {
    
}

- (void)refreshNextClick {
    [self.cardView removeTopCardViewFromSwipe:GXCardCellSwipeDirectionLeft];
}

#pragma mark - Custom delegate
// GXCardViewDataSource
- (GXCardViewCell *)cardView:(GXCardView *)cardView cellForRowAtIndex:(NSInteger)index {
    GXCardItemDemoCell *cell = [cardView dequeueReusableCellWithIdentifier:@"GXCardItemDemoCell"];
    
    return cell;
}

- (NSInteger)numberOfCountInCardView:(UITableView *)cardView {
    return _eventsModel.count;
}

// GXCardViewDelegate
- (void)cardView:(GXCardView *)cardView didRemoveLastCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    [cardView reloadDataAnimated:YES];
    // TODO
    
}

- (void)cardView:(GXCardView *)cardView didRemoveCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index direction:(GXCardCellSwipeDirection)direction {
//    GXCardItemDemoCell *dcell = (GXCardItemDemoCell*)cell;
//    NSLog(@"didRemoveCell forRowAtIndex = %ld, direction = %ld", index, direction);
}

- (void)cardView:(GXCardView *)cardView didDisplayCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    
    GXCardItemDemoCell *dcell = (GXCardItemDemoCell*)cell;
    [self showCurrentData:dcell];
    
//    NSLog(@"didDisplayCell forRowAtIndex = %ld", index);
}

- (void)cardView:(GXCardView *)cardView didMoveCell:(GXCardViewCell *)cell forMovePoint:(CGPoint)point direction:(GXCardCellSwipeDirection)direction {
//    GXCardItemDemoCell *dcell = (GXCardItemDemoCell*)cell;
//    NSLog(@"move point = %@,  direction = %ld", NSStringFromCGPoint(point), direction);
}

#pragma mark - Getter/Setter
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

- (GXCardView *)cardView {
    if (!_cardView) {
        CGFloat w = SCREEN_W - AdaptatSize(40);
        _cardView = [[GXCardView alloc] initWithFrame:CGRectMake(AdaptatSize(20), [UIApplication sharedApplication].statusBarFrame.size.height, w, w + AdaptatSize(150))];
        _cardView.dataSource = self;
        _cardView.delegate = self;
        _cardView.lineSpacing = 15.0;
        _cardView.interitemSpacing = 10.0;
        _cardView.maxAngle = 15.0;
        _cardView.maxRemoveDistance = 100.0;
        [_cardView registerClass:GXCardItemDemoCell.class forCellReuseIdentifier:@"GXCardItemDemoCell"];
    }
    return _cardView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
