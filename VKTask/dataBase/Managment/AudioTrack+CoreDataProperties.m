//
//  AudioTrack+CoreDataProperties.m
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioTrack+CoreDataProperties.h"

@implementation AudioTrack (CoreDataProperties)

+ (NSFetchRequest<AudioTrack *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AudioTrack"];
}

@dynamic artist;
@dynamic date;
@dynamic duration;
@dynamic title;
@dynamic url;
@dynamic audioTrackID;

@end
