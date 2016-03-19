//
//  SwipeableCell.m
//  FirstAPP
//
//  Created by Admin on 17.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SwipeableCell.h"

@implementation SwipeableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClicked:(id)sender {
    if (sender == self.button1) {
        [self.delegate buttonOneActionForItemText:self.itemText];
    } else if (sender == self.button2) {
        [self.delegate buttonTwoActionForItemText:self.itemText];
    } else {
        NSLog(@"Clicked unknown button!");
    }
}@end
