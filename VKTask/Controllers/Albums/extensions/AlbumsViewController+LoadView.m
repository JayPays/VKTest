//
//  AlbumsViewController+LoadView.m
//  VKTask
//
//  Created by Jay on 09.10.2017.
//  Copyright © 2017 Vladislav Molodetskiy. All rights reserved.
//

#import "AlbumsViewController+LoadView.h"

@implementation AlbumsViewController (LoadView)

- (void)laodView {
    
    /* append */
    [self loadView_appendTableView];
}

#pragma mark - Append tableView

- (void)loadView_appendTableView {
    
    /* create */
    UITableView *view = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    /* assign */
    self.view = view;
}


@end
