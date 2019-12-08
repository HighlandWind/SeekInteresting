//
//  GJFeedbackVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJFeedbackVC.h"
#import "GJFeedbackTBVCell.h"

@interface GJFeedbackVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) NSArray <NSArray <GJFeedbackTBVCell *> *> *cells;
@property (nonatomic, strong) GJFeedbackTBVCell_2 *cell2;
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
    GJFeedbackTBVCell *cell1 = [GJFeedbackTBVCell new];
    _cell2 = [GJFeedbackTBVCell_2 new];
    _cell2.context = self;
    GJFeedbackTBVCell_3 *cell3 = [GJFeedbackTBVCell_3 new];
    GJFeedbackTBVCell_4 *cell4 = [GJFeedbackTBVCell_4 new];
    
    _cells = @[@[cell1], @[_cell2], @[cell3], @[cell4]];
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
    _cell2.blockRefreshHeight = ^{
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - Public methods


#pragma mark - Event response


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
