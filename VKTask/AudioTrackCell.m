//
//  AudioTrackCell.m
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioTrackCell.h"

@implementation AudioTrackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Action

- (IBAction)downloadAction:(id)sender {
    if (self.downloadButtonActionBlock) {
        self.downloadButtonActionBlock(sender);
    }
}

@end
