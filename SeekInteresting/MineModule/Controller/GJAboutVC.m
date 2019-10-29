//
//  GJAboutVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/10/23.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJAboutVC.h"
#import "GJNormalTBVCell.h"
#import "TKWebMedia.h"

@interface GJAboutVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GJBaseTableView *tableView;
@property (nonatomic, strong) UILabel *btmLabel;
@property (nonatomic, strong) NSArray <NSArray <GJNormalCellModel *> *> *cellModels;
@end

@implementation GJAboutVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_btmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (IPHONE_X) {
            make.bottom.equalTo(self.view).with.offset(-AdaptatSize(50));
        }else {
            make.bottom.equalTo(self.view).with.offset(-AdaptatSize(20));
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
    GJNormalCellModel *model_1 = [GJNormalCellModel cellModelTitle:@"当前版本" detail:@"1.0.0 Beta" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_2 = [GJNormalCellModel cellModelTitle:@"最新版本" detail:@"1.0.0 Beta" imageName:@"" acessoryType:0];
    GJNormalCellModel *model_3 = [GJNormalCellModel cellModelTitle:@"用户协议" detail:@"" imageName:@"" acessoryType:1];
    GJNormalCellModel *model_4 = [GJNormalCellModel cellModelTitle:@"隐私条款" detail:@"" imageName:@"" acessoryType:1];
    _cellModels = @[@[model_1, model_2], @[model_3, model_4]];
}

- (void)initializationSubView {
    self.title = @"关于";
    [self allowBack];
    [self showShadorOnNaviBar:NO];
    [self addSubview:self.tableView];
    [self addSubview:self.btmLabel];
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
    if (indexPath.row == 0) {
        [cell showBottomLine];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellModel = _cellModels[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AdaptatSize(65);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AdaptatSize(200);
    }else {
        return AdaptatSize(7);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = APP_CONFIG.appBackgroundColor;
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [TKWebMedia customPresentWebViewJumpUrl:@"http://www.baidu.com" title:nil controller:self];
        }else if (indexPath.row == 1) {
            [TKWebMedia customPresentWebViewJumpUrl:@"http://www.baidu.com" title:nil controller:self];
        }
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

- (UILabel *)btmLabel {
    if (!_btmLabel) {
        _btmLabel = [[UILabel alloc] init];
        _btmLabel.text = @"© 2019 neoao.com";
        _btmLabel.textColor = APP_CONFIG.grayTextColor;
        _btmLabel.font = [APP_CONFIG appAdaptFontOfSize:14];
        [_btmLabel sizeToFit];
        _btmLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _btmLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
