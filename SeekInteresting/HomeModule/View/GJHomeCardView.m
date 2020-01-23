//
//  GJHomeCardView.m
//  SeekInteresting
//
//  Created by Arlenly on 2020/1/21.
//  Copyright © 2020年 LiuGJ. All rights reserved.
//

#import "GJHomeCardView.h"

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
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Corner Radius
    self.layer.cornerRadius = 10.0;
}

- (CGRect)backRect {
    CGFloat w = SCREEN_W - 40;
    if (IPHONE_X) {
        return CGRectMake((SCREEN_W - w) / 2 + 20, 190, w - 40, 265);
    }
    return CGRectMake((SCREEN_W - w) / 2 + 35, 140, w - 70, 220);
}

- (CGRect)backRectF {
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

- (void)moveChangeWidth:(CGFloat)dis {
    CGFloat r = 0;
    if (dis > 0) {
        r = dis / ((self.orginRect.size.height / 2) + 9);
    }else {
        r = dis / ((self.orginRect.size.height / 2) - 9);
    }
    _ratio = r > 0 ? (r > 1 ? 1 : r) : (r < -1 ? 1 : -r);
    
    self.width = self.backRect.size.width + _ratio * 40;
}

@end
