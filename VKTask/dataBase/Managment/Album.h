//
//  Album.h
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Album : NSManagedObject

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json;

- (NSString *)getAlbumUrl;

@end

NS_ASSUME_NONNULL_END

#import "Album+CoreDataProperties.h"
