//
//  GalleryViewController+LoadView.m
//  VKTask
//
//  Created by Jay on 09.10.2017.
//  Copyright © 2017 Vladislav Molodetskiy. All rights reserved.
//

#import "GalleryViewController+LoadView.h"

@implementation GalleryViewController (LoadView)

- (void)loadView {
    
    /* configure */
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
    
    
    /* append pageViewController */
    [self loadView_appendPageViewController];
}

#pragma mark - Append pageViewController

- (void)loadView_appendPageViewController {
    
    UIView *rootView = self.view;
    CGRect rootRect = rootView.frame;
    
    UIPageViewController *viewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    viewController.dataSource = self;
    viewController.delegate = self;
    UIView *view = viewController.view;
    view.frame = rootRect;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /* assing */
    self.pageViewController = viewController;
    
    /* append */
    [self.view addSubview:view];
}

@end
