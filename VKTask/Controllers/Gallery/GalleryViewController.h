//
//  GalleryViewController.h
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface GalleryViewController : UIViewController

@property (assign, nonatomic) NSInteger index;

@property (strong,nonatomic) NSArray <Photo *> *photos;

@end
