//
//  GJSeekEatController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/14.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEatController.h"
#import "GJSeekEatTopView.h"
#import "GJSeekEatSureController.h"

@interface GJSeekEatController ()
@property (nonatomic, strong) GJSeekEatTopView *topView;
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) UILabel *centerLB;
@property (nonatomic, strong) GJSeekLRBtn *bottomBtn;
@end

@implementation GJSeekEatController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(20));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.view).with.offset(NavBar_H - 30);
        make.height.mas_equalTo(AdaptatSize(65));
    }];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
//        make.bottom.equalTo(self.selectEatBtn.mas_top).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.topView.mas_bottom).with.offset(AdaptatSize(40));
    }];
    [_centerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerImgView);
        make.top.equalTo(self.centerImgView.mas_bottom).with.offset(AdaptatSize(25));
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(50));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(50));
        make.height.mas_equalTo(AdaptatSize(38));
        make.top.equalTo(self.centerLB.mas_bottom).with.offset(AdaptatSize(50));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
}

- (void)initializationSubView {
    self.title = @"找点吃的";
    [self showShadorOnNaviBar:NO];
    [self addSubview:self.topView];
    [self addSubview:self.centerImgView];
    [self addSubview:self.centerLB];
    [self addSubview:self.bottomBtn];
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
    _bottomBtn.blockClickLeft = ^{
        NSLog(@"left");
    };
    _bottomBtn.blockClickRight = ^{
        GJSeekEatSureController *vc = [[GJSeekEatSureController alloc] init];
//        [vc pushPageWith:weakSelf];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (GJSeekEatTopView *)topView {
    if (!_topView) {
        _topView = [GJSeekEatTopView installTitle:@"中午好！" detail:@"现在是午餐时间，吃点什么呢？"];
    }
    return _topView;
}

- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"火锅"]];
        _centerImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _centerImgView;
}

- (UILabel *)centerLB {
    if (!_centerLB) {
        _centerLB = [[UILabel alloc] init];
        _centerLB.font = [APP_CONFIG appAdaptFontOfSize:13];
        _centerLB.textColor = APP_CONFIG.grayTextColor;
        _centerLB.numberOfLines = 0;
        _centerLB.textAlignment = NSTextAlignmentCenter;
        _centerLB.text = @"建议您吃顿火锅把，别问为什么\n这么冷的天，当然火锅啦！";
        [_centerLB sizeToFit];
    }
    return _centerLB;
}

- (GJSeekLRBtn *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[GJSeekLRBtn alloc] initLeft:@"换其他的" right:@"就这个"];
    }
    return _bottomBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
