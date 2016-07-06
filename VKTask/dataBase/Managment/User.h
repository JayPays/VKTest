//
//  User.h
//  VKTask
//
//  Created by Jay on 02.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

- (void)loadUserImageWithCompletionBlock:(void (^)(UIImage *image))block;

+ (void)inserOrUpdateUserEntity:(NSDictionary *)json withConletionBlock:(void (^)(void))block;

+ (User *)loadUser;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
