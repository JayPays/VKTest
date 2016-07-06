//
//  Album.m
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "Album.h"
#import "AppDelegate.h"
#import "Photo.h"

@implementation Album

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json {
    
    NSNumber *albumID = [json objectForKey:@"id"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Album class])];
    request.predicate = [NSPredicate predicateWithFormat:@"albumID==%@",albumID];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray <Album *> *albums = [context executeFetchRequest:request error:nil];
    
    Album *photo = albums.firstObject ? albums.firstObject : (Album *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Album class]) inManagedObjectContext:context];
    photo.albumID = albumID;
    photo.thumID = [json objectForKey:@"thumb_id"];
    photo.title = [json objectForKey:@"title"];
    photo.size = [json objectForKey:@"size"];
    
    NSLog(@"%@ %ld",albums.firstObject ? @"Updated object with id = ": @"Inserted object with id = ",(long)albumID.integerValue);
    [context save:nil];
}

- (NSString *)getAlbumUrl {
    NSArray <Photo *> *photos = [Photo getAllPhotosFromAlbumId:self.albumID];
    Photo *currentPhoto = photos.firstObject;
    return [currentPhoto getImageUrl];
}

@end
