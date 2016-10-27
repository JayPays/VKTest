//
//  AudioTrack+CoreDataClass.h
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AudioTrackState) {
    AudioTrackStateDownloaded = 0,
    AudioTrackStateNotDownloaded = 1,
    AudioTrackStateNowDownload = 2
};

NS_ASSUME_NONNULL_BEGIN

@interface AudioTrack : NSManagedObject

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json;

@property (strong, nonatomic) NSNumber *state;
@property (strong, nonatomic) NSNumber *progress;

+ (AudioTrack *)getTrackFromId:(NSInteger)trackID;

@end

NS_ASSUME_NONNULL_END

#import "AudioTrack+CoreDataProperties.h"
