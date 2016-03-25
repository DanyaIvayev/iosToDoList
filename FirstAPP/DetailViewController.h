//
//  DetailViewController.h
//  FirstAPP
//
//  Created by Admin on 11.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id dateItem;
@property (strong, nonatomic) id descItem;
@property (assign, nonatomic) id isDone;
@property (assign, nonatomic) BOOL checked;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlinelabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *isDoneCB;

-(IBAction)checkBoxButton:(id)sender;
@end

