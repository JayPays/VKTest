//
//  MusicView.m
//  VKTask
//
//  Created by JayPays on 28.10.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "MusicView.h"

@interface MusicView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation MusicView

- (void)setMusikState:(MusicViewState)musikState {
    if (_musikState != musikState) {
        _musikState = musikState;
        switch (musikState) {
            case MusicViewStatePlay: {
                
                break;
            }
                
            case MusicViewStateStop: {
                
                break;
            }
                
            default:
                break;
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setupFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupFromNib];
    }
    return self;
}

- (void)_setupFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    self.view = [[nib instantiateWithOwner:self options:nil] firstObject];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.view];
    NSDictionary *views = @{ @"view" : self.view };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
}

#pragma mark - Action

- (IBAction)playOrStopAction:(id)sender {
    self.musikState = !self.musikState;
}


- (IBAction)nextTrack:(id)sender {
    
}

- (IBAction)backTrack:(id)sender {
    
}
@end
