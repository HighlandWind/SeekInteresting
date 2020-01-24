//
//  GJTabBarController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJTabBarController.h"
#import "GJTabBar.h"
#import "GJBaseNavigationController.h"
#import "UIColor+Extension.h"
#import "GJConfigureManager.h"
#import "GJFunctionManager.h"

#import "GJDiscoverController.h"
#import "GJMineController.h"
#import "GJHomePageController.h"

@interface GJTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, strong) GJTabBar *tabbarV;
@property (nonatomic, strong) GJHomePageController *homeVC;
@property (nonatomic, strong) GJDiscoverController *discoverVC;
@property (nonatomic, strong) GJMineController *mineVC;

@end

@implementation GJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    // Create owner-tabbar, use KVC repleace system-tabbar  with owner-tabbar.
    _tabbarV = [[GJTabBar alloc] init];
    [self setValue:_tabbarV forKeyPath:@"tabBar"];
    
    _homeVC = [[GJHomePageController alloc] init];
    _discoverVC = [[GJDiscoverController alloc] init];
    _mineVC = [[GJMineController alloc] init];
    
    GJBaseNavigationController *firstTab = [self createTabItemVC:_homeVC norImg:@"home_p" selectImg:@"home" Title:@"首页"];
    GJBaseNavigationController *secondTab = [self createTabItemVC:_discoverVC norImg:@"收藏_p" selectImg:@"收藏" Title:@"任务"];
    GJBaseNavigationController *thirdTab = [self createTabItemVC:_mineVC norImg:@"我的_p" selectImg:@"我的" Title:@"我的"];
    
    self.viewControllers = @[firstTab, secondTab, thirdTab];
    self.tabBarController.selectedIndex = 0;
    [self setBartitleColor];
}

- (void)setBartitleColor{
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexRGB:@"999999"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:APP_CONFIG.darkTextColor} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
}

- (GJBaseNavigationController *)createTabItemVC:(UIViewController *)vc norImg:(NSString *)norImg selectImg:(NSString *)selectImg  Title:(NSString *)title {
    GJBaseNavigationController *tab = [[GJBaseNavigationController alloc] initWithRootViewController:vc];
    tab.tabBarItem.image = [[UIImage imageNamed:norImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.tabBarItem.selectedImage = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.tabBarItem.title = title;
    return tab;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
