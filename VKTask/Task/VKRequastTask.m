//
//  VKRequastTask.m
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "VKRequastTask.h"

/* coredata */
#import "User.h"
#import "User.h"
#import "Photo.h"
#import "Album.h"

/* framewotks */
#import <VK-ios-sdk/VKSdk.h>
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

@end
