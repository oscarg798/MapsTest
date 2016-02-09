//
//  ViewController.h
//  Test
//
//  Created by Oscar David Gallon Rosero on 6/02/16.
//  Copyright © 2016 Oscar David Gallon Rosero. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import GoogleMaps;



@interface ViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *PrincipalView;
@property (weak, nonatomic)  GMSMapView *viewSS;
@property (weak, nonatomic) IBOutlet UIButton *button;


@property(nonatomic,retain) CLLocationManager *locationManager;


-(void) initLocationManager;
-(void) initMapView;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

-(IBAction) hasClicked:(id)sender;


@end

