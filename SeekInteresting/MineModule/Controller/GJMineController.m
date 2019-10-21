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

@interface GJMineController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) GJBaseTableViewCell *commonCell;
@property (nonatomic, strong) GJMineCenterCell *topCell;
@property (nonatomic, strong) GJMineCenterNoCell *topNoCell;
@property (nonatomic, strong) NSArray <GJNormalCellModel *> *cellModels;
@end

@implementation GJMineController

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
    _cellModels = @[model_1, model_2, model_3, model_4];
    
    _topCell = [GJMineCenterCell new];
    _topNoCell = [GJMineCenterNoCell new];
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


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    _topCell.blockClickMineInfo = ^{
        NSLog(@"mine");
    };
    _topNoCell.blockClickLogin = ^{
        [GJLoginController needLoginPresentWithVC:weakSelf loginSucessBlcok:^{
            weakSelf.commonCell = weakSelf.topCell;
            [weakSelf.tableView reloadData];
        }];
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
}

#pragma mark - Custom delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + _cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return _commonCell;
    }else {
        GJNormalTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[GJMineCenterCell reuseIndentifier]];
        if (!cell) {
            cell = [[GJNormalTBVCell alloc] initWithStyle:[GJNormalTBVCell expectingStyle] reuseIdentifier:[GJNormalTBVCell reuseIndentifier]];
        }
        [cell showBottomLine];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellModel = _cellModels[indexPath.row - 1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return AdaptatSize(300);
    }else {
        return AdaptatSize(80);
    }
}

#pragma mark - Getter/Setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[GJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain controller:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
