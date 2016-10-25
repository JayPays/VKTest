//
//  AudioTrack+CoreDataClass.h
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioTrack : NSManagedObject

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END

#import "AudioTrack+CoreDataProperties.h"
