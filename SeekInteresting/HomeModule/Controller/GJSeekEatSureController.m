//
//  GJSeekEatSureController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/5/16.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSeekEatSureController.h"
#import "GJSeekEatDetailController.h"

@interface GJSeekEatSureController ()
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) UIButton *tasteBtn;
@property (nonatomic, strong) UILabel *centerLB;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *changeBtn;
@end

@implementation GJSeekEatSureController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AdaptatSize(20));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(20));
        make.top.equalTo(self.view).with.offset(NavBar_H - 30);
    }];
    [_tasteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.centerImgView.mas_bottom).with.offset(AdaptatSize(20));
    }];
    [_centerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).with.offset(AdaptatSize(50));
    }];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(AdaptatSize(40));
        make.top.equalTo(self.centerLB.mas_bottom).with.offset(AdaptatSize(15));
        make.width.mas_equalTo(AdaptatSize(258));
    }];
    [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.sureBtn.mas_bottom).with.offset(AdaptatSize(12));
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
    [self addSubview:self.centerImgView];
    [self addSubview:self.tasteBtn];
    [self addSubview:self.centerLB];
    [self addSubview:self.sureBtn];
    [self addSubview:self.changeBtn];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)tasteBtnClick {
    
}

- (void)sureBtnClick {
    GJSeekEatDetailController *vc = [[GJSeekEatDetailController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"火锅"]];
        _centerImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _centerImgView;
}

- (UIButton *)tasteBtn {
    if (!_tasteBtn) {
        _tasteBtn = [[UIButton alloc] init];
        _tasteBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:18];
        [_tasteBtn setTitleColor:APP_CONFIG.appMainColor forState:UIControlStateNormal];
        [_tasteBtn setTitle:@"麻辣口味" forState:UIControlStateNormal];
        [_tasteBtn addTarget:self action:@selector(tasteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_tasteBtn sizeToFit];
    }
    return _tasteBtn;
}

- (UILabel *)centerLB {
    if (!_centerLB) {
        _centerLB = [[UILabel alloc] init];
        _centerLB.font = [APP_CONFIG appAdaptFontOfSize:13];
        _centerLB.textColor = APP_CONFIG.blackTextColor;
        _centerLB.text = @"选你，没理由！任性，喜欢吃！";
        [_centerLB sizeToFit];
    }
    return _centerLB;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        _sureBtn.titleLabel.font = [APP_CONFIG appAdaptBoldFontOfSize:19];
        [_sureBtn setTitleColor:APP_CONFIG.whiteGrayColor forState:UIControlStateNormal];
        [_sureBtn setTitle:@"就这个" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.clipsToBounds = YES;
        _sureBtn.layer.cornerRadius = AdaptatSize(40) / 2;
        _sureBtn.backgroundColor = APP_CONFIG.appMainColor;
    }
    return _sureBtn;
}

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [[UIButton alloc] init];
        _changeBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:13];
        [_changeBtn setTitle:@"不乐意吃火锅？换其他的！" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor colorWithRGB:74 g:144 b:226] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_changeBtn sizeToFit];
    }
    return _changeBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
