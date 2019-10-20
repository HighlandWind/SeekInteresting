//
//  GJBirthdaySelectVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/20.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJBirthdaySelectVC.h"
#import "GJPhoneVC.h"
#import "GJBirthdayTimeView.h"

@interface GJBirthdaySelectVC ()
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UILabel *detailLB;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) GJBirthdayTimeView *birthView;
@property (strong, nonatomic) UIButton *skipBtn;
@end

@implementation GJBirthdaySelectVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_birthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(AdaptatSize(30));
        make.width.mas_equalTo(AdaptatSize(260));
        make.height.mas_equalTo(AdaptatSize(200));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.birthView.mas_top).with.offset(-AdaptatSize(50));
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.birthView.mas_bottom).with.offset(AdaptatSize(50));
        make.centerX.equalTo(self.view);
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IPHONE_X) {
            make.top.equalTo(self.detailLB.mas_bottom).with.offset(AdaptatSize(50));
        }else {
            make.top.equalTo(self.detailLB.mas_bottom).with.offset(AdaptatSize(40));
        }
        make.left.equalTo(self.view).with.offset(AdaptatSize(15));
        make.right.equalTo(self.view).with.offset(-AdaptatSize(15));
        make.height.mas_equalTo(AdaptatSize(40));
    }];
    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (IPHONE_X) {
            make.top.equalTo(self.nextBtn.mas_bottom).with.offset(AdaptatSize(40));
        }else {
            make.top.equalTo(self.nextBtn.mas_bottom).with.offset(AdaptatSize(30));
        }
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
    [self addSubview:self.nextBtn];
    [self addSubview:self.skipBtn];
    [self addSubview:self.birthView];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)nextBtnClick {
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSInteger year = [[dateformatter stringFromDate:[NSDate date]] integerValue];
    if (year < (self.birthView.selectDate.year + 10)) {
        ShowWaringAlertHUD(@"请选择有效的出生日期", self.view);
        return;
    }
    
    GJPhoneVC *vc = [GJPhoneVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)skipBtnClick {
    [self nextBtnClick];
    
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"请输入生日";
        _titleLB.textColor = [UIColor colorWithRGB:185 g:219 b:254];
        _titleLB.font = [APP_CONFIG appAdaptBoldFontOfSize:20];
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (UILabel *)detailLB {
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.text = @"我们将用来为您匹配更合适的信息，\n您也可以稍候再进行设置";
        _detailLB.textColor = APP_CONFIG.grayTextColor;
        _detailLB.textAlignment = NSTextAlignmentCenter;
        _detailLB.font = [APP_CONFIG appAdaptFontOfSize:16];
        _detailLB.numberOfLines = 2;
        [_detailLB sizeToFit];
    }
    return _detailLB;
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
    }
    return _nextBtn;
}

- (UIButton *)skipBtn {
    if (!_skipBtn) {
        _skipBtn = [[UIButton alloc] init];
        _skipBtn.titleLabel.font = _nextBtn.titleLabel.font;
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipBtn setTitleColor:_nextBtn.backgroundColor forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

- (GJBirthdayTimeView *)birthView {
    if (!_birthView) {
        _birthView = [[GJBirthdayTimeView alloc] init];
    }
    return _birthView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
