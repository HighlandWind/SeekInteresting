//
//  GJMineInfoVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJMineInfoVC.h"
#import "GJMineInfoTBVCell.h"

@interface GJMineInfoVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <NSArray <GJNormalCellModel *> *> *cellModels;
@end

@implementation GJMineInfoVC

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
    GJNormalCellModel *model_1 = [GJNormalCellModel cellModelTitle:@"  头像" detail:@"" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_2 = [GJNormalCellModel cellModelTitle:@"  用户昵称" detail:@"沉淀" imageName:@"" acessoryType:1];
    GJNormalCellModel *model_3 = [GJNormalCellModel cellModelTitle:@"  性别" detail:@"男" imageName:@"" acessoryType:1];
    GJNormalCellModel *model_4 = [GJNormalCellModel cellModelTitle:@"  生日" detail:@"1987-10-15" imageName:@"" acessoryType:1];
    GJNormalCellModel *model_5 = [GJNormalCellModel cellModelTitle:@"  地区" detail:@"贵州省贵阳市" imageName:@"" acessoryType:1];
    _cellModels = @[@[model_1,model_2, model_3, model_4, model_5]];
}

- (void)initializationSubView {
    self.title = @"编辑资料";
    [self addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)blockHanddle {
    
}

#pragma mark - Public methods


#pragma mark - Event response


#pragma mark - Custom delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellModels[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJMineInfoTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJNormalTBVCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJMineInfoTBVCell alloc] initWithStyle:[GJMineInfoTBVCell expectingStyle] reuseIdentifier:[GJNormalTBVCell reuseIndentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showBottomLine];
    }
    cell.cellModel = _cellModels[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return AdaptatSize(140);
    }
    return AdaptatSize(70);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptatSize(7);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = APP_CONFIG.appBackgroundColor;
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptatSize(7);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = APP_CONFIG.appBackgroundColor;
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Getter/Setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = APP_CONFIG.appBackgroundColor;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
