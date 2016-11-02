//
//  AudioTableViewController.m
//  VKTask
//
//  Created by D.Vm on 03.08.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioTableViewController.h"
#import "AudioTrackCell.h"
#import "AudioTrack+CoreDataClass.h"
#import "AppDelegate.h"
#import "VKRequastTask.h"
#import "AudioManager.h"

@interface AudioTableViewController ()

@property (strong, nonatomic) VKRequastTask *downloadTask;

@end

@implementation AudioTableViewController

- (void)viewDidLoad {
    self.fetchRequestName = NSStringFromClass([AudioTrack class]);
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
    }
    [super viewDidLoad];
    
    
    self.downloadTask = [VKRequastTask new];
    self.tableView.estimatedRowHeight = 44.0f;
    
    for (AudioTrack *audioTrack in self.fetchedResultsController.fetchedObjects) {
        audioTrack.state = [audioTrack valueForKey:@"filePath"] ? @(AudioTrackStateDownloaded): @(AudioTrackStateNotDownloaded);
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AudioTrackCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Content
    AudioTrack *audioTrack = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleTrackLabel.text = audioTrack.title;
    cell.artistTrackLabel.text = audioTrack.artist;
    
    //Download
    __weak typeof (self)weakSelf = self;
    cell.downloadButtonActionBlock = ^(id sender) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        audioTrack.state = @(AudioTrackStateNowDownload);
        [strongSelf updateVisibleCell:audioTrack];
        [self.downloadTask donwloadFileAtUrl:audioTrack.url withObjectID:[audioTrack.audioTrackID integerValue] withDonwloadProgressBlock:^(CGFloat progress) {
            audioTrack.progress = @(progress);
            [strongSelf updateVisibleCell:audioTrack];
        } withFinishBlock:^(NSError *error) {
            audioTrack.state = error ? @(AudioTrackStateNotDownloaded) : @(AudioTrackStateDownloaded);
            [strongSelf updateVisibleCell:audioTrack];
        }];
    };
    
    [self configureCell:cell atIndexPath:audioTrack];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioTrack *audioTrack = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[AudioManager sharedInstance] playTrackAtId:[audioTrack.audioTrackID integerValue]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioTrack *audioTrack = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return audioTrack.filePath.length;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AudioTrack *audioTrack = self.fetchedResultsController.fetchedObjects[indexPath.row];
        [VKRequastTask deleteFileAtObjectId:[audioTrack.audioTrackID integerValue]];
        [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:audioTrack];
        [self.tableView setEditing:NO animated:YES];
    }
}

- (void)updateVisibleCell:(AudioTrack *)currentAudioTrack {
    NSArray *visibleCells = [self.tableView visibleCells];
    for (AudioTrackCell *cell in visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        AudioTrack *audioTrack = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if (currentAudioTrack == audioTrack) {
            [self configureCell:cell atIndexPath:currentAudioTrack];
        }
    }
}

- (void)configureCell:(AudioTrackCell *)cell atIndexPath:(AudioTrack *)audioTrack {
    
    AudioTrackState state = [audioTrack.state integerValue];
    switch (state) {
        case AudioTrackStateDownloaded: {
            cell.downloadButton.enabled = NO;
            cell.progressView.hidden = YES;
            break;
        }
            
        case AudioTrackStateNotDownloaded: {
            cell.downloadButton.enabled = YES;
            cell.progressView.hidden = YES;
            break;
        }
            
        case AudioTrackStateNowDownload: {
            cell.downloadButton.enabled = NO;
            cell.progressView.hidden = NO;
            break;
        }
            
        default:
            break;
    }
    
    cell.progressView.progress = [audioTrack.progress floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


@end
