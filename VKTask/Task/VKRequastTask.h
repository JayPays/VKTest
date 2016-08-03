//
//  VKRequastTask.h
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKRequastTask : NSObject

+ (void)getUserInfoWithCompletionBlock:(void (^)(void))block;


//Albums
+ (void)loadUserAlbumsWithCompletionBlock;
//Audio
+ (void)loadUserAudioWithCompletionBlock;

@end
