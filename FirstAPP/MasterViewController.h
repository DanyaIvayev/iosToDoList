//
//  MasterViewController.h
//  FirstAPP
//
//  Created by Admin on 11.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController


@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong) NSMutableArray *activities;

@end

