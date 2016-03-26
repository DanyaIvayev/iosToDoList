//
//  EditViewController.m
//  FirstAPP
//
//  Created by Admin on 25.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "EditViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MasterViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize checked;
@synthesize edited;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descText.layer.borderWidth = 2.0f;
    self.descText.layer.borderColor = [[UIColor grayColor] CGColor];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
    if(self.isEdit){
        NSNumber *val = self.isEdit;
        BOOL isEdit = [val boolValue];
        edited=isEdit;
        if(isEdit){
            if (self.detailItem) {
                self.titleText.text = [self.detailItem description];
            }
            if(self.dateItem){
                NSString * dateString = [self.dateItem description];
                NSDateFormatter *formatter;
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd-MM-YYYY HH:mm"];
                
                NSDate *date=[formatter dateFromString:dateString];
                [self.deadlinePicker setDate:date];        //self.deadlinelabel.text = [self.dateItem description];
            }
            if(self.descItem){
                self.descText.text = [self.descItem description];
                [self.descText sizeToFit];
            }
            if(self.isDone){
                NSNumber *val = self.isDone;
                checked = [val boolValue];
                
                if (checked) {
                    [self.isDoneCB setImage:[UIImage imageNamed:@"Checked Checkbox-52.png"] forState: UIControlStateNormal];
                } else {
                    [self.isDoneCB setImage:[UIImage imageNamed:@"Unchecked Checkbox-50.png"] forState: UIControlStateNormal];
                }
            }
        } else {
            NSDateFormatter *formatter;
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY HH:mm"];
            
            NSDate *date=[NSDate date];
            
            [self.deadlinePicker setDate:date];        //self.deadlinelabel.text = [self.dateItem description];
            
            checked = NO;
            
            [self.isDoneCB setImage:[UIImage imageNamed:@"Unchecked Checkbox-50.png"] forState: UIControlStateNormal];
        }
        
    }

}

-(IBAction)checkBoxButton:(id)sender{
    if (checked) {
        [self.isDoneCB setImage:[UIImage imageNamed:@"Unchecked Checkbox-50.png"] forState: UIControlStateNormal];
        checked = NO;
        
    } else {
        [self.isDoneCB setImage:[UIImage imageNamed:@"Checked Checkbox-52.png"] forState: UIControlStateNormal];
        checked = YES;
        
    }
}

-(IBAction)saveButtonClicked:(id)sender{
    NSString* title = self.titleText.text;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm"];
    
    NSString* date = [dateFormatter stringFromDate:[self.deadlinePicker date]];
    NSString* description = self.descText.text;
    
    if(edited){
        // TODO save by id or index?
    } else {
        // TODO save new object
    }
    [self returnTomainScreen];
}

-(IBAction)cancelButtonClicked:(id)sender{
    [self returnTomainScreen];
}

-(void) returnTomainScreen{
    [self dismissViewControllerAnimated:YES completion:nil];
     }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
