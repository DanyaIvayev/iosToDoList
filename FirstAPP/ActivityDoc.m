//
//  ActivityDoc.m
//  FirstAPP
//
//  Created by Admin on 14.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ActivityDoc.h"

@implementation ActivityDoc

@synthesize data=_data;
@synthesize thumbImage=_thumbImage;


- (id)initWithTitle:(NSString*)title andDate :(NSDate*)dateTo andThumbImage:(UIImage *)thumbImage{
    if ((self = [super init])) {
        self.data = [[ActivityData alloc] initWithTitle:title andDate:dateTo];
        self.thumbImage = thumbImage;
        
    }
    return self;
}

@end
