//
//  GalleryViewController.m
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "GalleryViewController.h"

/* controllers */
#import "GalleryContentViewController.h"

@implementation GalleryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCloseButton];
    
    GalleryContentViewController *startingViewController = [self viewControllerAtIndex:self.index];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


#pragma mark - Create objects

- (void)createCloseButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(0, 0, 30, 30)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:closeButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:closeButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.0
                                                           constant:35]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:closeButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:35]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:closeButton
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:16]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:closeButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:16]];
}

#pragma mark - Action

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((GalleryContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((GalleryContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.photos count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (GalleryContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.photos count] == 0) || (index >= [self.photos count])) {
        return nil;
    }
    
    GalleryContentViewController *pageContentViewController = [GalleryContentViewController new];
    Photo *currentPhoto = self.photos[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.photoObject = currentPhoto;

    
    return pageContentViewController;
}

#pragma mark - Status bar

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
