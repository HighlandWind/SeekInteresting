//
//  GJMineCenterCell.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/8/4.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJMineCenterCell.h"
#import "GJMineCenterNoCell.h"

@interface GJMineCenterCell ()
@property (nonatomic, strong) GJCustomNoButton *loginBtn;
@property (nonatomic, strong) UIButton *mineBtn;
@property (nonatomic, strong) UIButton *infoBtn;
@property (nonatomic, strong) UILabel *nicknameLB;
@property (nonatomic, strong) UIImageView *nicknameImg;

@property (nonatomic, strong) GJCustomNoButton *likesBtn;
@property (nonatomic, strong) GJCustomNoButton *starBtn;
@property (nonatomic, strong) GJCustomNoButton *historyBtn;
@end

@implementation GJMineCenterCell

- (void)loginBtnClick {
    BLOCK_SAFE(_blockClickMineInfo)();
}

- (void)likesBtnClick {
    BLOCK_SAFE(_blockClickLikes)();
}

- (void)starBtnClick {
    BLOCK_SAFE(_blockClickStar)();
}

- (void)historyBtnClick {
    BLOCK_SAFE(_blockClickHistory)();
}

- (CGFloat)height {
    return AdaptatSize(250) + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _loginBtn = [[GJCustomNoButton alloc] init];
        _loginBtn.btnImg.image = [UIImage imageNamed:@"默认头像"];
        _loginBtn.image_edge = AdaptatSize(100);
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _nicknameLB = [[UILabel alloc] init];
        _nicknameLB.textColor = APP_CONFIG.darkTextColor;
        _nicknameLB.font = [APP_CONFIG appAdaptFontOfSize:17];
        [_nicknameLB sizeToFit];
        _nicknameLB.text = @"哈哈哈";
        
        _infoBtn = [[UIButton alloc] init];
        [_infoBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _nicknameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更多"]];
        _nicknameImg.contentMode = UIViewContentModeScaleAspectFit;
        
        _likesBtn = [[GJCustomNoButton alloc] init];
        _likesBtn.btnLB.text = @"我喜欢的";
        _likesBtn.btnImg.image = [UIImage imageNamed:@"我喜欢"];
        [_likesBtn addTarget:self action:@selector(likesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _starBtn = [[GJCustomNoButton alloc] init];
        _starBtn.btnLB.text = @"我的点赞";
        _starBtn.btnImg.image = [UIImage imageNamed:@"点赞"];
        [_starBtn addTarget:self action:@selector(starBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _historyBtn = [[GJCustomNoButton alloc] init];
        _historyBtn.btnLB.text = @"历史浏览";
        _historyBtn.btnImg.image = [UIImage imageNamed:@"历史浏览"];
        [_historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_loginBtn];
        [self addSubview:_infoBtn];
        [self addSubview:_nicknameLB];
        [self addSubview:_nicknameImg];
        [self addSubview:_likesBtn];
        [self addSubview:_starBtn];
        [self addSubview:_historyBtn];
    }
    return self;
}

- (void)setModel:(NSString *)model {
    _model = model;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(AdaptatSize(30));
        make.centerY.equalTo(self).with.offset(-AdaptatSize(20));
        make.width.mas_equalTo(AdaptatSize(100));
        make.height.mas_equalTo(AdaptatSize(130));
    }];
    [_nicknameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-AdaptatSize(30));
        make.centerY.equalTo(self.loginBtn);
        make.width.height.mas_equalTo(AdaptatSize(25));
    }];
    [_nicknameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginBtn);
        make.right.equalTo(self.nicknameImg.mas_left).with.offset(-AdaptatSize(10));
    }];
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.loginBtn);
    }];
    [_likesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).with.offset(-AdaptatSize(25));
        make.width.mas_equalTo(SCREEN_W / 3);
        make.height.mas_equalTo(AdaptatSize(65));
    }];
    [_starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.likesBtn);
        make.centerX.equalTo(self);
        make.width.height.equalTo(self.likesBtn);
    }];
    [_historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self.likesBtn);
        make.width.height.equalTo(self.likesBtn);
    }];
}

@end
