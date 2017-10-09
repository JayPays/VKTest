//
//  PhotosViewController+LoadView.m
//  VKTask
//
//  Created by Jay on 09.10.2017.
//  Copyright © 2017 Vladislav Molodetskiy. All rights reserved.
//

#import "PhotosViewController+LoadView.h"

@implementation PhotosViewController (LoadView)

- (void)laodView {
    
    /* configure */
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /* append collectionView */
    [self loadView_appendCollectionView];
}

#pragma mark - Append collectionView

- (void)loadView_appendCollectionView {
    
    UIView *rootView = self.view;
    CGRect rootRect = rootView.frame;
    
    /* create */
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:rootRect];
    [view setDataSource:self];
    [view setDelegate:self];
    
    /* append */
    [rootView addSubview:view];
    
    /* assign */
    self.collectionView = view;
}

@end
