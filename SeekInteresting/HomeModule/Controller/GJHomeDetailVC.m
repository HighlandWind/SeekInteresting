//
//  GJHomeDetailVC.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/25.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeDetailVC.h"
#import "GJHomeEventsModel.h"
#import "GJHomeDetailBtmView.h"
#import "GJHomeDetailCVCell.h"
#import "GJHomeManager.h"
#import "GJHomeEventsModel.h"

static NSString *const cellId = @"cellId";

@interface GJHomeDetailVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) GJHomeDetailBtmView *btmView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) GJHomeManager *homeManager;
@property (nonatomic, strong) NSArray<GJHomeEventsDetailModel *> *dataSource;
@end

@implementation GJHomeDetailVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        if (IPHONE_X) {
            make.height.mas_equalTo(79);
        }else {
            make.height.mas_equalTo(49);
        }
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.btmView.mas_top);
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
    _homeManager = [GJHomeManager new];
}

- (void)initializationSubView {
    self.title = _model.name;
    [self.view addSubview:self.btmView];
    [self.view addSubview:self.collectionView];
    [self blockHanddle];
}

- (void)initializationNetWorking {
    GJHomeEventsDetailRequest *req = [GJHomeEventsDetailRequest dataWithID:_model.ID token:APP_USER.userInfo.token format:nil fields:nil page:1 perpage:20 weather:nil areacode:nil sort:@"id" expand:nil];
    
    [self.view.loadingView startAnimation];
    [_homeManager requestGetHomePlayContentParam:req success:^(NSArray<GJHomeEventsDetailModel *> *data) {
        [self.view.loadingView stopAnimation];
        self.dataSource = data;
        [self.collectionView reloadData];
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        [self.view.loadingView stopAnimation];
        ShowWaringAlertHUD(error.localizedDescription, self.view);
    }];
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    __weak typeof(self)weakSelf = self;
    self.btmView.blockClickBtnIdx = ^(NSInteger idx) {
        if (idx == 0) {
            [weakSelf nextPage];
        }else if (idx == 1) {
            
        }else if (idx == 2) {
            
        }else if (idx == 3) {
            
        }
    };
}

- (void)nextPage {
    NSInteger total = 5;
    if (++ _currentPage < total) {
        CGFloat x = _currentPage * _collectionView.width;
        [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
    }else {
        _currentPage = total - 1;
    }
}

#pragma mark - Custom delegate
// UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GJHomeDetailCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.item];
    return cell;
}

// UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

// UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (CGSize){self.view.width, self.collectionView.height};
}

// UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    _currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

#pragma mark - Getter/Setter
- (GJHomeDetailBtmView *)btmView {
    if (!_btmView) {
        _btmView = [[GJHomeDetailBtmView alloc] init];
    }
    return _btmView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[GJHomeDetailCVCell class] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
