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

#pragma mark - Player Action

- (void)playTrackAtId:(NSInteger)trackId {
    AudioTrack *audioTrack = [AudioTrack getTrackFromId:trackId];
    if (!audioTrack.filePath.length) return;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:audioTrack.filePath]];
    self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    [self.player play];
}

@end
