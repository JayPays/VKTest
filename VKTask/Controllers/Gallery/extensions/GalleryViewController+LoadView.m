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
    
    /* append close button */
    [self loadView_appendCloseButton];
}

#pragma mark - Append pageViewController

- (void)loadView_appendPageViewController {
    
    UIView *rootView = self.view;
    CGRect rootRect = rootView.frame;
    
    UIPageViewController *viewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    viewController.dataSource = self;
    viewController.delegate = self;
    [viewController setViewControllers:@[[self viewControllerAtIndex:self.index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    UIView *view = viewController.view;
    view.frame = rootRect;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /* assing */
    self.pageViewController = viewController;
    
    /* append */
    [self.view addSubview:view];
}

#pragma mark - Append close button

- (void)loadView_appendCloseButton {
    
    UIView *rootView = self.view;
    
    /* create */
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    [view setFrame:CGRectMake(20, 20, 30, 30)];
    [view setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [view addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin;
    
    /* append */
    [rootView addSubview:view];
}

@end
