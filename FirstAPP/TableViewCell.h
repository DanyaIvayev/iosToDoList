//
//  TableViewCell.h
//  FirstAPP
//
//  Created by Admin on 14.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *dateValueLabel;

-(BOOL) canPerformAction:(SEL)action withSender:(id)sender;
-(BOOL)canBecomeFirstResponder;
-(void) test: (id) sender;
    
@end
