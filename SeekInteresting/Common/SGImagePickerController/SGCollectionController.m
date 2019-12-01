//
//  SGCollectionController.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/20.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "SGCollectionController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SGAssetModel.h"
#import "SGPhotoBrowser.h"
#import "SGImagePickerController.h"
#import "SGTip.h"
#define MARGIN 5
#define COL 4
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface SGShowCell : UICollectionViewCell
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation SGShowCell

@end

@interface SGCollectionController ()
@property (nonatomic,strong) NSMutableArray *assetModels;
//选中的模型
@property (nonatomic,strong) NSMutableArray *selectedModels;
//选中的图片
@property (nonatomic,strong) NSMutableArray *selectedImages;
// 滚动到底部
@property (nonatomic,assign) BOOL isScrollToBottom;
@end

@implementation SGCollectionController

static NSString * const reuseIdentifier = @"Cell";
//设置类型
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (kWidth - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    return [super initWithCollectionViewLayout:flowLayout];
}
- (NSMutableArray *)assetModels{
    if (_assetModels == nil) {
        _assetModels = [NSMutableArray array];
    }
    return _assetModels;
}
- (NSMutableArray *)selectedImages{
    if (_selectedImages == nil) {
        _selectedImages = [NSMutableArray array];
    }
    return _selectedImages;
}
- (NSMutableArray *)selectedModels{
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (void)setGroup:(ALAssetsGroup *)group{
    _group = group;
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        SGAssetModel *model = [[SGAssetModel alloc] init];
        model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
        model.imageURL = asset.defaultRepresentation.url;
        [self.assetModels addObject:model];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    ShowProgressHUDWithText(NO, nil, nil);
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!self.isScrollToBottom && self.assetModels.count > 0) [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.assetModels.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    self.isScrollToBottom = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[SGShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    ;
    
    self.navigationItem.title = [NSString stringWithFormat:@"选择照片"];
    
    //右侧完成按钮
    UIButton *btn= [[UIButton alloc] init];
    btn.titleLabel.font = [APP_CONFIG appAdaptFontOfSize:17];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:APP_CONFIG.blackTextColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(finishSelecting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = finish;
    
    UIBarButtonItem *barItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"arrow-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//出口,选择完成图片
- (void)finishSelecting{
    
    if ([self.navigationController isKindOfClass:[SGImagePickerController class]]) {
        SGImagePickerController *picker = (SGImagePickerController *)self.navigationController;
        if (picker.didFinishSelectThumbnails || picker.didFinishSelectImages) {
        
        for (SGAssetModel *model in self.assetModels) {
            if (model.isSelected) {
                [self.selectedModels addObject:model];
            }
        }
 
        //获取原始图片是异步的,因此需要判断最后一个,然后传出
        __weak __typeof(self)weakSelf = self;
        for (int i = 0; i < self.selectedModels.count; i++) {
            SGAssetModel *model = self.selectedModels[i];
            [model originalImage:^(UIImage *image) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                [strongSelf.selectedImages addObject:image];
                if ( i == strongSelf.selectedModels.count - 1) {//最后一个
                    if (picker.didFinishSelectImages) {
                        picker.didFinishSelectImages(strongSelf.selectedImages);
                    }
                }
            }];
        }
        if (picker.didFinishSelectThumbnails) {
            picker.didFinishSelectThumbnails([_selectedModels valueForKeyPath:@"thumbnail"]);
        }
     }
    }
    //移除
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.assetModels.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    SGAssetModel *model = self.assetModels[indexPath.item];
   
    if (cell.backgroundView == nil) {//防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    backView.image = model.thumbnail;
    if (cell.selectedButton == nil) {//防止多次创建
        UIButton *selectButton = [[UIButton alloc] init];
        [selectButton setImage:[UIImage imageNamed:@"album_deselected"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"album_selected"] forState:UIControlStateSelected];
        CGFloat width = cell.bounds.size.width;
        selectButton.frame = CGRectMake(width - 20, 0, 20, 20);
        [cell.contentView addSubview:selectButton];
        cell.selectedButton = selectButton;
        [selectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectedButton.tag = indexPath.item;//重新绑定
    cell.selectedButton.selected = model.isSelected;//恢复设定状态
    
    return cell;
}
- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    SGAssetModel *model = self.assetModels[sender.tag];
    //因为冲用的问题,不能根据选中状态来记录
    if (sender.selected == YES) {//选中了记录
        if (self.maxCount <= 0) {
            [SGTip loadTipWithContent:[NSString stringWithFormat:@"最多上传%ld张图片", (long)self.maxCountImages] InView:self.view];
            sender.selected = NO;
        }else{
         model.isSelected = YES;
            self.maxCount--;
        }
    }else{//否则移除记录
        model.isSelected = NO;
        self.maxCount++;
    }
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 此处不需要查看缩略图功能
//    SGPhotoBrowser *browser = [[SGPhotoBrowser alloc] init];
//    browser.assetModels = self.assetModels;
//    browser.currentIndex = indexPath.item;
//    [browser show];
    SGShowCell *cell = (SGShowCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self buttonClicked:cell.selectedButton];
    
    
}

- (void)dealloc
{
    
}
@end
