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

@interface GJHomePageController ()
@property (nonatomic, strong) GJHomeTabbarView *tabbarView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) NSMutableArray<GJHomeCardView *> *imagesArr;
@property (nonatomic, assign) CGFloat movedDis;
@property (nonatomic, assign) BOOL hasLast;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, strong) NSMutableArray <GJHomeEventsModel *> *eventsModel;
@end

@implementation GJHomePageController

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
        [self setupImages:self.eventsModel];
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
                [self.view insertSubview:_imagesArr.lastObject belowSubview:_imagesArr.firstObject];
                [_imagesArr.lastObject moveChangeWidth:_movedDis dcY:translation.y cX:self.view.centerX];
            }else {
                [_imagesArr[1] moveChangeWidth:_movedDis dcY:translation.y cX:self.view.centerX]; // second card
            }
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
        [self.view bringSubviewToFront:last];
        [last addGestureRecognizer:_panGes];
        [self setBackViewColor:[UIColor randomColor]];
        
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.nextRect; // first become second
            last.frame = last.frontRect; // last become first
            if (self.imagesArr.count > 2) {
                self.imagesArr[2].frame = self.imagesArr[2].backRect;
            }
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            fstView.frame = fstView.frontRect;
            self.imagesArr.lastObject.frame = self.self.imagesArr.lastObject.lastRect;
        } completion:^(BOOL finished) {
            [self.view insertSubview:self.imagesArr.lastObject atIndex:0];
        }];
    }
}

- (void)nextBounce:(BOOL)refresh first:(GJHomeCardView *)fstView second:(GJHomeCardView *)secView {
    if (refresh) {
        // view change
        [self.view bringSubviewToFront:secView]; // secView become first
        [secView addGestureRecognizer:_panGes];
        [self setBackViewColor:[UIColor randomColor]];
        
        [_imagesArr removeObject:fstView];
        [fstView removeFromSuperview];
        [_imagesArr addObject:fstView]; // 往上滑走的放最后，可倒序无限循环滚动图片
        [self.view insertSubview:_imagesArr.lastObject belowSubview:secView]; // fstView become second then become last
        
        [UIView animateWithDuration:0.5 animations:^{
            self.imagesArr.lastObject.frame = self.imagesArr.lastObject.lastRect; // fstView become last
            secView.frame = secView.frontRect; // secView become first
            if (self.imagesArr.count > 1) {
                self.imagesArr[1].y = self.imagesArr[1].nextRect.origin.y; // third view become second
            }
        } completion:^(BOOL finished) {
            [self.view insertSubview:self.imagesArr.lastObject atIndex:0];
            self.hasLast = YES;
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
