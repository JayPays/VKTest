//
//  Photo.m
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "Photo.h"
#import "AppDelegate.h"

@implementation Photo


+ (void)inserOrUpdateUserEntity:(NSDictionary *)json {
    
    NSNumber *photoID = [json objectForKey:@"id"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Photo class])];
    request.predicate = [NSPredicate predicateWithFormat:@"photoID==%@",photoID];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray <Photo *> *photos = [context executeFetchRequest:request error:nil];
    
    Photo *photo = photos.firstObject ? photos.firstObject : (Photo *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Photo class]) inManagedObjectContext:context];
    photo.photo_1280 = [json objectForKey:@"photo_1280"];
    photo.photo_807 = [json objectForKey:@"photo_807"];
    photo.photo_604 = [json objectForKey:@"photo_604"];
    photo.photo_130 = [json objectForKey:@"photo_130"];
    photo.photo_75 = [json objectForKey:@"photo_75"];
    photo.album_id = [json objectForKey:@"album_id"];
    photo.date = [NSDate dateWithTimeIntervalSinceReferenceDate:[[json objectForKey:@"date"] integerValue]];
    photo.photoID = photoID;
    
    NSLog(@"%@ %ld",photos.firstObject ? @"Updated object with id = ": @"Inserted object with id = ",(long)photoID.integerValue);
    [context save:nil];
}

+ (NSArray <NSString *> *)getAllAlbumId {
    NSMutableArray <NSString *> *arrayWithAlbumId = [NSMutableArray new];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Photo class])];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray <Photo *> *photos = [context executeFetchRequest:request error:nil];
    for (Photo *photo in photos) {
        [arrayWithAlbumId addObject:[NSString stringWithFormat:@"%@",photo.album_id]];
    }
    return [arrayWithAlbumId copy];
}

+ (NSArray <Photo *> *)getAllPhotosFromAlbumId:(NSNumber *)albumID {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Photo class])];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    request.predicate = [NSPredicate predicateWithFormat:@"album_id==%@",albumID];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray <Photo *> *photos = [context executeFetchRequest:request error:nil];
    return photos;
}

- (NSString *)getImageUrlHighResolution {
    
    if (self.photo_1280.length) {
        return self.photo_1280;
    }
    
    if (self.photo_807.length) {
        return self.photo_807;
    }
    
    if (self.photo_604.length) {
        return self.photo_604;
    }
    
    if (self.photo_130.length) {
        return self.photo_130;
    }
    
    if (self.photo_75.length) {
        return self.photo_75;
    }
    return nil;
}

- (NSString *)getImageUrl {
    
    if (self.photo_604.length) {
        return self.photo_604;
    }
    
    if (self.photo_130.length) {
        return self.photo_130;
    }
    
    if (self.photo_75.length) {
        return self.photo_75;
    }
    return nil;
}

@end
