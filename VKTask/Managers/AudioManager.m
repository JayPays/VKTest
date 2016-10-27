//
//  AudioManager.m
//  VKTask
//
//  Created by JayPays on 27.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioManager.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioTrack+CoreDataClass.h"

@interface AudioManager()

@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation AudioManager

+ (AudioManager *)sharedInstance {
    static AudioManager *manager = nil;
    if (!manager) {
        manager = [AudioManager new];
    }
    return manager;
}

//- (instancetype)init {
//    if (self == [super init]) {
//        self.player = [AVAudioPlayer new];
//    }
//    return self;
//}

#pragma mark - Player Action

- (void)playTrackAtId:(NSInteger)trackId {
    AudioTrack *audioTrack = [AudioTrack getTrackFromId:trackId];
    if (!audioTrack.filePath.length) return;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:audioTrack.filePath];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc]initWithData:data error:&error];
    [self.player play];
}

@end
