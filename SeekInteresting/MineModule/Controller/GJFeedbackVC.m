//
//  GJFeedbackVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJFeedbackVC.h"
#import "GJNormalTBVCell.h"

@interface GJFeedbackVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <NSArray <GJNormalCellModel *> *> *cellModels;
@end

@implementation GJFeedbackVC

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
    GJNormalCellModel *model_1 = [GJNormalCellModel cellModelTitle:@"请输入反馈内容" detail:@"" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_2 = [GJNormalCellModel cellModelTitle:@"图片上传" detail:@"" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_3 = [GJNormalCellModel cellModelTitle:@"联系方式" detail:@"" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_4 = [GJNormalCellModel cellModelTitle:@"提交反馈" detail:@"" imageName:@"" acessoryType:0];
    _cellModels = @[@[model_1], @[model_2], @[model_3], @[model_4]];
}

- (void)initializationSubView {
    self.title = @"意见反馈";
    [self addSubview:self.tableView];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


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
    GJNormalTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJNormalTBVCell reuseIndentifier]];
    if (!cell) {
        cell = [[GJNormalTBVCell alloc] initWithStyle:[GJNormalTBVCell expectingStyle] reuseIdentifier:[GJNormalTBVCell reuseIndentifier]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellModel = _cellModels[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AdaptatSize(200);
    }else if (indexPath.section == 1) {
        return AdaptatSize(80);
    }else {
        return AdaptatSize(65);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptatSize(7);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = APP_CONFIG.appBackgroundColor;
    return v;
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
