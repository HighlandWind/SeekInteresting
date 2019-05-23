//
//  GJHomeController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/4/29.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJHomeController.h"
#import "GJHomeSelectBtn.h"
#import "GJSeekEatController.h"
#import "GJSeekEventController.h"

@interface GJHomeController ()
@property (nonatomic, strong) GJHomeSelectBtn *selectEatBtn;
@property (nonatomic, strong) GJHomeSelectBtn *selectEventBtn;
@property (nonatomic, strong) GJHomeTopView *topView;
@property (nonatomic, strong) UIImageView *centerImgView;
@end

@implementation GJHomeController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(20));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(20));
//        make.top.equalTo(self.view).with.offset(AdaptatSize(10));
        make.top.equalTo(self.view).with.offset(NavBar_H - 30);
//        make.top.equalTo(self.view).with.offset(NavBar_H - AdaptatSize(10));
        make.height.mas_equalTo(AdaptatSize(65));
    }];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
        make.bottom.equalTo(self.selectEatBtn.mas_top).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.topView.mas_bottom);
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
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.frame = CGRectZero;
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
}

- (void)initializationSubView {
//    self.title = @"找点事做";
    [self showShadorOnNaviBar:NO];
    [self addSubview:self.selectEatBtn];
    [self addSubview:self.selectEventBtn];
    [self addSubview:self.topView];
    [self addSubview:self.centerImgView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _selectEatBtn.blockClickGoto = ^{
        NSLog(@"=============");
        GJSeekEatController *vc = [[GJSeekEatController alloc] init];
//        [vc pushPageWith:weakSelf];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    _selectEventBtn.blockClickGoto = ^{
        NSLog(@"-------------");
        GJSeekEventController *vc = [[GJSeekEventController alloc] init];
//        [vc pushPageWith:weakSelf];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
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

- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_body_girl"]];
        _centerImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _centerImgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
