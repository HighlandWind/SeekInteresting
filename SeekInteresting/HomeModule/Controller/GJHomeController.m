//
//  GJHomeController.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/20.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeController.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "GJHomeTabbarView.h"

@interface GJHomeController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, ZLSwipeableViewAnimator, UIActionSheetDelegate>
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) GJHomeTabbarView *tabbarView;
@property (nonatomic, strong) ZLSwipeableView *swipeableView;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;
@property (nonatomic) BOOL loadCardFromXib;
@end

@implementation GJHomeController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.swipeableView loadViewsIfNeeded];
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
    self.colorIndex = 0;
    self.colors = @[
                    @"Turquoise",
                    @"Green Sea",
                    @"Emerald",
                    @"Nephritis",
                    @"Peter River",
                    @"Belize Hole",
                    @"Amethyst",
                    @"Wisteria",
                    @"Wet Asphalt",
                    @"Midnight Blue",
                    @"Sun Flower",
                    @"Orange",
//                    @"Carrot",
//                    @"Pumpkin",
//                    @"Alizarin",
//                    @"Pomegranate",
//                    @"Clouds",
//                    @"Silver",
//                    @"Concrete",
//                    @"Asbestos"
                    ];
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    self.view.clipsToBounds = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.tabbarView];
    [self.view addSubview:self.titleLB];
    [self.view addSubview:self.swipeableView];
    
    [self.swipeableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
        make.centerY.equalTo(self.view).with.offset(-AdaptatSize(20));
        make.height.mas_equalTo(AdaptatSize(250));
    }];
    
//    ZLSwipeableView *swipeableView = self.swipeableView;
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
//                               options:0
//                               metrics:@{}
//                               views:NSDictionaryOfVariableBindings(swipeableView)]];
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-80-[swipeableView]-180-|"
//                               options:0
//                               metrics:@{}
//                               views:NSDictionaryOfVariableBindings(swipeableView)]];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)rotateAndTranslateView:(UIView *)view
                     forDegree:(float)degree
                   translation:(CGPoint)translation
                      duration:(NSTimeInterval)duration
            atOffsetFromCenter:(CGPoint)offset
                 swipeableView:(ZLSwipeableView *)swipeableView {
    float rotationRadian = [self degreesToRadians:degree];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         view.center = [swipeableView convertPoint:swipeableView.center
                                                          fromView:swipeableView.superview];
                         CGAffineTransform transform =
                         CGAffineTransformMakeTranslation(offset.x, offset.y);
                         transform = CGAffineTransformRotate(transform, rotationRadian);
                         transform = CGAffineTransformTranslate(transform, -offset.x, -offset.y);
                         transform =
                         CGAffineTransformTranslate(transform, translation.x, translation.y);
                         view.transform = transform;
                     }
                     completion:nil];
}

#pragma mark - Public methods
- (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

- (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

- (UIColor *)colorForName:(NSString *)name {
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}

#pragma mark - Event response


#pragma mark - Custom delegate
// ZLSwipeableViewAnimator
- (void)animateView:(UIView *)view
              index:(NSUInteger)index
              views:(NSArray<UIView *> *)views
      swipeableView:(ZLSwipeableView *)swipeableView {
    CGFloat degree = sin(0.5 * index);
    NSTimeInterval duration = 0.4;
    CGPoint offset = CGPointMake(0, CGRectGetHeight(swipeableView.bounds) * 0.3);
    CGPoint translation = CGPointMake(degree * 10.0, -(index * 5.0));
    [self rotateAndTranslateView:view
                       forDegree:degree
                     translation:translation
                        duration:duration
              atOffsetFromCenter:offset
                   swipeableView:swipeableView];
}

// UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.loadCardFromXib = buttonIndex == 1;
    self.colorIndex = 0;
    [self.swipeableView discardAllViews];
    [self.swipeableView loadViewsIfNeeded];
}

// ZLSwipeableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
//    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

// ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.colorIndex >= self.colors.count) {
        self.colorIndex = 0;
    }
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = [self colorForName:self.colors[self.colorIndex]];
    self.tabbarView.backgroundColor = self.view.backgroundColor = view.backgroundColor;
    
    self.colorIndex++;
    
    if (self.loadCardFromXib) {
        UIView *contentView =
        [[NSBundle mainBundle] loadNibNamed:@"CardContentView" owner:self options:nil][0];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:contentView];
        
        // This is important:
        // https://github.com/zhxnlai/ZLSwipeableView/issues/9
        NSDictionary *metrics =
        @{ @"height" : @(view.bounds.size.height),
           @"width" : @(view.bounds.size.width) };
        NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
        [view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[contentView(width)]"
                              options:0
                              metrics:metrics
                              views:views]];
        [view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[contentView(height)]"
                              options:0
                              metrics:metrics
                              views:views]];
    }
    return view;
}

#pragma mark - Getter/Setter
- (ZLSwipeableView *)swipeableView {
    if (!_swipeableView) {
        _swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
        
        // Required Data Source
        _swipeableView.dataSource = self;
        
        // Optional Delegate
        _swipeableView.delegate = self;
        
        _swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        // 多层级
        _swipeableView.numberOfActiveViews = 10;
        _swipeableView.viewAnimator = self;
        // 切换方向
        _swipeableView.allowedDirection = ZLSwipeableViewDirectionVertical;
    }
    return _swipeableView;
}

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

- (GJHomeTabbarView *)tabbarView {
    if (!_tabbarView) {
        _tabbarView = [[GJHomeTabbarView alloc] initWithFrame:CGRectMake(0, SCREEN_H - 50, SCREEN_W, 50)];
        __weak typeof(self)weakSelf = self;
        _tabbarView.blockClickButton = ^(int idx) {
            if (idx != 0) {
                weakSelf.tabBarController.selectedIndex = idx;
                weakSelf.tabbarView.hidden = YES;
            }
        };
    }
    return _tabbarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
