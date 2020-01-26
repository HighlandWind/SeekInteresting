//
//  GJFeedbackVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJFeedbackVC.h"
#import "GJFeedbackTBVCell.h"
#import "GJMineManager.h"

@interface GJFeedbackVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <NSArray <GJFeedbackTBVCell *> *> *cells;
@property (nonatomic, strong) GJFeedbackTBVCell *cell1;
@property (nonatomic, strong) GJFeedbackTBVCell_2 *cell2;
@property (nonatomic, strong) GJFeedbackTBVCell_3 *cell3;
@property (nonatomic, strong) GJFeedbackTBVCell_4 *cell4;
@property (nonatomic, strong) GJMineManager *mineManager;
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    _cell1 = [GJFeedbackTBVCell new];
    _cell2 = [GJFeedbackTBVCell_2 new];
    _cell2.context = self;
    _cell3 = [GJFeedbackTBVCell_3 new];
    _cell4 = [GJFeedbackTBVCell_4 new];
    
    _cells = @[@[_cell1], @[_cell2], @[_cell3], @[_cell4]];
    
    _mineManager = [GJMineManager new];
}

- (void)initializationSubView {
    self.title = @"意见反馈";
    [self addSubview:self.tableView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    
}

#pragma mark - Request Handle


#pragma mark - Private methods
- (void)blockHanddle {
    __weak __typeof(self)weakSelf = self;
    _cell1.blockRefreshSubmitBtn = ^(BOOL is) {
        weakSelf.cell4.submitBtn.enabled = is;
    };
    _cell2.blockRefreshHeight = ^{
        [weakSelf.tableView reloadData];
    };
    _cell4.blockClickSubmit = ^{
        [weakSelf submit];
    };
}

#pragma mark - Public methods


#pragma mark - Event response
- (void)submit {
    if (_cell1.text.length == 0) {
        return;
    }
    
}

#pragma mark - Custom delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.section][indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.section][indexPath.row].height;
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
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
