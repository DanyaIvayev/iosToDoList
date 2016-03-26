//
//  EditViewController.h
//  FirstAPP
//
//  Created by Admin on 25.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id dateItem;
@property (strong, nonatomic) id descItem;
@property (strong, nonatomic) id isDone;
@property (strong, nonatomic) id isEdit;
@property (assign, nonatomic) BOOL checked;
@property (assign, nonatomic) BOOL edited;

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;
@property (weak, nonatomic) IBOutlet UITextView *descText;
@property (weak, nonatomic) IBOutlet UIButton *isDoneCB;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

-(IBAction)checkBoxButton:(id)sender;
@end
