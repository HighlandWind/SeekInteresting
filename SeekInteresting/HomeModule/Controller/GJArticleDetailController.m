//
//  GJArticleDetailController.m
//  SeekInteresting
//
//  Created by Arlenly on 2019/6/10.
//  Copyright © 2019年 LiuGJ. All rights reserved.
//

#import "GJArticleDetailController.h"
#import "GJArticleDetailBtmView.h"
#import "GJHomeEventsModel.h"
#import "GJHomeManager.h"

@interface GJArticleDetailController () <UIWebViewDelegate>
@property (nonatomic, strong) GJArticleDetailBtmView *btmView;
@end

@implementation GJArticleDetailController

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(self.btmView.height);
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
    
}

- (void)initializationSubView {
    [self showShadorOnNaviBar:NO];
    [self.view addSubview:self.btmView];
}

- (void)initializationNetWorking {
    
    self.title = _eventModel.name;
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 50 - NavBar_H)];
    web.backgroundColor = [UIColor whiteColor];
    web.delegate = self;
    [self.view addSubview:web];
    
    if (!_eventModel) return;
    [self.view.loadingView startAnimation];
    
    [[GJHomeManager new] requestGetHomePlayContentParam:[GJHomeEventsDetailRequest dataWithID:_eventModel.ID token:nil format:nil fields:nil page:1 perpage:20 weather:nil areacode:nil sort:nil expand:nil] success:^(NSArray <GJHomeEventsDetailModel *> *data) {
        
        if (data.count > 0) {
            [web loadHTMLString:data[0].content baseURL:nil];
        }else {
            [self.view.loadingView stopAnimation];
        }
        
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

#pragma mark - Request Handle


#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Event response
- (void)blockHanddle {
    
    _btmView.blockClickButtonIdx = ^(NSInteger idx) {
        
    };
}

#pragma mark - Custom delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view.loadingView stopAnimation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.view.loadingView stopAnimation];
}

#pragma mark - Getter/Setter
- (GJArticleDetailBtmView *)btmView {
    if (!_btmView) {
        _btmView = [[GJArticleDetailBtmView alloc] init];
    }
    return _btmView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
