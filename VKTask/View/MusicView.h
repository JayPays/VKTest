//
//  MusicView.h
//  VKTask
//
//  Created by JayPays on 28.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MusicViewState) {
    MusicViewStatePlay,
    MusicViewStateStop
};

@interface MusicView : UIView

@property (assign, nonatomic) MusicViewState musikState;

@end
