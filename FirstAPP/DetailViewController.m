//
//  DetailViewController.m
//  FirstAPP
//
//  Created by Admin on 11.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize checked;

#pragma mark - Managing the detail item

/*- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}*/

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleLabel.text = [self.detailItem description];
    }
    if(self.dateItem){
        self.deadlinelabel.text = [self.dateItem description];
    }
    if(self.descItem){
        self.descLabel.text = [self.descItem description];
        [self.descLabel sizeToFit];
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
}

-(IBAction)checkBoxButton:(id)sender{
    if (checked) {
        [self.isDoneCB setImage:[UIImage imageNamed:@"Unchecked Checkbox-50.png"] forState: UIControlStateNormal];
        checked = NO;
        //TODO save state
    } else {
        [self.isDoneCB setImage:[UIImage imageNamed:@"Checked Checkbox-52.png"] forState: UIControlStateNormal];
        checked = YES;
        // TODO save State
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
