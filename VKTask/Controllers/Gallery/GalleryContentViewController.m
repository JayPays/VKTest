//
//  GalleryContentViewController.m
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "GalleryContentViewController.h"

/* frameworks */
#import <SDWebImage/UIImageView+WebCache.h>

@implementation GalleryContentViewController


- (void)setPhotoObject:(Photo *)photoObject {
    if (_photoObject != photoObject) {
        _photoObject = photoObject;
        [self loadImage];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
}

- (void)loadImage {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoObject.getImageUrlHighResolution] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

@end
