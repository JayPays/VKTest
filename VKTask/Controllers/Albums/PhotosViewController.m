//
//  PhotosViewController.m
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "PhotosViewController.h"
#import "CustomCollectionViewCell.h"
#import "Photo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GalleryViewController.h"

@interface PhotosViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (strong,nonatomic) NSArray <Photo *> *photos;

@end

@implementation PhotosViewController


static NSString * const reuseIdentifier = @"Cell";

- (void)laodView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    self.collectionView = collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Фото";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    self.photos = [Photo getAllPhotosFromAlbumId:self.albumID];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Photo *currentPhotoObject = self.photos[indexPath.row];
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:currentPhotoObject.getImageUrl]];
    return cell;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryViewController *vc = [GalleryViewController new];
    vc.photos = self.photos;
    vc.index = indexPath.row;
    [self presentViewController:vc animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = CGRectGetWidth(self.view.frame) / 4 - 3;
    return CGSizeMake(size, size);
}

#pragma mark - load photo data

- (void)loadData {
    
}

@end
