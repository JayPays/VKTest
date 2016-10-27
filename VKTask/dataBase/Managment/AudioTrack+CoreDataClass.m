//
//  AudioTrack+CoreDataClass.m
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioTrack+CoreDataClass.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

static char stateKey;
static char progressKey;

@implementation AudioTrack

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json {
    
    NSNumber *audioTrackID = [json objectForKey:@"id"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([AudioTrack class])];
    request.predicate = [NSPredicate predicateWithFormat:@"audioTrackID==%@",audioTrackID];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSArray <AudioTrack *> *audioTracks = [context executeFetchRequest:request error:nil];
    
    AudioTrack *audioTrack = audioTracks.firstObject ? audioTracks.firstObject : (AudioTrack *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([AudioTrack class]) inManagedObjectContext:context];
    audioTrack.audioTrackID = audioTrackID;
    audioTrack.title = [json objectForKey:@"title"];
    audioTrack.artist = [json objectForKey:@"artist"];
    audioTrack.duration = [json objectForKey:@"duration"];
    audioTrack.url = [json objectForKey:@"url"];
    audioTrack.date = [NSDate dateWithTimeIntervalSinceReferenceDate:[[json objectForKey:@"date"] integerValue]];
    
    NSLog(@"%@ %ld",audioTracks.firstObject ? @"Updated object with id = ": @"Inserted object with id = ",(long)audioTrackID.integerValue);
    [context save:nil];
}

+ (AudioTrack *)getTrackFromId:(NSInteger)trackID {
    NSNumber *audioTrackID = @(trackID);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([AudioTrack class])];
    request.predicate = [NSPredicate predicateWithFormat:@"audioTrackID==%@",audioTrackID];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSArray <AudioTrack *> *audioTracks = [context executeFetchRequest:request error:nil];
    return audioTracks.firstObject;
}

#pragma mark - AssociatedObjecs

- (void)setState:(NSNumber *)state {
    objc_setAssociatedObject(self, &stateKey, state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)state {
    return objc_getAssociatedObject(self, &stateKey);
}

- (void)setProgress:(NSNumber *)progress {
    objc_setAssociatedObject(self, &progressKey, progress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)progress {
    return objc_getAssociatedObject(self, &progressKey);
}

@end
