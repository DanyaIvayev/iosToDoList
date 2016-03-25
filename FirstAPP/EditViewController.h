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
@property (assign, nonatomic) id isDone;
@property (assign, nonatomic) BOOL checked;

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;
@property (weak, nonatomic) IBOutlet UITextView *descText;
@property (weak, nonatomic) IBOutlet UIButton *isDoneCB;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@end
