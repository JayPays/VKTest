//
//  AudioTrackCell.h
//  VKTask
//
//  Created by JayPays on 25.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioTrackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleTrackLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistTrackLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (copy, nonatomic) void (^downloadButtonActionBlock)(id sender);

@end
