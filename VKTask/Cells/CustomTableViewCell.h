//
//  CustomTableViewCell.h
//  VKTask
//
//  Created by JayPays on 04.07.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;

@end
