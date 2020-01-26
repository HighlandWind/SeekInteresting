//
//  GJHomePageController.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/24.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomePageController.h"
#import "GJHomeTabbarView.h"
#import "GJHomeCardView.h"
#import "GJHomeManager.h"
#import "GJHomeDetailVC.h"
#import "GJHomeEmojView.h"
#import "GJLoginApi.h"

@interface GJHomePageController ()
@property (nonatomic, strong) GJHomeTabbarView *tabbarView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) NSMutableArray<GJHomeCardView *> *imagesArr;
@property (nonatomic, assign) CGFloat movedDis;
@property (nonatomic, assign) BOOL hasUpMoveDown;
@property (nonatomic, assign) int hasLast;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, strong) NSMutableArray <GJHomeEventsModel *> *eventsModel;
@property (nonatomic, strong) UIButton *topRightBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) GJHomeRightBtn *rightBtn;
@end

@implementation GJHomePageController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).with.offset([UIApplication sharedApplication].statusBarFrame.size.height + 10);
    }];
    [self.topRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLB);
        make.right.equalTo(self.backView).with.offset(-25);
        make.size.mas_equalTo((CGSize){24, 24});
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
    self.tabbarView.hidden = NO;
    if (_eventsModel.count == 0) {
        if (APP_USER.isLoginStatus) {
            [self initializationNetWorking];
        }else {
            [[GJLoginApi new] requestGetUserInfo:^{
                [self initializationNetWorking];
            }];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabbarView.hidden = YES;
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _imagesArr = @[].mutableCopy;
    _eventsModel = @[].mutableCopy;
    _homeManager = [[GJHomeManager alloc] init];
}

- (void)initializationSubView {
    [self addSubview:_backView];
    [self.backView addSubview:self.titleLB];
    self.tabbarView = [GJHomeTabbarView installContext:self];
    [self.backView addSubview:self.topRightBtn];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
}

- (void)initializationNetWorking {
    // TODO 第一次运行u运行APP使用网络后刷新首页
    [self.view.loadingView startAnimation];
    [self.homeManager requestGetHomePlayCategorySuccess:^(NSArray<GJHomeEventsModel *> *data) {
        [self.view.loadingView stopAnimation];
        self.eventsModel = data.mutableCopy;
//        [self setupImages:[self.eventsModel subarrayWithRange:NSMakeRange(0, 7)]];
        [self setupImages:self.eventsModel];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
        ShowWaringAlertHUD(error.localizedDescription, self.view);
    }];
}

#pragma mark - Request Handle
- (void)setupImages:(NSArray <GJHomeEventsModel *> *)models {
    _panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [models enumerateObjectsUsingBlock:^(GJHomeEventsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJHomeCardView *v = [GJHomeCardView new];
        v.model = obj;
        [self.backView insertSubview:v atIndex:0];
        if (idx == 0) {
//            [self setBackViewColorTop:[UIColor randomColor] btm:[UIColor randomColor]];
            [self setBackViewColorTop:v.topColor btm:v.btmColor];
            [v addGestureRecognizer:self.panGes];
            v.frame = v.frontRect;
        }else if (idx == 1) {
            v.frame = v.nextRect;
        }else {
            v.frame = v.backRect;
        }
        v.initRect = v.frame;
        [self.imagesArr addObject:v];
        v.blockClickCard = ^ {
            [self rightBtnClick];
        };
    }];
    [self.backView insertSubview:_titleLB atIndex:0];
}

#pragma mark - Private methods
- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan ) {
        _movedDis = 0;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.backView];
        // 大于零往下滑，小于零往上滑
        _movedDis += translation.y;
        
        // move first card
        if (![self judgeCanContinue]) {
            return;
        }
//        if (gesture.view.y < NavBar_H - 44 ||
//            gesture.view.y > SCREEN_H - _imagesArr.firstObject.initRect.size.height - 50) {
//            return; bug
//        }
        gesture.view.centerY += translation.y; // gesture.view == _imagesArr[0]
        
        // move second or last card
        if (_imagesArr.count > 1) {
            if (_movedDis > 0) {
                _hasUpMoveDown = YES;
                [self.backView insertSubview:_imagesArr.lastObject belowSubview:_imagesArr.firstObject];
                [_imagesArr.lastObject moveChangeWidth:_movedDis dcY:translation.y cX:self.backView.centerX];
            }else {
                if (_hasUpMoveDown) {
                    [self.backView insertSubview:_imagesArr.lastObject atIndex:0];
                    _imagesArr.lastObject.frame = _imagesArr.lastObject.lastRect; // fix bug
                    _hasUpMoveDown = NO; // 下滑时把最后一个视图移到第二个没有放手又上滑时应把视图又移到最后
                }
                [_imagesArr[1] moveChangeWidth:_movedDis dcY:translation.y cX:self.backView.centerX]; // second card
            }
        }
        
        // 重新定位视图位置
        [gesture setTranslation:CGPointZero inView:self.backView];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded ) {
        if (![self judgeCanContinue]) {
            return;
        }
        if (_movedDis <= 0 && _imagesArr.count > 1) {
            GJHomeCardView *secView = _imagesArr[1]; // first second card
            [self nextBounce:secView.ratio == 1 first:_imagesArr[0] second:_imagesArr[1]];
        }
        if (_movedDis > 0 && _imagesArr.count > 1) {
            [self lastBounce:_imagesArr.lastObject.ratio == 1 first:_imagesArr.firstObject]; // first last card
        }
    }
}

- (BOOL)judgeCanContinue {
    BOOL can = YES;
    if (_imagesArr == 0) {
        can = NO;
    }
    if (_imagesArr.count == 1 && _movedDis < 0) {
        can = NO;
    }
    if (_movedDis > 0 && !_hasLast) {
        can = NO;
    }
    return can;
}

- (void)lastBounce:(BOOL)refresh first:(GJHomeCardView *)fstView {
    if (refresh) {
        // last become first, first become second
        GJHomeCardView *last = self.imagesArr.lastObject;
        [_imagesArr removeObject:last];
        [_imagesArr insertObject:last atIndex:0];
        [self.backView bringSubviewToFront:last];
        [last addGestureRecognizer:_panGes];
        [self setBackViewColorTop:last.topColor btm:last.btmColor];
        
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.nextRect; // first become second
            last.frame = last.frontRect; // last become first
            if (self.imagesArr.count > 2) {
                self.imagesArr[2].frame = self.imagesArr[2].backRect;
            }
            if (self.hasLast > 1) {
                self.imagesArr.lastObject.y = self.imagesArr.lastObject.lastRect.origin.y; // before the last view update
            }
        } completion:^(BOOL finished) {
            self.hasLast -= 1; // 大于1为真，小于等于零为假（回到原点）
            self.hasUpMoveDown = NO;
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.frontRect;
            self.imagesArr.lastObject.frame = self.self.imagesArr.lastObject.lastRect;
        } completion:^(BOOL finished) {
            [self.backView insertSubview:self.imagesArr.lastObject atIndex:0];
        }];
    }
}

- (void)nextBounce:(BOOL)refresh first:(GJHomeCardView *)fstView second:(GJHomeCardView *)secView {
    if (refresh) {
        // view change
        [self.backView bringSubviewToFront:secView]; // secView become first
        [secView addGestureRecognizer:_panGes];
        [self setBackViewColorTop:secView.topColor btm:secView.btmColor];
        
        [_imagesArr removeObject:fstView];
        [fstView removeFromSuperview];
        _imagesArr.lastObject.y = _imagesArr.lastObject.backRect.origin.y; // before last view update
        [_imagesArr addObject:fstView]; // 往上滑走的放最后，可倒序无限循环滚动图片
        GJHomeCardView *last = _imagesArr.lastObject;
        [self.backView insertSubview:last belowSubview:secView]; // fstView become second then become last
        
        [UIView animateWithDuration:0.5 animations:^{
            last.frame = last.lastRect; // fstView become last
            secView.frame = secView.frontRect; // secView become first
            if (self.imagesArr.count > 1) {
                self.imagesArr[1].y = self.imagesArr[1].nextRect.origin.y; // third view become second
            }
            if (self.imagesArr.count >= 3) {
            }
        } completion:^(BOOL finished) {
            [self.backView insertSubview:last atIndex:0];
            self.hasLast += 1; // 大于1为真，小于等于零为假（回到原点）
        }];
    }else {
        // just bounce to orgin
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.frontRect;
            if (secView) {
                secView.frame = secView.nextRect;
            }
        }];
    }
}

#pragma mark - Public methods
- (void)setBackViewColorTop:(UIColor *)top btm:(UIColor *)btm {
    GJGraduateColorView *graduteView = [[GJGraduateColorView alloc] initWithFrame:self.view.bounds];
    [graduteView setGraduteColorTop:top btm:btm];
    // 只要不是第一次进入，移除重建渐变背景
    if (_imagesArr.count != 0) {
        [self.view.subviews.firstObject removeFromSuperview];
    }
    [self.view insertSubview:graduteView atIndex:0];
    self.tabbarView.backgroundColor = btm;
}

#pragma mark - Event response
- (void)topRightBtnClick {
    [GJHomeEmojView showContext:self block:^(NSInteger idx) {
        NSLog(@"%ld", (long)idx);
    }];
}

- (void)leftBtnClick {
    if (_imagesArr.count <= 1) {
        return;
    }
    [_leftBtn shakeViewCallback:^{
    }];
    GJHomeCardView *fst = self.imagesArr.firstObject;
    GJHomeCardView *sec = self.imagesArr[1];
    CGFloat y1 = fst.y - fst.height / 2 - 10;
    CGFloat y2 = fst.y + fst.height / 2 + 10;
    [UIView animateWithDuration:0.3 animations:^{
        [fst setY:y1];
        [sec setY:y2];
        [sec setWidth:sec.frontRect.size.width];
        [sec setCenterX:self.view.centerX];
    } completion:^(BOOL finished) {
        [self nextBounce:YES first:fst second:sec];
    }];
}

- (void)rightBtnClick {
    [_rightBtn shakeViewCallback:^{
        GJHomeCardView *fst = self.imagesArr.firstObject;
        GJHomeDetailVC *vc = [GJHomeDetailVC new];
        vc.model = fst.model;
        [vc pushPageWith:self];
    }];
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"找点事做";
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:17];
        _titleLB.textColor = APP_CONFIG.whiteGrayColor;
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (UIButton *)topRightBtn {
    if (!_topRightBtn) {
        _topRightBtn = [[UIButton alloc] init];
        [_topRightBtn setImage:[UIImage imageNamed:@"微笑白"] forState:UIControlStateNormal];
        [_topRightBtn addTarget:self action:@selector(topRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _topRightBtn;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        CGFloat w = AdaptatSize(100);
        CGFloat y = SCREEN_H/2+w-20;
        if (IPHONE_X) y += 30;
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W/2-w-10, y, w, w)];
        [_leftBtn setImage:[UIImage imageNamed:@"不喜欢"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (GJHomeRightBtn *)rightBtn {
    if (!_rightBtn) {
        CGFloat w = AdaptatSize(100);
        CGFloat y = SCREEN_H/2+w-20;
        if (IPHONE_X) y += 30;
        _rightBtn = [[GJHomeRightBtn alloc] initWithFrame:CGRectMake(SCREEN_W/2+10, y, w, w)];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
