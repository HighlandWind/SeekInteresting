//
//  GJLaunchViewController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJLaunchViewController.h"
#import "GJLoginController.h"
#import "GJLoginApi.h"

@interface GJLaunchViewController ()
@property (nonatomic, strong)  UIImageView *loadingView;
@property (nonatomic, strong) NSTimer *endTimer;
@end

@implementation GJLaunchViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _loadingView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingView = [[UIImageView alloc] init];
    self.loadingView.image = [self getLaunchImage];
    [self.view addSubview:self.loadingView];
    
    [self initUserInfo];
    [self startTimer];
}

- (UIImage *)getLaunchImage {
    CGSize viewSize  =[UIScreen mainScreen].bounds.size;
    NSString * viewOrientation = @"Portrait";
    NSString * launchImage = nil;
    NSArray * imageDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary  * dict in imageDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    UIImage *image = [UIImage imageNamed:launchImage];
    return image;
}

- (void)startTimer {
    _endTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(countDown) userInfo:nil repeats:NO];
}

- (void)countDown {
    [_endTimer invalidate];
    _endTimer = nil;
    if(_finishBlock) _finishBlock();
}

- (void)initUserInfo {
    // 访客登录
    [GJLoginController needLoginSucessBlcok:nil];
    
    GJLoginApi *loginApi = [GJLoginApi new];
    
    // 上传用户设备信息 GJUserDeviceInfo
    GJUserDeviceInfo *device = [GJUserDeviceInfo new];
    device.brand = @"Apple";
    device.screenWidth = [NSString stringWithFormat:@"%.2f", SCREEN_W];
    device.screenHeight = [NSString stringWithFormat:@"%.2f", SCREEN_H];
    device.version = GetAppVersionCodeInfo();
    device.model = GetCurrentDeviceInfo();
    
    UIDevice *d = [UIDevice currentDevice];
    device.system = [NSString stringWithFormat:@"%@ %@", [d systemName], [d systemVersion]];
    device.platform = [d systemName];
    
    NSString *strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    device.language = strLanguage;  // eg:zh_CN
    device.fontSize = @"0";    // ?
    
    [loginApi requestPostUserDeviceInfoParam:device success:nil failure:nil];
    
    // 定期上传用户浏览记录 GJUserScanHistoryData
    // TODO
    
//    [loginApi requestPostUserHistoryParam:@[] success:nil failure:nil];
    
    // 获取用户信息
//    [loginApi requestGetUserInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
