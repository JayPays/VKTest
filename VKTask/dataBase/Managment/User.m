//
//  User.m
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"

@implementation User


#pragma mark - get user

+ (User *)loadUser {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([User class])];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray <User *> *users = [context executeFetchRequest:request error:nil];
    return users.firstObject;
}

#pragma mark - User update

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json withConletionBlock:(void (^)(void))block {
    
    NSNumber *userID = [json objectForKey:@"id"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([User class])];
    request.predicate = [NSPredicate predicateWithFormat:@"userID==%@",userID];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray <User *> *users = [context executeFetchRequest:request error:nil];
    User *currentUser = users.firstObject;
    if (currentUser) {
        User *user = currentUser;
        user.firstName = [json objectForKey:@"first_name"];
        user.lastName = [json objectForKey:@"last_name"];
        user.userImageUrl = [json objectForKey:@"photo_100"];
    } else {
       User *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([User class]) inManagedObjectContext:context];
        user.firstName = [json objectForKey:@"first_name"];
        user.lastName = [json objectForKey:@"last_name"];
        user.userID = userID;
        user.userImageUrl = [json objectForKey:@"photo_100"];
    }
    [context save:nil];
    block();
}


#pragma mark - Load user image

- (void)loadUserImageWithCompletionBlock:(void (^)(UIImage *image))block {
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:self.userImageUrl]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                block(image);
                            } else {
                                block([UIImage imageNamed:@""]);
                            }
                        }];
}

@end
