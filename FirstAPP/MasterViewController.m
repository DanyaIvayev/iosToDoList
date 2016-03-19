//
//  MasterViewController.m
//  FirstAPP
//
//  Created by Admin on 11.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ActivityData.h"
#import "ActivityDoc.h"
#import "TableViewCell.h"
#import "SwipeableCell.h"
@interface MasterViewController () <SwipeableCellDelegate>{
 NSMutableArray * objects;
}
@end

@implementation MasterViewController

@synthesize activities = _activities;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
   // self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //-------------------------------------------//
    
    /*UIMenuItem *testMenuItem = [[UIMenuItem alloc] initWithTitle:@"Edit" action:@selector(test:)];
    [[UIMenuController sharedMenuController] setMenuItems: [NSArray arrayWithObjects: testMenuItem, nil]];*/
    //[testMenuItem release];
    
    //[[UIMenuController sharedMenuController] delete:1];
    //[[UIMenuController sharedMenuController] update];
    self.title =@"ActivitiesList";
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    /*if (!self.activities) {
        self.activities = [[NSMutableArray alloc] init];
    }
    [self.activities insertObject:[[ActivityDoc alloc] initWithTitle:@"Make homework" andDate: [NSDate date] andThumbImage:[UIImage imageNamed:@"omnifocus-for-iphone-icon.png"]] atIndex:0];*/
    if (!objects) {
        objects = [[NSMutableArray alloc] init];
    }
    ActivityDoc* doc = [[ActivityDoc alloc] initWithTitle:[NSString stringWithFormat:@"Work %@", [@(objects.count) stringValue]] andDate: [NSDate date] andThumbImage:[UIImage imageNamed:@"omnifocus-for-iphone-icon.png"]];
    [objects insertObject: doc atIndex:0];
    //NSInteger count = objects.count;
    //[objects insertObject: [@(count) stringValue] atIndex: 0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - SwipeableCellDelegate
- (void)buttonOneActionForItemText:(NSString *)itemText
{
    [self showDetailWithText:[NSString stringWithFormat:@"Clicked button one for %@", itemText]];
}

- (void)buttonTwoActionForItemText:(NSString *)itemText
{
    [self showDetailWithText:[NSString stringWithFormat:@"Clicked button two for %@", itemText]];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        /*ActivityDoc* act =self.activities[indexPath.row];        NSDate *object = act.data.dateTo;*/
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:objects[indexPath.row]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //------------------------------------------//
    return objects.count;
    //return self.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*static NSString* cellID = @"TableCellAct";
    TableViewCell* cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    ActivityDoc *act = [self.activities objectAtIndex:indexPath.row];
    
    UILabel* title =(UILabel*)cell.nameLabel;
    title.text= act.data.title;
    
    UILabel* date = (UILabel*)cell.dateLabel;
    date.text=@"Date:";
    
    UILabel* dateValue = (UILabel*)cell.dateValueLabel;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm"];
    
    dateValue.text = [dateFormatter stringFromDate:act.data.dateTo];
    UIImageView* img = (UIImageView*) [cell.contentView viewWithTag:4];
    img.image = act.thumbImage;*/
    SwipeableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwipeableCell" forIndexPath:indexPath];
    ActivityDoc *act = [objects objectAtIndex:indexPath.row];
    
    UILabel* title =(UILabel*)cell.nameLabel;
    title.text= act.data.title;
    
    UILabel* date = (UILabel*)cell.dateLabel;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm"];
    
    date.text = [dateFormatter stringFromDate:act.data.dateTo];
    UIImageView* img = cell.thumbImage;
    img.image = act.thumbImage;
    //NSString *item = objects[indexPath.row];
    //cell.itemText = item;
    cell.delegate = self;
    return cell;
    
}

- (BOOL)                tableView:(UITableView *)tableView
  shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /* Allow the context menu to be displayed on every cell */
    return YES;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}


- (BOOL) tableView:(UITableView *)tableView
  canPerformAction:(SEL)action
 forRowAtIndexPath:(NSIndexPath *)indexPath
        withSender:(id)sender{
    /*if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        return NO;
    }
    if (action == @selector(test:)){
        return YES;
    } else
        return NO;*/
    return NO;
    
}

- (void) tableView:(UITableView *)tableView
     performAction:(SEL)action
 forRowAtIndexPath:(NSIndexPath *)indexPath
        withSender:(id)sender{
    
       
}

/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //-------------------------------------
        [self.activities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}*/
- (void)showDetailWithText:(NSString *)detailText
{
    //1
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detail.title = @"In the delegate!";
    detail.detailItem = detailText;
    
    //2
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detail];
    
    //3
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeModal)];
    [detail.navigationItem setRightBarButtonItem:done];
    
    [self presentViewController:navController animated:YES completion:nil];
}

//4
- (void)closeModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
