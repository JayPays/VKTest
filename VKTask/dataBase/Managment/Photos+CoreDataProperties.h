//
//  Photos+CoreDataProperties.h
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *album_id;
@property (nullable, nonatomic, retain) NSString *photo_1280;
@property (nullable, nonatomic, retain) NSString *photo_130;
@property (nullable, nonatomic, retain) NSString *photo_604;
@property (nullable, nonatomic, retain) NSString *photo_75;
@property (nullable, nonatomic, retain) NSString *photo_807;
@property (nullable, nonatomic, retain) NSNumber *photoID;

@end

NS_ASSUME_NONNULL_END
