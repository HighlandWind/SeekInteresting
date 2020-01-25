//
//  GJHomeCardView.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/21.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeCardView.h"
#import "GJHomeEventsModel.h"

@interface GJHomeCardView ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *detailLB;
@end

@implementation GJHomeCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
//    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Corner Radius
    self.layer.cornerRadius = 10.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [APP_CONFIG appBoldFontOfSize:20];
    _titleLB.textColor = [UIColor whiteColor];
    [_titleLB sizeToFit];
    
    _detailLB = [[UILabel alloc] init];
    _detailLB.font = [APP_CONFIG appFontOfSize:14];
    _detailLB.textColor = [UIColor whiteColor];
    _detailLB.numberOfLines = 2;
    [_detailLB sizeToFit];
}

- (void)tapClick {
    BLOCK_SAFE(_blockClickCard)(_model);
}

- (void)setModel:(GJHomeEventsModel *)model {
    _model = model;
    if ([model.type isEqualToString:@"image"]) {
        _bgImage = [UIImage imageNamed:@"图片"];
        _topColor = [UIColor colorWithHexRGB:@"542415"];
        _btmColor = [UIColor colorWithHexRGB:@"883852"];
    }
    else if ([model.type isEqualToString:@"music"]) {
        _bgImage = [UIImage imageNamed:@"音乐"];
        _topColor = [UIColor colorWithHexRGB:@"502B7F"];
        _btmColor = [UIColor colorWithHexRGB:@"82528F"];
    }
    else if ([model.type isEqualToString:@"video"]) {
        _bgImage = [UIImage imageNamed:@"广告"];
        _topColor = [UIColor colorWithHexRGB:@"253063"];
        _btmColor = [UIColor colorWithHexRGB:@"915E83"];
    }
    else if ([model.type isEqualToString:@"article"]) {
        _bgImage = [UIImage imageNamed:@"文章"];
        _topColor = [UIColor colorWithHexRGB:@"5B4D7C"];
        _btmColor = [UIColor colorWithHexRGB:@"59808E"];
    }
    else if ([model.type isEqualToString:@"shop"]) {
        _bgImage = [UIImage imageNamed:@"购物"];
        _topColor = [UIColor colorWithHexRGB:@"263364"];
        _btmColor = [UIColor colorWithHexRGB:@"396688"];
    }
    else if ([model.type isEqualToString:@"chat"]) {
        _bgImage = [UIImage imageNamed:@"画板"];
        _topColor = [UIColor colorWithHexRGB:@"583874"];
        _btmColor = [UIColor colorWithHexRGB:@"5863A8"];
    }
    else {
        _bgImage = [UIImage imageNamed:@"视频"];
        _topColor = [UIColor colorWithHexRGB:@"553167"];
        _btmColor = [UIColor colorWithHexRGB:@"7A416A"];
    }
    self.image = _bgImage;
    
    _titleLB.text = model.name;
    _detailLB.text = model.slogan;
    [self addSubview:_titleLB];
    [self addSubview:_detailLB];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(25);
        make.top.equalTo(self).with.offset(30);
    }];
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLB);
        make.top.equalTo(self.titleLB.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(-20);
    }];
}

- (CGRect)lastRect {
    CGFloat w = SCREEN_W - 80;
    if (IPHONE_X) {
        return CGRectMake((SCREEN_W - w) / 2, 172, w, 265); // y up: 18px
    }
    return CGRectMake((SCREEN_W - w) / 2 + 15, 122, w - 30, 220); // y up: 18px
}

- (CGRect)backRect {
    CGFloat w = SCREEN_W - 40;
    if (IPHONE_X) {
        return CGRectMake((SCREEN_W - w) / 2 + 20, 190, w - 40, 265);
    }
    return CGRectMake((SCREEN_W - w) / 2 + 35, 140, w - 70, 220);
}

- (CGRect)nextRect {
    CGFloat w = SCREEN_W - 80;
    if (IPHONE_X) {
        return CGRectMake((SCREEN_W - w) / 2, 208, w, 265); // y down: 18px
    }
    return CGRectMake((SCREEN_W - w) / 2 + 15, 158, w - 30, 220); // y down: 18px
}

- (CGRect)frontRect {
    CGFloat w = SCREEN_W - 40;
    if (IPHONE_X) {
        return CGRectMake((SCREEN_W - w) / 2, 190, w, 265);
    }
    return CGRectMake((SCREEN_W - w) / 2 + 15, 140, w - 30, 220);
}

- (void)moveChangeWidth:(CGFloat)dis dcY:(CGFloat)dcy cX:(CGFloat)cx {
    CGFloat r = 0;
    if (dis > 0) {
        r = dis / ((self.initRect.size.height / 2) - 9);
    }else {
        r = dis / ((self.initRect.size.height / 2) - 9);
    }
    _ratio = r > 0 ? (r > 1 ? 1 : r) : (r < -1 ? 1 : -r);
    
    self.width = self.nextRect.size.width + _ratio * 40; // 宽度变宽
    self.centerY -= dcy;
    self.centerX = cx;
}

@end


@implementation GJHomeRightBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"喜欢bg"] forState:UIControlStateNormal];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -12, 0)];
        
        UIImageView *xin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"喜欢"]];
        [self addSubview:xin];
        [xin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).with.offset(-3);
        }];
    }
    return self;
}

@end
