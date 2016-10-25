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

typedef NS_ENUM(NSUInteger, AudioTrackState) {
    AudioTrackStateDownloaded,
    AudioTrackStateNotDownloaded,
    AudioTrackStateNowDownload
};

@interface AudioTrackModel : NSObject
@property (assign, nonatomic) NSInteger progress;
@property (assign, nonatomic) AudioTrackState trackState;
@end

@implementation AudioTrackModel
@end

@interface AudioTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSMutableArray <AudioTrackModel *> *audioTrackModels;

@end

@implementation AudioTableViewController

- (void)laodView {
    UITableView *view = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0f;
    
    self.fetchedResultsController.delegate = self;
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
    }
    
    self.audioTrackModels = [NSMutableArray new];
    for (id object in self.fetchedResultsController.fetchedObjects) {
        AudioTrackModel *newModel = [AudioTrackModel new];
        newModel.trackState = AudioTrackStateNotDownloaded;
        [self.audioTrackModels addObject:newModel];
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
    cell.downloadButtonActionBlock = ^(id sender) {
        
    };
    
    //Reuse
    AudioTrackModel *model = self.audioTrackModels[indexPath.row];
    
    switch (model.trackState) {
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
    
    
    return cell;
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
