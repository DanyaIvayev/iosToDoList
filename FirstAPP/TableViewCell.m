//
//  TableViewCell.m
//  FirstAPP
//
//  Created by Admin on 14.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize dateLabel = _dateLabel;
@synthesize dateValueLabel=_dateValueLabel;
@synthesize thumbnailImageView = _thumbnailImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL) canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:) || action == @selector(test:));
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

/// this methods will be called for the cell menu items
-(void) test: (id) sender {
    
}



@end
