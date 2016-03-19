//
//  ScaryBugData.h
//  FirstAPP
//
//  Created by Admin on 11.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityData : NSObject
    @property (strong) NSString *title;
    @property (strong) NSDate *dateTo;

    - (id)initWithTitle:(NSString*)title andDate:(NSDate*)dateTo;

@end
