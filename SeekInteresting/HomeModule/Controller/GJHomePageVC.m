//
//  GJHomePageVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/1.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJHomePageVC.h"
#import "GJHomeSelectBtn.h"
#import "GJSeekEatController.h"
#import "GJSeekEventController.h"
#import "HDeviceIdentifier.h"

@interface GJHomePageVC ()
@property (nonatomic, strong) GJHomeSelectBtn *selectEatBtn;
@property (nonatomic, strong) GJHomeSelectBtn *selectEventBtn;
@property (nonatomic, strong) GJHomeTopView *topView;
@property (nonatomic, strong) UIImageView *backImgView;
@end

@implementation GJHomePageVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(20));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.view).with.offset(NavBar_H - AdaptatSize(25));
        make.height.mas_equalTo(AdaptatSize(65));
    }];
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_selectEatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
        make.top.equalTo(self.view.mas_centerY).with.offset(AdaptatSize(40));
        make.height.mas_equalTo(AdaptatSize(84));
    }];
    [_selectEventBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.selectEatBtn);
        make.top.equalTo(self.selectEatBtn.mas_bottom).with.offset(AdaptatSize(20));
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
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.frame = CGRectZero;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
//    NSString *UDID = [HDeviceIdentifier deviceIdentifier];
//    NSLog(@"UUID:%@",UDID);
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self addSubview:self.backImgView];
    [self addSubview:self.selectEatBtn];
    [self addSubview:self.selectEventBtn];
    [self addSubview:self.topView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    [self showManPage:YES];
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)showManPage:(BOOL)man {
    _topView.isMan = _selectEventBtn.isMan = _selectEatBtn.isMan = man;
    _backImgView.image = [UIImage imageNamed:man ? @"home_man" : @"home_woman"];
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _selectEatBtn.blockClickGoto = ^{
        GJSeekEatController *vc = [[GJSeekEatController alloc] init];
        [vc pushPageWith:weakSelf];
    };
    _selectEventBtn.blockClickGoto = ^{
        GJSeekEventController *vc = [[GJSeekEventController alloc] init];
        [vc pushPageWith:weakSelf];
    };
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (GJHomeSelectBtn *)selectEatBtn {
    if (!_selectEatBtn) {
        _selectEatBtn = [[GJHomeSelectBtn alloc] initWithType:SelectPageType_Eat];
    }
    return _selectEatBtn;
}

- (GJHomeSelectBtn *)selectEventBtn {
    if (!_selectEventBtn) {
        _selectEventBtn = [[GJHomeSelectBtn alloc] initWithType:SelectPageType_Event];
    }
    return _selectEventBtn;
}

- (GJHomeTopView *)topView {
    if (!_topView) {
        _topView = [GJHomeTopView install];
    }
    return _topView;
}

- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] init];
        _backImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
