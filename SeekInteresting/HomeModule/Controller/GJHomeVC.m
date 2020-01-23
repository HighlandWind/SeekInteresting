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

@interface GJHomeVC ()
@property (nonatomic, strong) GJHomeTabbarView *tabbarView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) NSMutableArray<GJHomeCardView *> *imagesArr;
@property (nonatomic, assign) CGFloat movedDis;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
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
}

- (void)initializationSubView {
    [self.view addSubview:self.titleLB];
    _tabbarView = [GJHomeTabbarView install];
    self.view.backgroundColor = _tabbarView.backgroundColor = [UIColor redColor];
}

- (void)initializationNetWorking {
    GJHomeCardView *v1 = [GJHomeCardView new];
    v1.backgroundColor = [UIColor greenColor];
    GJHomeCardView *v2 = [GJHomeCardView new];
    v2.backgroundColor = [UIColor yellowColor];
    GJHomeCardView *v3 = [GJHomeCardView new];
    v3.backgroundColor = [UIColor blueColor];
    
    [_imagesArr addObjectsFromArray:@[v1, v2, v3]];
    [self setupImages];
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)setupImages {
    _panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [_imagesArr enumerateObjectsUsingBlock:^(GJHomeCardView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view insertSubview:obj atIndex:0];
        if (idx == 0) {
            [obj addGestureRecognizer:self.panGes];
            obj.frame = obj.frontRect;
        }else if (idx == 1) {
            obj.frame = obj.backRectF;
        }else {
            obj.frame = obj.backRect;
        }
        obj.orginRect = obj.frame;
    }];
}

- (void)refreshImagesArr {
    GJHomeCardView *view = [GJHomeCardView new];
    view.frame = view.backRect; // TODO when all only two backRectF
    view.orginRect = view.frame;
    view.backgroundColor = [UIColor purpleColor];
    [self.view insertSubview:view atIndex:0];
    [_imagesArr addObject:view];
    NSLog(@"%@ %f", _movedDis > 0 ? @"下" : @"上", _movedDis);
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan ) {
        _movedDis = 0;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (_imagesArr.count > 1) {
            if (gesture.view.y < NavBar_H - 44 ||
                gesture.view.y > SCREEN_H - _imagesArr[0].orginRect.size.height - 50) {
                return;
            }
            
            CGPoint translation = [gesture translationInView:self.view];
            // gesture.view -> _imagesArr[0]
            gesture.view.centerY += translation.y;
            
            GJHomeCardView *secView = _imagesArr[1];
            secView.centerY -= translation.y;
            secView.centerX = self.view.centerX;
            // 大于零往下，小于零往下
            _movedDis += translation.y;
            // 宽度变宽
            [secView moveChangeWidth:_movedDis];
        }
        
        // 重新定位视图位置
        [gesture setTranslation:CGPointZero inView:self.view];
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded ) {
        if (_imagesArr.count > 1) {
            GJHomeCardView *fstView = _imagesArr[0];
            GJHomeCardView *secView = _imagesArr[1];
            if (secView.ratio == 1) {
                // 层级变化
                [self.view bringSubviewToFront:secView];
                [secView addGestureRecognizer:_panGes];
                
                [fstView removeFromSuperview];
                [_imagesArr removeObject:fstView];
                if (_imagesArr.count > 1) {
                    // newer _imagesArr[1] set backRectF y
                    _imagesArr[1].y += 18;
                    [self refreshImagesArr];
                }
                [UIView animateWithDuration:0.5 animations:^{
                    secView.y = secView.frontRect.origin.y;
                }];
            }else {
                // 仅回弹
                [self.view bringSubviewToFront:fstView];
                [UIView animateWithDuration:0.5 animations:^{
                    fstView.y = fstView.orginRect.origin.y;
                    secView.y = secView.orginRect.origin.y;
                    secView.width = secView.backRect.size.width;
                    secView.centerX = self.view.centerX;
                }];
            }
        }
    }
}

#pragma mark - Public methods


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
