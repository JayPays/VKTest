//
//  CustomCollectionViewCell.m
//  VKTask
//
//  Created by Jay on 05.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)init {
    if (self == [super init]) {
        [self loadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self loadView];
    }
    return self;
}

- (void)loadView {
    
    /* append imageView */
    [self loadView_appendImageView];
}

#pragma mark - Append imageView
- (void)loadView_appendImageView {
    UIView *rootView = self;
    CGSize rootSize = rootView.frame.size;
    
    /* create */
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rootSize.width, rootSize.height)];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.clipsToBounds = YES;
    
    /* asssign */
    self.photoImageView = view;
    
    /* append */
    [rootView addSubview:view];}

@end
