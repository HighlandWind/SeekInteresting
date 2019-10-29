//
//  GJMineController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/4/29.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJMineController.h"
#import "GJMineCenterCell.h"
#import "GJMineCenterNoCell.h"
#import "GJNormalTBVCell.h"
#import "GJLoginController.h"
#import "GJBirthdaySelectVC.h"
#import "GJMineSettingVC.h"
#import "GJMineInfoVC.h"
#import "GJFeedbackVC.h"

@interface GJMineController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJBaseTableViewCell *commonCell;
@property (nonatomic, strong) GJMineCenterCell *topCell;
@property (nonatomic, strong) GJMineCenterNoCell *topNoCell;
@property (nonatomic, strong) NSArray <NSArray <GJNormalCellModel *> *> *cellModels;
@property (nonatomic, strong) GJMineSettingVC *settingVC;
@property (nonatomic, strong) GJFeedbackVC *feedbackVC;
@property (nonatomic, strong) GJMineInfoVC *infoVC;
@end

@implementation GJMineController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(-[UIApplication sharedApplication].statusBarFrame.size.height);
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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    GJNormalCellModel *model_1 = [GJNormalCellModel cellModelTitle:@"消息" detail:@"" imageName:@"消息" acessoryType:1];
    GJNormalCellModel *model_2 = [GJNormalCellModel cellModelTitle:@"我的作品" detail:@"" imageName:@"缓存" acessoryType:1];
    GJNormalCellModel *model_3 = [GJNormalCellModel cellModelTitle:@"用户反馈" detail:@"" imageName:@"用户反馈" acessoryType:1];
    GJNormalCellModel *model_4 = [GJNormalCellModel cellModelTitle:@"系统设置" detail:@"" imageName:@"系统设置" acessoryType:1];
    _cellModels = @[@[[GJNormalCellModel new]], @[model_1], @[model_2], @[model_3], @[model_4]];
    
    _topCell = [GJMineCenterCell new];
    _topNoCell = [GJMineCenterNoCell new];
    
    _settingVC = [GJMineSettingVC new];
    _feedbackVC = [GJFeedbackVC new];
    _infoVC = [GJMineInfoVC new];
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    self.tableView.backgroundColor = APP_CONFIG.appBackgroundColor;
    [self addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    if (!JudgeContainerCountIsNull(APP_USER.userInfo.mobile)) {
        _commonCell = _topCell;
    }else {
        _commonCell = _topNoCell;
    }
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods
- (void)gotoLogin {
    [GJLoginController needLoginPresentWithVC:self loginSucessBlcok:^{
        self.commonCell = self.topCell;
        [self.tableView reloadData];
    }];
}

- (void)gotoSetting {
    [_settingVC pushPageWith:self];
}

#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _topCell.blockClickMineInfo = ^{
        [weakSelf.infoVC pushPageWith:weakSelf];
    };
    _topNoCell.blockClickLogin = ^{
        [weakSelf gotoLogin];
    };
    _topCell.blockClickLikes = ^{
        NSLog(@"likes");
    };
    _topCell.blockClickStar = ^{
        NSLog(@"star");
    };
    _topCell.blockClickHistory = ^{
        NSLog(@"history");
    };
    _settingVC.blockClickLogout = ^{
        weakSelf.commonCell = weakSelf.topNoCell;
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - Custom delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellModels[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return _commonCell;
    }else {
        GJNormalTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJNormalTBVCell reuseIndentifier]];
        if (!cell) {
            cell = [[GJNormalTBVCell alloc] initWithStyle:[GJNormalTBVCell expectingStyle] reuseIdentifier:[GJNormalTBVCell reuseIndentifier]];
        }
        if (indexPath.section == 3) {
            [cell showBottomLine];
        }
        cell.textLabel.font = [APP_CONFIG appAdaptFontOfSize:18];
        cell.textLabel.textColor = APP_CONFIG.grayTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellModel = _cellModels[indexPath.section][indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return _commonCell.height;
    }else {
        return AdaptatSize(68);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section != 3) {
        return AdaptatSize(7);
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section != 3) {
        UIView *v = [UIView new];
        v.backgroundColor = APP_CONFIG.appBackgroundColor;
        return v;
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_commonCell == _topCell) {
        if (indexPath.section == 1) {
            NSLog(@"message");
        }else if (indexPath.section == 2) {
            NSLog(@"works");
        }else if (indexPath.section == 3) {
            [_feedbackVC pushPageWith:self];
        }else if (indexPath.section == 4) {
            [self gotoSetting];
        }
    }else {
        if (indexPath.section != 0) {
            if (indexPath.section == 4) {
                [self gotoSetting];
            }else {
                [self gotoLogin];
            }
        }
    }
}

#pragma mark - Getter/Setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
