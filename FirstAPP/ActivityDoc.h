//
//  ActivityDoc.h
//  FirstAPP
//
//  Created by Admin on 14.03.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityData.h"
#import <UIKit/UIKit.h>

@interface ActivityDoc : NSObject


@property (strong) ActivityData *data;
@property (strong) UIImage *thumbImage;

- (id)initWithTitle:(NSString*)title andDate :(NSDate*)dateTo andThumbImage:(UIImage *)thumbImage;

@end
