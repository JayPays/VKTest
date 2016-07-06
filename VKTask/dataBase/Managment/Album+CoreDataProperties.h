//
//  Album+CoreDataProperties.h
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Album.h"

NS_ASSUME_NONNULL_BEGIN

@interface Album (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *thumID;
@property (nullable, nonatomic, retain) NSNumber *albumID;
@property (nullable, nonatomic, retain) NSNumber *size;

@end

NS_ASSUME_NONNULL_END
