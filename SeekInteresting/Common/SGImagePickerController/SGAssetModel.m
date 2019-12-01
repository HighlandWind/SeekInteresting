//
//  SGAssetModel.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/20.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "SGAssetModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation SGAssetModel

- (void)originalImage:(void (^)(UIImage *))returnImage{
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib assetForURL:self.imageURL resultBlock:^(ALAsset *asset) {
        
        /*
        ALAssetRepresentation *rep = asset.defaultRepresentation;
        CGImageRef imageRef = rep.fullResolutionImage;
        UIImage *image = [UIImage imageWithCGImage:imageRef scale:rep.scale orientation:(UIImageOrientation)rep.orientation];
        if (image) {
            returnImage(image);
        }
        */
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        CGFloat imageScale = [assetRepresentation scale];
        UIImageOrientation imageOrientation = (UIImageOrientation)[assetRepresentation orientation];
        CGImageRef imageReference = [assetRepresentation fullResolutionImage];
        UIImage *imageNew = [UIImage imageWithCGImage:imageReference scale:imageScale orientation:imageOrientation];
        if (imageNew) {
            returnImage(imageNew);
        }
      
    } failureBlock:^(NSError *error) {
        
    }];
}
@end
