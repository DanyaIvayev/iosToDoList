//
//  ScaryBugData.m
//  FirstAPP
//
//  Created by Admin on 11.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ActivityData.h"

@implementation ActivityData
    @synthesize title = _title;
    @synthesize dateTo = _dateTo;

- (id)initWithTitle:(NSString*)title andDate:(NSDate *)dateTo{
    if ((self = [super init])) {
        self.title = title;
        self.dateTo = dateTo;
    }
    return self;
}

@end
