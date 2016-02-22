//
//  NequiPoint.m
//  Test
//
//  Created by Oscar David Gallon Rosero on 21/02/16.
//  Copyright © 2016 Oscar David Gallon Rosero. All rights reserved.
//

#import "NequiPoint.h"

@implementation NequiPoint



- (id)initWithName:(NSString*)aName
              type: (NSString*)aType
           address:(NSString*)aAddress
          schedule:(NSString*) aSchedule
          latitude:(double) aLatitude
         longitude:(double) aLongitude;{
    
    if (!(self = [super init]))
        return nil;
    
    _pointName= aName;
    _pointType= aType;
    _pointAddress = aAddress;
    _pointSchedule=aSchedule;
    _pointLatitude = aLatitude;
    _pointLongitude = aLongitude;
    
    return self;
}


@end


