//
//  GalleryViewController.m
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "GalleryViewController.h"

@implementation GalleryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Actions

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
