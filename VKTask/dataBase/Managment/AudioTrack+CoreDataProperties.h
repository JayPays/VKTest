//
//  AudioTrack+CoreDataProperties.h
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioTrack+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AudioTrack (CoreDataProperties)

+ (NSFetchRequest<AudioTrack *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *artist;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSNumber *duration;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSNumber *audioTrackID;

@end

NS_ASSUME_NONNULL_END
