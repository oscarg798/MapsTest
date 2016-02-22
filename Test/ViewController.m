//
//  ViewController.m
//  Test
//
//  Created by Oscar David Gallon Rosero on 6/02/16.
//  Copyright © 2016 Oscar David Gallon Rosero. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;
#define openScheduleText @"Abierto"
#define closeScheduleText @"Cerrado"




@implementation ViewController{
    GMSCameraPosition *camera;
    NSString *lat;
    GMSMarker *marker;
    NSString *lng;
 
    BOOL *hasInitLocation;
    
    //UIImage * someImage = [UIImage imageNamed: @"image_type_icon"];
    
    GMSCoordinateBounds *bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    hasInitLocation= false;
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    
    self.nequiPointsArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.nequiPointsArray addObject:[[NequiPoint alloc] initWithName:@"Botega" type:@"Punto de recarga" address:@"Cll 27 # 24" schedule:closeScheduleText latitude:6.229694 longitude:-75.575182]];
    
    [self.nequiPointsArray addObject:[[NequiPoint alloc] initWithName:@"Bacuba" type:@"Punto de pago" address:@"Cll 27 # 24" schedule:openScheduleText latitude:6.229075 longitude:-75.575064]];
    
    [self initializeInformationCard];
    
    [self initMapView];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void) initializeInformationCard{
    
    [self.pointImage setImage:[UIImage imageNamed:@"image_type_icon"]];
    
    [self.closeButton setImage:[UIImage imageNamed:@"close_icon"]];
    
    self.closeButton.userInteractionEnabled =TRUE;
    
    

    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    
    
    [self.closeButton addGestureRecognizer:singleTap];
    
    

    
    
    
    [self.pointName setTextColor:[self colorFromRGBWithColor:0.2 andWithColor:0.15 andWithColor:0.52]];
    
    [self.pointName setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16]];
    
    [self.pointAddress setTextColor:[self colorFromRGBWithColor:0.63 andWithColor:0.69 andWithColor:0.71]];
    
    [self.pointAddress setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14]];
    
    [self.pointScheduleText setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14]];
    
    [self.pointScheduleText setTextColor:[self colorFromRGBWithColor:1 andWithColor:1 andWithColor:1]];
    
    [self.pointScheduleText setBackgroundColor:[self colorFromRGBWithColor:0.02 andWithColor:1 andWithColor:0.54]];
    
    [self.pointScheduleText setTextAlignment:NSTextAlignmentCenter];
    
    [self.pointType setTextColor:[self colorFromRGBWithColor:0.63 andWithColor:0.69 andWithColor:0.71]];
    
    [self.pointType setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14]];
    
    [self.pointInformationCardView setBackgroundColor: [self colorFromRGBWithColor:1 andWithColor:1 andWithColor:1]];
    
    self.pointInformationCardView.hidden=YES;
    
}
-(void) initMapView{
    camera = [GMSCameraPosition cameraWithLatitude:6.229971
                                         longitude:-75.575686
                                              zoom:15];
    
    self.viewSS.camera = camera;
    [self.viewSS setDelegate:self];
    
    UIEdgeInsets mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 300.0);
    
    self.viewSS.padding = mapInsets;
    
    
    
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(6.229971, -75.575686);
    marker.map = self.viewSS;
    
    
    for(int i = 0; i< 2;i++){
        
        marker = [[GMSMarker alloc] init];
        
        marker.position= CLLocationCoordinate2DMake(        [(NequiPoint*) [self.nequiPointsArray objectAtIndex:i]pointLatitude] ,[(NequiPoint*) [self.nequiPointsArray objectAtIndex:i]pointLongitude]);
        
        marker.title =  [(NequiPoint*) [self.nequiPointsArray objectAtIndex:i]pointName];
        
        marker.map = self.viewSS;
    }
    
    
    
    [self.viewSS addSubview: self.pointInformationCardView];
    
    
    
    //[self initLocationManager];
    
    
}

- (BOOL) mapView:		(GMSMapView *) 	mapView
    didTapMarker:		(GMSMarker *) 	marker{
    
    [self getNequiPointFromMarkerClickWithMarker:marker];
    
    NSLog(@"tap tap tap");
    return true;
}

-(void) getNequiPointFromMarkerClickWithMarker:(GMSMarker*) marker{
    for(NequiPoint* point in self.nequiPointsArray){
        if([point pointName] == [marker title]){
            [self setValuestoInformationCardWithNeQuiPoint:point];
            break;
        }
    }
}

-(void) setValuestoInformationCardWithNeQuiPoint:(NequiPoint*) nequiPoint{
    [self.pointName setText:[nequiPoint pointName]];
    
    [self.pointAddress setText:[nequiPoint pointAddress]];
    [self.pointType setText:[nequiPoint pointType]];
    
    
    
    [self.pointScheduleText setText:[NSString stringWithFormat:@"  %@  ",[nequiPoint pointSchedule]]];
    
    if([[nequiPoint pointSchedule] isEqualToString:closeScheduleText]){
        [self.pointScheduleText setBackgroundColor:[self colorFromRGBWithColor:0.96 andWithColor:0 andWithColor:0.34]];
    }else{
         [self.pointScheduleText setBackgroundColor:[self colorFromRGBWithColor:0.02 andWithColor:1 andWithColor:0.54]];
    }
    
    self.pointInformationCardView.hidden= NO;
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
    [self.locationManager startUpdatingLocation];
    
    
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
-(UIColor *) colorFromRGBWithColor: (float)red andWithColor:(float)green andWithColor:(float)blue{
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

-(void) closeButtonClick{
    self.pointInformationCardView.hidden=YES;
}
-(void)tapDetected:(UITapGestureRecognizer *)sender{
    NSLog(@"single Tap on imageview");
    self.pointInformationCardView.hidden=YES;
}


@end
