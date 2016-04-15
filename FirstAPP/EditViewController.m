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
#import <CoreData/CoreData.h>

@interface EditViewController (){
    NSManagedObjectContext *managedObjectContext;
}
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
            managedObjectContext = [self managedObjectContext];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Activity"];
            NSMutableArray *objects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
            self.activity=[objects objectAtIndex:((NSIndexPath*)self.indexId).row];
            self.titleText.text = [self.activity valueForKey:@"name"];
            [self.deadlinePicker setDate:[self.activity valueForKey:@"deadline"]];
            self.descText.text = [self.activity valueForKey:@"desc"];
            [self.descText sizeToFit];
            NSNumber *val = [self.activity valueForKey:@"done"];
            checked = [val boolValue];
            if (checked) {
                [self.isDoneCB setImage:[UIImage imageNamed:@"Checked Checkbox-52.png"] forState: UIControlStateNormal];
            } else {
                [self.isDoneCB setImage:[UIImage imageNamed:@"Unchecked Checkbox-50.png"] forState: UIControlStateNormal];
            }
        } else {
            NSDateFormatter *formatter;
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY HH:mm"];
            
            NSDate *date=[NSDate date];
            
            [self.deadlinePicker setDate:date];
            
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

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

-(IBAction)saveButtonClicked:(id)sender{
    NSString* name = self.titleText.text;

    NSDate* date = self.deadlinePicker.date;
    NSString* description = self.descText.text;
    
    if(edited){
        [self.activity setValue:name forKey:@"name"];
        [self.activity setValue:date forKey:@"deadline"];
        [self.activity setValue:description forKey:@"desc"];
        [self.activity setValue:[NSNumber numberWithBool:checked] forKey:@"done"];
        NSError *error = nil;
        if(![managedObjectContext save:&error]){
            NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Updated!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    } else {
        NSManagedObject *newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:managedObjectContext];
        [newActivity setValue:name forKey:@"name"];
        [newActivity setValue:date forKey:@"deadline"];
        [newActivity setValue:description forKey:@"desc"];
        [newActivity setValue:[NSNumber numberWithBool:checked] forKey:@"done"];
        NSError *error = nil;
        if(![managedObjectContext save:&error]){
            NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"New record is added!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    [self returnTomainScreen];
}

-(IBAction)cancelButtonClicked:(id)sender{
    [self returnTomainScreen];
}

-(void) returnTomainScreen{
    [self dismissViewControllerAnimated:YES completion:nil];
     }

@end
