//
//  Photo.h
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSManagedObject

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json;

+ (NSArray <NSString *> *)getAllAlbumId;

+ (NSArray <Photo *> *)getAllPhotosFromAlbumId:(NSNumber *)albumID;

- (NSString *)getImageUrl;

- (NSString *)getImageUrlHighResolution;

@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
