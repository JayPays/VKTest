//
//  GalleryContentViewController.h
//  VKTask
//
//  Created by Jay on 06.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface GalleryContentViewController : UIViewController

@property (strong, nonatomic) Photo *photoObject;

@property (assign, nonatomic) NSInteger pageIndex;

@end
