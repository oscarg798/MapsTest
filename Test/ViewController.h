//
//  ViewController.h
//  Test
//
//  Created by Oscar David Gallon Rosero on 6/02/16.
//  Copyright © 2016 Oscar David Gallon Rosero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NequiPoint.h"
@import CoreLocation;
@import GoogleMaps;



@interface ViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *pointInformationCardView;

@property (weak, nonatomic) IBOutlet UILabel *pointScheduleText;

@property (strong, nonatomic) IBOutlet UIView *PrincipalView;
@property (weak, nonatomic) IBOutlet UIImageView *pointImage;
@property (weak, nonatomic) IBOutlet UILabel *pointName;

@property (nonatomic)     UITapGestureRecognizer *singleTap ;

@property (weak, nonatomic) IBOutlet UIImageView *closeButton;

@property (weak, nonatomic) IBOutlet UILabel *pointAddress;
@property (weak, nonatomic) IBOutlet UILabel *pointType;
@property (weak, nonatomic)  GMSMapView *viewSS;
@property (weak, nonatomic) IBOutlet UIButton *button;


@property(strong, nonatomic) NSMutableArray *nequiPointsArray;


@property(nonatomic,retain) CLLocationManager *locationManager;


-(void) initLocationManager;
-(void) initMapView;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
-(UIColor *) colorFromRGBWithColor: (float)red andWithColor:(float)green andWithColor:(float)blue;


-(IBAction) hasClicked:(id)sender;

-(void) initializeInformationCard;

-(void) setValuestoInformationCardWithNeQuiPoint:(NequiPoint*) nequiPoint;

-(void) getNequiPointFromMarkerClickWithMarker:(GMSMarker*) marker;

-(void) closeButtonClick;

@end

