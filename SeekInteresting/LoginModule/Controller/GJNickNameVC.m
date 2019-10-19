//
//  GJNickNameVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/19.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJNickNameVC.h"

@interface GJNickNameVC ()
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UILabel *detailLB;
@end

@implementation GJNickNameVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(NavBar_H);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleLB.mas_bottom).with.offset(NavBar_H);
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
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"请输入昵称";
        _titleLB.textColor = [UIColor colorWithRGB:185 g:219 b:254];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:18];
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (UILabel *)detailLB {
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.text = @"请输入昵称";
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        [_detailLB sizeToFit];
    }
    return _detailLB;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
