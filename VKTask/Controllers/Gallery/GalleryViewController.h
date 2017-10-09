//
//  GalleryViewController.h
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

/* coredata */
#import "Photo.h"

/* controllers */
#import "GalleryContentViewController.h"

@interface GalleryViewController : UIViewController
<
    UIPageViewControllerDataSource,
    UIPageViewControllerDelegate
>

/* data */
@property (assign, nonatomic) NSInteger index;
@property (strong,nonatomic) NSArray <Photo *> *photos;

/* UI */
@property (strong, nonatomic) UIPageViewController *pageViewController;

#pragma mark - Actions
- (void)closeAction;


- (GalleryContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
