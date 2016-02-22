//
//  NequiPoint.h
//  Test
//
//  Created by Oscar David Gallon Rosero on 21/02/16.
//  Copyright © 2016 Oscar David Gallon Rosero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NequiPoint : NSObject

@property (weak, nonatomic) NSString* pointName;
@property (weak, nonatomic) NSString* pointType;
@property (weak, nonatomic) NSString* pointAddress;
@property (weak, nonatomic) NSString* pointSchedule;
@property (nonatomic) double pointLatitude;
@property (nonatomic) double pointLongitude;

- (id)initWithName:(NSString*)aName
              type: (NSString*)aType
           address:(NSString*)aAddress
          schedule:(NSString*) aSchedule
          latitude:(double) aLatitude
         longitude:(double) aLongitude;
@end
