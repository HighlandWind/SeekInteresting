//
//  GJHomeVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/21.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeVC.h"
#import "GJHomeTabbarView.h"
#import "GJHomeCardView.h"
#import "GJHomeManager.h"

@interface GJHomeVC ()
@property (nonatomic, strong) GJHomeTabbarView *tabbarView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) NSMutableArray<GJHomeCardView *> *imagesArr;
@property (nonatomic, assign) CGFloat movedDis;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
@property (nonatomic, strong) GJHomeCardView *lastView;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, strong) NSMutableArray <GJHomeEventsModel *> *eventsModel;
@end

@implementation GJHomeVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset([UIApplication sharedApplication].statusBarFrame.size.height + 10);
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabbarView.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _imagesArr = @[].mutableCopy;
    _eventsModel = @[].mutableCopy;
    _homeManager = [[GJHomeManager alloc] init];
}

- (void)initializationSubView {
    [self.view addSubview:self.titleLB];
    _tabbarView = [GJHomeTabbarView install];
}

- (void)initializationNetWorking {
    [self.homeManager requestGetHomePlayCategorySuccess:^(NSArray<GJHomeEventsModel *> *data) {
        self.eventsModel = data.mutableCopy;
        if (self.eventsModel.count > 3) {
            [self setupImages:[self.eventsModel subarrayWithRange:NSMakeRange(0, 3)]];
        }else {
            [self setupImages:self.eventsModel];
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
    }];
}

#pragma mark - Request Handle
- (void)setupImages:(NSArray <GJHomeEventsModel *> *)models {
    _panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [models enumerateObjectsUsingBlock:^(GJHomeEventsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJHomeCardView *v = [GJHomeCardView new];
        v.model = obj;
        [v sd_setImageWithURL:[NSURL URLWithString:obj.icon] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (idx == 0) {
//                [self setBackViewColor:[UIColor mostColor:v.image]];
            }
        }];
        [self.view insertSubview:v atIndex:0];
        if (idx == 0) {
            [self setBackViewColor:[UIColor randomColor]];
            [v addGestureRecognizer:self.panGes];
            v.frame = v.frontRect;
        }else if (idx == 1) {
            v.frame = v.nextRect;
        }else {
            v.frame = v.backRect;
        }
        v.initRect = v.frame;
        [self.imagesArr addObject:v];
    }];
}

- (void)refreshImagesArr {
    if ([_eventsModel containsObject:_imagesArr[_imagesArr.count - 1].model]) {
        NSUInteger idx = [_eventsModel indexOfObject:_imagesArr[_imagesArr.count - 1].model];
        if (idx < _eventsModel.count - 1) {
            GJHomeEventsModel *obj = _eventsModel[idx + 1]; // refresh next model
            GJHomeCardView *v = [GJHomeCardView new];
            v.model = obj;
            [v sd_setImageWithURL:[NSURL URLWithString:obj.icon]];
            v.frame = v.backRect;
            v.initRect = v.frame;
            [self.view insertSubview:v atIndex:0];
            [self.imagesArr addObject:v];
        }
    }
}

#pragma mark - Private methods
- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan ) {
        _movedDis = 0;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.view];
        // 大于零往下滑，小于零往上滑
        _movedDis += translation.y;
        
        // move first card
        if (![self judgeCanContinue]) {
            return;
        }
        gesture.view.centerY += translation.y; // gesture.view == _imagesArr[0]
        
        // move second or last card
        if (_imagesArr.count > 1) {
            if (_movedDis > 0) {
                if (_lastView) {
                    [self.view insertSubview:_lastView belowSubview:_imagesArr[0]];
                    [_lastView moveChangeWidth:_movedDis dcY:translation.y cX:self.view.centerX];
                }
            }else {
                [_imagesArr[1] moveChangeWidth:_movedDis dcY:translation.y cX:self.view.centerX]; // second card
            }
        }
        // move last card
        else if (_imagesArr.count == 1 && _lastView && _movedDis > 0) {
            [_lastView moveChangeWidth:_movedDis dcY:translation.y cX:self.view.centerX];
        }
        
        // 重新定位视图位置
        [gesture setTranslation:CGPointZero inView:self.view];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded ) {
        if (![self judgeCanContinue]) {
            return;
        }
        if (_movedDis <= 0 && _imagesArr.count > 1) {
            GJHomeCardView *secView = _imagesArr[1]; // first second card
            [self nextBounce:secView.ratio == 1 first:_imagesArr[0] second:_imagesArr[1]];
        }
        if (_movedDis > 0 && _lastView && _imagesArr.count > 0) {
            [self lastBounce:_lastView.ratio == 1 first:_imagesArr[0]]; // first last card
        }
    }
}

- (BOOL)judgeCanContinue {
    BOOL can = YES;
    if (_imagesArr == 0) {
        can = NO;
    }
    if ([_imagesArr containsObject:_lastView] && _movedDis > 0) {
        can = NO;
    }
    if (!_lastView && _movedDis > 0) {
        can = NO;
    }
    if (_imagesArr.count == 1 && _movedDis < 0) {
        can = NO;
    }
    return can;
}

- (void)lastBounce:(BOOL)refresh first:(GJHomeCardView *)fstView {
    if (refresh) {
        // last become first, first become second
        [_imagesArr insertObject:_lastView atIndex:0];
        [self.view bringSubviewToFront:_lastView];
        [_lastView addGestureRecognizer:_panGes];
        [self setBackViewColor:[UIColor randomColor]];
        
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.nextRect; // first become second
            self.lastView.frame = self.lastView.frontRect; // last become first
            if (self.imagesArr.count > 2) {
                self.imagesArr[2].frame = self.imagesArr[2].backRect;
            }
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.frontRect;
            self.lastView.frame = self.lastView.lastRect;
        } completion:^(BOOL finished) {
            [self.view insertSubview:self.lastView atIndex:0];
        }];
    }
}

- (void)nextBounce:(BOOL)refresh first:(GJHomeCardView *)fstView second:(GJHomeCardView *)secView {
    if (refresh) {
        // view change
        [self.view bringSubviewToFront:secView]; // secView become first
        [secView addGestureRecognizer:_panGes];
        [self setBackViewColor:[UIColor randomColor]];
        
        [self refreshImagesArr]; // _imagesArr will add 1 when has next
        
        if (_lastView) [_lastView removeFromSuperview];
        _lastView = fstView;
        [_imagesArr removeObject:fstView];
        [fstView removeFromSuperview];
        [self.view insertSubview:_lastView belowSubview:secView]; // fstView become second then become last
        
        [UIView animateWithDuration:0.5 animations:^{
            self.lastView.frame = self.lastView.lastRect; // fstView become last
            secView.frame = secView.frontRect; // secView become first
            if (self.imagesArr.count > 1) {
                self.imagesArr[1].y += 18; // third view become second
            }
        } completion:^(BOOL finished) {
            [self.view insertSubview:self.lastView atIndex:0];
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
- (void)setBackViewColor:(UIColor *)color {
    self.view.backgroundColor = _tabbarView.backgroundColor = color;
}

#pragma mark - Event response


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
