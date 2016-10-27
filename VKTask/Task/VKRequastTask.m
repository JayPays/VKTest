//
//  VKRequastTask.m
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "VKRequastTask.h"
#import "User.h"
#import <VK-ios-sdk/VKSdk.h>
#import "User.h"
#import "Photo.h"
#import "Album.h"
#import "AudioTrack+CoreDataClass.h"
#import <AFNetworking.h>


@implementation VKRequastTask

#pragma mark - User info

+ (void)getUserInfoWithCompletionBlock:(void (^)(void))block {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:@"first_name, last_name, uid, photo_100" forKey:@"fields"];
    [dictionary setObject:@"1" forKey:@"https"];
    [dictionary setObject:@"en" forKey:@"lang"];
    
     VKRequest *request = [VKApi requestWithMethod:@"users.get" andParameters:dictionary];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray <NSDictionary *> *jsonArray = response.json;
        [User inserOrUpdateUserEntity:jsonArray.firstObject withConletionBlock:^{
            block();
        }];
    } errorBlock:^(NSError *error) {
        block();
    }];
}

//Albums
+ (void)loadUserAlbumsWithCompletionBlock {
    __weak typeof (self) weakSelf = self;
    VKRequest *request = [VKRequest requestWithMethod:@"photos.getAll"  parameters:@{@"count": @"200"}];
    [request executeWithResultBlock:^(VKResponse *response) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSArray <NSDictionary *> *items = [response.json objectForKey:@"items"];
        
        for (NSDictionary *photoInfo in items) {
            [Photo inserOrUpdateUserEntity:photoInfo];
        }
        [strongSelf loadAlbumInfoFromIds:[Photo getAllAlbumId]];
    } errorBlock:^(NSError *error) {
        
    }];
}

+ (void)loadAlbumInfoFromIds:(NSArray <NSString *> *)arrayWithAlbumId {
    
    NSString *albumsidString = [arrayWithAlbumId componentsJoinedByString:@", "];
    
    VKRequest *request = [VKRequest requestWithMethod:@"photos.getAlbums"  parameters:@{@"album_ids" : albumsidString}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray <NSDictionary *> *items = [response.json objectForKey:@"items"];
        for (NSDictionary *albumInfo in items) {
            [Album inserOrUpdateUserEntity:albumInfo];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}


//Audio
+ (void)loadUserAudioWithCompletionBlock {
    VKRequest *request = [VKRequest requestWithMethod:@"audio.get"  parameters:@{}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray <NSDictionary *> *items = [response.json objectForKey:@"items"];
        for (NSDictionary *albumInfo in items) {
            [AudioTrack inserOrUpdateUserEntity:albumInfo];
        }
        [self loadUserVideoWithCompletionBlock];
    } errorBlock:^(NSError *error) {
        
    }];
}

//Video
+ (void)loadUserVideoWithCompletionBlock {
    VKRequest *request = [VKRequest requestWithMethod:@"video.get"  parameters:@{}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray <NSDictionary *> *items = [response.json objectForKey:@"items"];
    } errorBlock:^(NSError *error) {
        
    }];
}


#pragma mark - Download

- (void)donwloadFileAtUrl:(NSString *)url
withDonwloadProgressBlock:(DownloadProgressBlock)progressBlock
          withFinishBlock:(DownloadFinishBlock)finishBlock {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"url"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if(progressBlock) {
            progressBlock((float)totalBytesRead / totalBytesExpectedToRead);
        }
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(finishBlock) {
            finishBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(finishBlock) {
            finishBlock(error);
        }
    }];
    
    [operation start];
}


@end
