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
#import "EditViewController.h"
// протокол соответствия на расширение класса
//указывает на то, что этот класс соответствует протоколу SwipeableCellDelegate.

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
    self.cellsCurrentlyEditing = [NSMutableSet new];
    UIImage* image1 = [UIImage imageNamed:@"information-icon28.png"];
    CGRect frameimg = CGRectMake(0, 0, 28, 28);
    UIButton *infoButton = [[UIButton alloc] initWithFrame:frameimg];
    [infoButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(showAboutDialog:)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setShowsTouchWhenHighlighted:NO];
    
    UIBarButtonItem *infobutton =[[UIBarButtonItem alloc] initWithCustomView:infoButton];
    //self.navigationItem.rightBarButtonItem = infobutton;
    
    UIImage* image3 = [UIImage imageNamed:@"orange-plus-sign-hi_28.png"];
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(insertNewObject:)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:NO];
    
    UIBarButtonItem *addbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    NSArray *actionButtonItems = @[infobutton, addbutton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    //self.navigationItem.rightBarButtonItem = addbutton;
    //Добавляем кнопку на добавление новой ячейки
    
    /*UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    /Volumes/VMware Shared Folders/share/orange-plus-sign-hi.png
    self.navigationItem.rightBarButtonItem = addButton;*/
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
    // Восстановление вьюхи
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    //TODO обновить список
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Вставка новой ячейки по нажатию +
- (void)insertNewObject:(id)sender {
    
    [self showEditWithTitle:@"" deadLine: @"" description : @"" status: YES isEdit:NO];
    // после возврата обновить список. добавление ниже убрать
    
    if (!objects) {
        objects = [[NSMutableArray alloc] init];
    }
    ActivityDoc* doc = [[ActivityDoc alloc] initWithTitle:[NSString stringWithFormat:@"Work %@", [@(objects.count) stringValue]] andDate: [NSDate date] andThumbImage:[UIImage imageNamed:@"Checked Checkbox 2-48.png"]];
    [objects insertObject: doc atIndex: objects.count];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:objects.count-1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void) showAboutDialog:(id)sender{
    
}

#pragma mark - SwipeableCellDelegate
//методы делегаты
- (void)buttonOneActionForItemText:(NSString *)itemText indexPath:(NSIndexPath *)indexPath
{
    //вызов окна детального описания с текстом
    /*[self showDetailWithText:[NSString stringWithFormat:@"Clicked button delete for %@", itemText]];*/
    [objects removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)buttonTwoActionForForTitle:(NSString *)title deadLine:(NSString *)deadLine indexPath:(NSIndexPath *)indexPath
{
    [self showEditWithTitle:title deadLine: deadLine description : @"Try to enter very long text that fill more space and contain very interesting information" status: YES isEdit:YES];
}

- (void)buttonThreeActionForTitle:(NSString *)title deadLine:(NSString *) deadLine indexPath: (NSIndexPath *) indexPath
{
    //  по индексу достать описание и буленовское значение
    [self showDetailWithTitle:title deadLine: deadLine description : @"Try to enter very long text that fill more space and contain very interesting information" status: YES];

}

/*#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:objects[indexPath.row]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //------------------------------------------//
    return objects.count;
    //return self.activities.count;
}

/*
 Заполнение ячейки в TableView по индексу
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Достаем кастомизированную ячейку, которую мы создали в стори боард и указали ей идентификатор SwipeableCell
    SwipeableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwipeableCell" forIndexPath:indexPath];
    // достаем по индексу элемент нашей модели по индексу.
    ActivityDoc *act = [objects objectAtIndex:indexPath.row];
    // заполнение лейблов данными
    UILabel* title =(UILabel*)cell.nameLabel;
    title.text= act.data.title;
    
    UILabel* date = (UILabel*)cell.dateLabel;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm"];
    
    date.text = [dateFormatter stringFromDate:act.data.dateTo];
    // заполнение картинки
    UIImageView* img = cell.thumbImage;
    img.image = act.thumbImage;
    NSString *item = objects[indexPath.row];
    cell.itemText = item;
    cell.indexPath = indexPath;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.myContentView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(255/255.0) green:(126/255.0) blue:(22/255.0) alpha:1] CGColor], (id)[[UIColor colorWithRed:(203/255.0) green:(99/255.0) blue:(19/255.0) alpha:1]CGColor], nil];
    [cell.myContentView.layer insertSublayer:gradient atIndex:0];    // устанавливаем этот ViewController в качестве делегата ячейки.
    cell.delegate = self;
    
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
        [cell openCell];
    }
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
- (void)showDetailWithTitle:(NSString *)title deadLine:(NSString *) deadLine description : (NSString *) description status: (BOOL) status
{
    //1
    /*
     Достаем контроллер для отображения DeatailView 
     устанавливаем ему название и текст
     */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detail.title = @"Description!";
    detail.detailItem = title;
    detail.dateItem = deadLine;
    detail.descItem=description;
    //detail.descItem=description;
    detail.isDone=[NSNumber numberWithBool : status];
    
    
    //2
    /*
     Настройка UINavigationController содержит detail controller view и дает нам место, чтобы добавить кнопку закрытия.     */
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detail];
    
    //3
    /*
     Добавляем кнопку закрытия с возвратом в Master View Controller.     */
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeModal)];
    [detail.navigationItem setRightBarButtonItem:done];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)showEditWithTitle:(NSString *)title deadLine:(NSString *) deadLine description : (NSString *) description status: (BOOL) status isEdit: (BOOL) isEdit
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditViewController *edit = [storyboard instantiateViewControllerWithIdentifier:@"EditWork"];
    if(isEdit)
        edit.title = @"Edit work";
    else
        edit.title=@"Add new work";
    edit.detailItem = title;
    edit.dateItem = deadLine;
    edit.descItem=description;
    //detail.descItem=description;
    edit.isDone=[NSNumber numberWithBool : status];
    edit.isEdit = [NSNumber numberWithBool: isEdit];
    
    //2
    /*
     Настройка UINavigationController содержит detail controller view и дает нам место, чтобы добавить кнопку закрытия.     */
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:edit];
    
    //3
    /*
     Добавляем кнопку закрытия с возвратом в Master View Controller.     */
    /*UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeModal)];*/
    UIBarButtonItem *back = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(closeModal)];
    [edit.navigationItem setRightBarButtonItem:back];
    
    [self presentViewController:navController animated:YES completion:nil];
    //UIBarButtonSystemItemDone
}

//4
/*установка фактической цели для кнопки закрытия, которая отключает любое модальное представление.*/
- (void)closeModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cellDidOpen:(UITableViewCell *)cell {
    NSIndexPath *currentEditingIndexPath = [self.tableView indexPathForCell:cell];
    [self.cellsCurrentlyEditing addObject:currentEditingIndexPath];
}

- (void)cellDidClose:(UITableViewCell *)cell {
    [self.cellsCurrentlyEditing removeObject:[self.tableView indexPathForCell:cell]];
}
@end
