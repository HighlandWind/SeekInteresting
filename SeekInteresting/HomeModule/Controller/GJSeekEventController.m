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
#import "GXCardView.h"
#import "GXCardItemDemoCell.h"

@interface GJSeekEventController () <GXCardViewDataSource, GXCardViewDelegate, UITableViewDelegate>
@property (nonatomic, strong) GJSeekEatTopView *topView;
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) GJSeekLRBtn *bottomBtn;
@property (nonatomic, strong) UIButton *seeElseBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIScrollView *contentImgV;
//@property (nonatomic, strong) UIImageView *contentImgV;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) GXCardView *cardView;
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
//    [_contentImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(self.contentHeight);
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.centerImgView).with.offset(AdaptatSize(25));
//    }];
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
    _contentHeight = SCREEN_W - AdaptatSize(80);
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self allowBackWithImage:@""];
    [self.navigationController.navigationBar setBackgroundImage:CreatImageWithColor([UIColor clearColor]) forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self addSubview:self.centerImgView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomBtn];
    [self addSubview:self.seeElseBtn];
    [self addSubview:self.shareBtn];
//    [self addSubview:self.contentImgV];
    
    [self addSubview:self.cardView];
    
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
//    _contentImgV.contentSize = CGSizeMake(_contentHeight * _eventsModel.count, _contentHeight);
//    [self showCurrentData];
    
    _cardView.visibleCount = 5;
    [self.cardView reloadData];
}

#pragma mark - Private methods
- (void)showCurrentData {
    _topView.titleText = _eventsModel[_pageNum].name;
    _topView.detailText = _eventsModel[_pageNum].slogan;
//    [_contentImgV sd_setImageWithURL:[NSURL URLWithString:_eventsModel[_pageNum].icon]];
    
    __block UIView *tmpV = nil;
    [_eventsModel enumerateObjectsUsingBlock:^(GJHomeEventsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentImgV addSubview:imgV];
        [imgV sd_setImageWithURL:[NSURL URLWithString:_eventsModel[idx].icon]];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.width.equalTo(self.contentImgV);
            if (tmpV) {
                make.left.equalTo(tmpV.mas_right);
            }else {
                make.left.equalTo(self.contentImgV);
            }
            tmpV = imgV;
        }];
    }];
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
        [weakSelf refreshNextClick];
    };
}

- (void)refreshNextClick {
    ++ _pageNum;
    if (_pageNum >= _eventsModel.count) {
        // TODO - 数据看完了
        _pageNum = 0;
    }
    [self showCurrentData];
}

- (void)refreshLastClick {
    if (_pageNum == 0) return;
    -- _pageNum;
    [self showCurrentData];
}

- (void)seeElseBtnClick {
    
}

- (void)shareBtnBtnClick {
    
}

- (void)swipeRight:(UISwipeGestureRecognizer *)panGes {
    if (panGes.direction == UISwipeGestureRecognizerDirectionRight) {
        [self refreshLastClick];
    }
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)panGes {
    if (panGes.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self refreshNextClick];
    }
}

- (void)leftButtonClick {
    [self.cardView removeTopCardViewFromSwipe:GXCardCellSwipeDirectionLeft];
}

- (void)rightButtonClick {
    [self.cardView removeTopCardViewFromSwipe:GXCardCellSwipeDirectionRight];
}

#pragma mark - Custom delegate
// GXCardViewDataSource
- (GXCardViewCell *)cardView:(GXCardView *)cardView cellForRowAtIndex:(NSInteger)index {
    GXCardItemDemoCell *cell = [cardView dequeueReusableCellWithIdentifier:@"GXCardViewCell"];
//    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
//    cell.leftLabel.hidden = YES;
//    cell.rightLabel.hidden = YES;
    cell.layer.cornerRadius = 12.0;
    
    return cell;
}

- (NSInteger)numberOfCountInCardView:(UITableView *)cardView {
    return 10;
}

// GXCardViewDelegate
- (void)cardView:(GXCardView *)cardView didRemoveLastCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    [cardView reloadDataAnimated:YES];
}

- (void)cardView:(GXCardView *)cardView didRemoveCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index direction:(GXCardCellSwipeDirection)direction {
    
//    NSLog(@"didRemoveCell forRowAtIndex = %ld, direction = %ld", index, direction);
}

- (void)cardView:(GXCardView *)cardView didDisplayCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    
//    NSLog(@"didDisplayCell forRowAtIndex = %ld", index);
}

- (void)cardView:(GXCardView *)cardView didMoveCell:(GXCardViewCell *)cell forMovePoint:(CGPoint)point direction:(GXCardCellSwipeDirection)direction {
    
//    GXCardItemDemoCell *dcell = (GXCardItemDemoCell*)cell;
//    dcell.leftLabel.hidden = !(direction == GXCardCellSwipeDirectionRight);
//    dcell.rightLabel.hidden = !(direction == GXCardCellSwipeDirectionLeft);
//    NSLog(@"move point = %@,  direction = %ld", NSStringFromCGPoint(point), direction);
}

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

- (UIScrollView *)contentImgV {
    if (!_contentImgV) {
        _contentImgV = [[UIScrollView alloc] init];
        _contentImgV.backgroundColor = [UIColor clearColor];
        _contentImgV.pagingEnabled = YES;
        _contentImgV.showsHorizontalScrollIndicator = NO;
        _contentImgV.showsVerticalScrollIndicator = NO;
    }
    return _contentImgV;
}

//- (UIImageView *)contentImgV {
//    if (!_contentImgV) {
//        _contentImgV = [[UIImageView alloc] init];
//        _contentImgV.contentMode = UIViewContentModeScaleAspectFit;
//        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
//        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
//        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//        _contentImgV.userInteractionEnabled = YES;
//        [_contentImgV addGestureRecognizer:swipeRight];
//        [_contentImgV addGestureRecognizer:swipeLeft];
//    }
//    return _contentImgV;
//}

- (GXCardView *)cardView {
    if (!_cardView) {
        _cardView = [[GXCardView alloc] initWithFrame:CGRectMake(AdaptatSize(37.5), AdaptatSize(100), AdaptatSize(300), AdaptatSize(350))];
        _cardView.dataSource = self;
        _cardView.delegate = self;
        _cardView.lineSpacing = 15.0;
        _cardView.interitemSpacing = 10.0;
        _cardView.maxAngle = 15.0;
        _cardView.maxRemoveDistance = 100.0;
//        [_cardView registerNib:[UINib nibWithNibName:NSStringFromClass([GXCardItemDemoCell class]) bundle:nil] forCellReuseIdentifier:@"GXCardViewCell"];
        [_cardView registerClass:GXCardItemDemoCell.class forCellReuseIdentifier:@"GXCardItemDemoCell"];
    }
    return _cardView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
