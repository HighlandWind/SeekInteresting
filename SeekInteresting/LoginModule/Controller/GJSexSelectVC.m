//
//  GJSexSelectVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/20.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJSexSelectVC.h"
#import "GJBirthdaySelectVC.h"

@interface GJSexSelectVC ()
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UILabel *detailLB;
@property (nonatomic, strong) UIButton *nanBtn;
@property (nonatomic, strong) UIButton *nvBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@end

@implementation GJSexSelectVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(NavBar_H+AdaptatSize(60));
    }];
    [_nanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AdaptatSize(80));
        make.height.mas_equalTo(AdaptatSize(90));
        make.top.equalTo(self.titleLB.mas_bottom).with.offset(AdaptatSize(15));
        make.right.equalTo(self.view.mas_centerX).with.offset(-AdaptatSize(20));
    }];
    [_nvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self.nanBtn);
        make.left.equalTo(self.view.mas_centerX).with.offset(AdaptatSize(20));
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.nanBtn.mas_bottom).with.offset(AdaptatSize(30));
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nanBtn.mas_bottom).with.offset(AdaptatSize(30));
        make.left.equalTo(self.view).with.offset(AdaptatSize(15));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(15));
        make.height.mas_equalTo(AdaptatSize(40));
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
    [self showShadorOnNaviBar:NO];
    [self allowBackWithImage:@"arrow_back_white"];
    [self addSubview:self.titleLB];
    [self addSubview:self.detailLB];
    [self addSubview:self.nanBtn];
    [self addSubview:self.nvBtn];
    [self addSubview:self.nextBtn];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)nanBtnClick {
    _nanBtn.selected = YES;
    _nvBtn.selected = NO;
    if (!_detailLB.hidden) {
        _detailLB.hidden = YES;
        _nextBtn.hidden = NO;
    }
}

- (void)nvBtnClick {
    _nanBtn.selected = NO;
    _nvBtn.selected = YES;
    if (!_detailLB.hidden) {
        _detailLB.hidden = YES;
        _nextBtn.hidden = NO;
    }
}

- (void)nextBtnClick {
    GJBirthdaySelectVC *vc = [GJBirthdaySelectVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"账号注册";
        _titleLB.textColor = [UIColor colorWithRGB:185 g:219 b:254];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:20];
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (UILabel *)detailLB {
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.text = @"稍后您可以以在我的资料中更改";
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_detailLB sizeToFit];
    }
    return _detailLB;
}

- (UIButton *)nanBtn {
    if (!_nanBtn) {
        _nanBtn = [[UIButton alloc] init];
        _nanBtn.layer.borderColor = [UIColor colorWithRGB:204 g:218 b:231].CGColor;
        _nanBtn.layer.borderWidth = 1;
        _nanBtn.layer.cornerRadius = 5;
        _nanBtn.clipsToBounds = YES;
        [_nanBtn setTitle:@"男" forState:UIControlStateNormal];
        [_nanBtn setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
        [_nanBtn addTarget:self action:@selector(nanBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_nanBtn setBackgroundImage:CreatImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
        [_nanBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:121 g:193 b:248]) forState:UIControlStateSelected];
        [_nanBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:121 g:193 b:248]) forState:UIControlStateHighlighted];
    }
    return _nanBtn;
}

- (UIButton *)nvBtn {
    if (!_nvBtn) {
        _nvBtn = [[UIButton alloc] init];
        _nvBtn.layer.borderColor = _nanBtn.layer.borderColor;
        _nvBtn.layer.borderWidth = 1;
        _nvBtn.layer.cornerRadius = 5;
        _nvBtn.clipsToBounds = YES;
        [_nvBtn setTitle:@"女" forState:UIControlStateNormal];
        [_nvBtn setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
        [_nvBtn addTarget:self action:@selector(nvBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_nvBtn setBackgroundImage:CreatImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
        [_nvBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:121 g:193 b:248]) forState:UIControlStateSelected];
        [_nvBtn setBackgroundImage:CreatImageWithColor([UIColor colorWithRGB:121 g:193 b:248]) forState:UIControlStateHighlighted];
    }
    return _nvBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"继续" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:[UIColor colorWithRGB:185 g:219 b:254]];
        _nextBtn.layer.cornerRadius = AdaptatSize(40) / 2;
        _nextBtn.clipsToBounds = YES;
        _nextBtn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = YES;
    }
    return _nextBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
