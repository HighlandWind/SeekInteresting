//
//  GJMineSettingVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJMineSettingVC.h"
#import "GJNormalTBVCell.h"
#import "GJAboutVC.h"
#import "GJMineInfoVC.h"

@interface GJMineSettingVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <NSArray <GJNormalCellModel *> *> *cellModels;
@end

@implementation GJMineSettingVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
    [self showShadorOnNaviBar:NO];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    GJNormalCellModel *model_1 = [GJNormalCellModel cellModelTitle:@"  个人资料" detail:@"" imageName:@"" acessoryType:1];
    GJNormalCellModel *model_2 = [GJNormalCellModel cellModelTitle:@"  字体大小" detail:@"标准" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_3 = [GJNormalCellModel cellModelTitle:@"  夜间模式" detail:@"" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_4 = [GJNormalCellModel cellModelTitle:@"  推送设置" detail:@"开启推送，获取更多有趣的信息" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_5 = [GJNormalCellModel cellModelTitle:@"  清除缓存" detail:@"0 MB" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_6 = [GJNormalCellModel cellModelTitle:@"  关于" detail:@"" imageName:@"" acessoryType:1];
    GJNormalCellModel *model_7 = [GJNormalCellModel cellModelTitle:@"  退出登录" detail:@"" imageName:@"" acessoryType:0];
    _cellModels = @[@[model_1], @[model_2, model_3, model_4, model_5], @[model_6], @[model_7]];
}

- (void)initializationSubView {
    self.title = @"设置";
    [self addSubview:self.tableView];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)logout {
    BLOCK_SAFE(self.blockClickLogout)();
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - Custom delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellModels[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJNormalTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJNormalTBVCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJNormalTBVCell alloc] initWithStyle:[GJNormalTBVCell expectingStyle] reuseIdentifier:[GJNormalTBVCell reuseIndentifier]];
    }
    if (indexPath.section == 1 && indexPath.row != 3) {
        [cell showBottomLine];
    }
    if (indexPath.section == 3) {
        cell.textLabel.textColor = APP_CONFIG.appMainRedColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;   // TODO
    }else {
        cell.textLabel.textColor = APP_CONFIG.darkTextColor;
    }
    cell.textLabel.font = [APP_CONFIG appAdaptFontOfSize:18];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellModel = _cellModels[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(65);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 1) {
        if (section == 3) {
            return AdaptatSize(80);
        }
        return AdaptatSize(7);
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 1) {
        UIView *v = [UIView new];
        v.backgroundColor = APP_CONFIG.appBackgroundColor;
        return v;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section != 1) {
        return AdaptatSize(7);
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section != 1) {
        UIView *v = [UIView new];
        v.backgroundColor = APP_CONFIG.appBackgroundColor;
        return v;
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GJMineInfoVC *vc = [GJMineInfoVC new];
        [vc pushPageWith:self];
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        GJAboutVC *vc = [GJAboutVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3) {
        [self logout];
    }
}

#pragma mark - Getter/Setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = APP_CONFIG.appBackgroundColor;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
