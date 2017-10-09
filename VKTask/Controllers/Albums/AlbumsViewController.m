//
//  AlbumsViewController.m
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AlbumsViewController.h"
#import <VK-ios-sdk/VKSdk.h>
#import "VKRequastTask.h"
#import "User.h"
#import "CustomTableViewCell.h"
#import "Album.h"
#import "AppDelegate.h"
#import "PhotosViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *idVK = @"5531179";

@interface AlbumsViewController ()
<
    VKSdkDelegate,
    VKSdkUIDelegate,
    NSFetchedResultsControllerDelegate
>


@property (strong, nonatomic) NSArray <NSString *> *scopeVK;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation AlbumsViewController

- (void)laodView {
    UITableView *view = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fetchedResultsController.delegate = self;
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
    }
    
    self.scopeVK = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES,VK_PER_VIDEO];

    
    self.navigationItem.title = @"Альбомы";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [VKSdk initializeWithAppId:idVK];
    [[VKSdk instance]registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    
    __weak typeof (self) weakSelf = self;
    
    [VKSdk wakeUpSession:self.scopeVK completeBlock:^(VKAuthorizationState state, NSError *error) {
         __strong typeof (weakSelf) strongSelf = weakSelf;
        if (state == VKAuthorizationAuthorized) {
            [VKRequastTask getUserInfoWithCompletionBlock:^{
                [VKRequastTask loadUserAlbumsWithCompletionBlock];
            }];
        } else {
            [VKSdk authorize:strongSelf.scopeVK];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Album *album = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.albumTitleLabel.text = album.title;
    cell.albumCountLabel.text = [NSString stringWithFormat:@"%d",album.size.integerValue];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:album.getAlbumUrl]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                cell.albumImageView.image = image;
                            }
                        }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setMinimumLineSpacing:4];
    [aFlowLayout setMinimumInteritemSpacing:1];
    PhotosViewController *vc = [[PhotosViewController alloc]initWithCollectionViewLayout:aFlowLayout];
    Album *album = [self.fetchedResultsController objectAtIndexPath:indexPath];
    vc.albumID = album.albumID;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - VKSDK Delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        [VKRequastTask getUserInfoWithCompletionBlock:^{
            [VKRequastTask loadUserAlbumsWithCompletionBlock];
        }];
    } else if (result.error) {
        [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Access denied\n%@", result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [VKSdk authorize:self.scopeVK];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self];
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"Failed");
}


#pragma mark - VKSDKUI Delegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Update user interface


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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Album class])];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors = @[nameSort];
    return request;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
