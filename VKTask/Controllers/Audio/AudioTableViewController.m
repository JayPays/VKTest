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

@interface AudioTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) VKRequastTask *downloadTask;

@end

@implementation AudioTableViewController

- (void)laodView {
    UITableView *view = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.downloadTask = [VKRequastTask new];
    self.tableView.estimatedRowHeight = 44.0f;
    
    self.fetchedResultsController.delegate = self;
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
    }
    
    for (AudioTrack *audioTrack in self.fetchedResultsController.fetchedObjects) {
        audioTrack.state = [audioTrack valueForKey:@"filePath"] ? @(AudioTrackStateDownloaded): @(AudioTrackStateNotDownloaded);
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AudioTrackCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
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
        [self.downloadTask donwloadFileAtUrl:audioTrack.url withDonwloadProgressBlock:^(CGFloat progress) {
            audioTrack.progress = @(progress);
            [strongSelf updateVisibleCell:audioTrack];
        } withFinishBlock:^(NSError *error) {
            audioTrack.state = error ? @(AudioTrackStateNotDownloaded) : @(AudioTrackStateDownloaded);
            [strongSelf updateVisibleCell:audioTrack];
        }];
    };
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)updateVisibleCell:(AudioTrack *)currentAudioTrack {
    NSArray *visibleCells = [self.tableView visibleCells];
    for (AudioTrackCell *cell in visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        AudioTrack *audioTrack = [self.fetchedResultsController objectAtIndexPath:indexPath];
        AudioTrackState state = [currentAudioTrack.state integerValue];
        if (currentAudioTrack == audioTrack) {
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
            
            cell.progressView.progress = [currentAudioTrack.progress floatValue];
        }
    }
}

- (void)configureCell:(AudioTrackCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    AudioTrack *audioTrack = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
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

#pragma mark - FetchRequast delegate

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequest]
                                                                                                  managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil
                                                                                                             cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView cellForRowAtIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Fetch

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([AudioTrack class])];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    request.sortDescriptors = @[nameSort];
    return request;
}


@end
