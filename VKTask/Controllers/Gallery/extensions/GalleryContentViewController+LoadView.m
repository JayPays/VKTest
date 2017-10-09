//
//  GalleryContentViewController+LoadView.m
//  VKTask
//
//  Created by Jay on 09.10.2017.
//  Copyright © 2017 Vladislav Molodetskiy. All rights reserved.
//

#import "GalleryContentViewController+LoadView.h"

@implementation GalleryContentViewController (LoadView)

- (void)loadView {
    
    /* configure */
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
    
    /* append imageView */
    [self loadView_appendImageView];
}

#pragma mark - Append imageView

- (void)loadView_appendImageView {
    
    UIView *rootView = self.view;
    CGRect rootRect = rootView.frame;
    
    /* create */
    UIImageView *view = [[UIImageView alloc]initWithFrame:rootRect];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /* asssign */
    self.imageView = view;
    
    /* append */
    [rootView addSubview:view];
}


@end
