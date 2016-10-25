//
//  VKRequastTask.h
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^DownloadProgressBlock)(CGFloat progress);
typedef void(^DownloadFinishBlock)(NSError *error);

@interface VKRequastTask : NSObject

+ (void)getUserInfoWithCompletionBlock:(void (^)(void))block;


//Albums
+ (void)loadUserAlbumsWithCompletionBlock;
//Audio
+ (void)loadUserAudioWithCompletionBlock;

//Download

- (void)donwloadFileAtUrl:(NSString *)url
withDonwloadProgressBlock:(DownloadProgressBlock)progressBlock
          withFinishBlock:(DownloadFinishBlock)finishBlock;

@end
