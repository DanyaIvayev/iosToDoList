//
//  SwipeableCell.h
//  FirstAPP
//
//  Created by Admin on 17.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeableCellDelegate <NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
@end

@interface SwipeableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIView *myContentView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImage;
@property (nonatomic, strong) NSString *itemText;
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;
@end
