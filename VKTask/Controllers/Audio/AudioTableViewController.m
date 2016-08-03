//
//  AudioTableViewController.m
//  VKTask
//
//  Created by D.Vm on 03.08.16.
//  Copyright © 2016 Vladislav Molodetskiy. All rights reserved.
//

#import "AudioTableViewController.h"
#import "CustomTableViewCell.h"

@interface AudioTableViewController ()

@end

@implementation AudioTableViewController

- (void)laodView {
    UITableView *view = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


@end
