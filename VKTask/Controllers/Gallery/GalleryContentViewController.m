//
//  GalleryContentViewController.m
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "GalleryContentViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GalleryContentViewController ()

@property (strong ,nonatomic) UIImageView *imageView;

@end

@implementation GalleryContentViewController


- (void)loadView {
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
}


- (void)setPhotoObject:(Photo *)photoObject {
    if (_photoObject != photoObject) {
        _photoObject = photoObject;
        [self loadImage];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createImageView];
    [self loadImage];
}

- (void)loadImage {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoObject.getImageUrlHighResolution] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

- (void)createImageView {
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
}


@end
