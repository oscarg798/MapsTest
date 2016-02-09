//
//  ViewController.m
//  Test
//
//  Created by Oscar David Gallon Rosero on 6/02/16.
//  Copyright © 2016 Oscar David Gallon Rosero. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;


@implementation ViewController{
    GMSCameraPosition *camera;
    NSString *lat;
    GMSMarker *marker;
    NSString *lng;
    BOOL *hasInitLocation;
    GMSCoordinateBounds *bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    hasInitLocation= false;
    self.locationManager = [[CLLocationManager alloc] init];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    [self initMapView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void) initMapView{
    camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                         longitude:151.20
                                              zoom:15];
    
    self.viewSS.camera = camera;
    [self.viewSS setDelegate:self];
    
    //self.viewSS.myLocationEnabled = YES;
    UIEdgeInsets mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 300.0);
    self.viewSS.padding = mapInsets;
    
    
    
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = self.viewSS;
    [self.viewSS setNeedsDisplay];
    
    
    
    
    [self initLocationManager];
    
}
-(IBAction) hasClicked:(id)sender{
    NSLog(@"Click");
    bounds=nil;
    [self.locationManager startUpdatingLocation];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initLocationManager{
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    // Enable automatic pausing
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    
    // Enable background location updates
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    [ self.locationManager startUpdatingLocation];
   
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);

    if (newLocation != nil) {
        
        
        if(bounds==nil){
            bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:newLocation.coordinate coordinate:newLocation.coordinate];
            GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds
                                                     withPadding:100.0f];
            marker.position = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,
                                                         newLocation.coordinate.longitude);
            marker.title = @"Sydney";
            marker.snippet = @"Australia";
            UIImage * someImage = [UIImage imageNamed: @"pin"];
            [marker setIcon:someImage];
            marker.map = self.viewSS;
            [self.locationManager stopUpdatingLocation];
            [self.viewSS animateWithCameraUpdate:update];
        }
        lat = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.longitude];
        lng = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.latitude];
        NSLog(@"Lat %@ Long %@ ",lat,lng );
    }
}

@end
