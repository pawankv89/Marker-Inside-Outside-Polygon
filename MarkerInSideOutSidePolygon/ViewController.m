//
//  ViewController.m
//  MarkreTapGestureOnMapView
//
//  Created by Pawan kumar on 9/16/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CustomerMapAnnotation.h"
#import "MarkerAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
//When Select Customer by List or Map
@property (nonatomic) CustomerMapAnnotation *customAnnotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.mapView setDelegate:self];
    
    //create UIGestureRecognizer to detect a tap
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addMarkerOnMap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:tapRecognizer];
    
    //Drow Polygon
    [self setUpMapPolygon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[CustomerMapAnnotation class]])
    {
        NSString *customerAnnotationIdentifier = @"Custome";
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customerAnnotationIdentifier];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customerAnnotationIdentifier];
            pinView.canShowCallout = YES;
            pinView.calloutOffset = CGPointMake(0, 0);//Manage Callout Top Posstion
            
        } else {
            
            pinView.annotation = annotation;
        }
        
        UIImage *markerIcon = [UIImage imageNamed:@"marker"];
        
        //UIImage *marker = [UIImage imageNamed:"u"];
        
        pinView.image = markerIcon;
        return pinView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSLog(@"Clicked Default Annotation");
    }
    
    if ([annotation isKindOfClass:[CustomerMapAnnotation class]])
    {
        NSLog(@"Clicked Customer Annotation");
        
        CustomerMapAnnotation *customerAnnotation = (CustomerMapAnnotation*)annotation;
        
        NSLog(@"CustomerMapAnnotation Annotation Title:- %@",customerAnnotation.title);
    }
}


/**
 * GeoMap Tile Overlay Rendering default delegate method of MAPKit
 *
 */
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKTileOverlay class]]) {
        
        return [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay];
        
    }
    if ([overlay isKindOfClass:[MKCircle class]]) {
        
        MKCircleRenderer *view = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        view.fillColor=[[UIColor blueColor]colorWithAlphaComponent:0.1];
        view.strokeColor=[UIColor blueColor];
        
        view.lineWidth = 1.0;
        
        return view;
    }
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *routeLineView = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        routeLineView.fillColor = [UIColor whiteColor];
        
        routeLineView.lineWidth = 1.0f;
        
        routeLineView.strokeColor = [UIColor redColor];
        
        return routeLineView;
    }
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        
        UIColor *colorblue = [UIColor colorWithRed:36.0f/255.0f green:43.0f/255.0f blue:128.0f/255.0f alpha:0.5];
        MKPolygonRenderer *polygonView = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        polygonView.fillColor = colorblue;
        polygonView.strokeColor = [UIColor purpleColor];
        polygonView.lineWidth = 1.0f;
        
        return polygonView;
    }
    
    return nil;
}
-(void)setUpMapPolygon{
    
    //Update PolyLine
    for (id<MKOverlay> overlayToRemove in self.mapView.overlays)
    {
        if ([overlayToRemove isKindOfClass:[MKPolyline class]])
        {
            [self.mapView removeOverlay:overlayToRemove];
        }
    }
    
    //Remove MKPolygon
    for (id<MKOverlay> overlayToRemove in self.mapView.overlays)
    {
        if ([overlayToRemove isKindOfClass:[MKPolygon class]])
        {
            [self.mapView removeOverlay:overlayToRemove];
        }
    }
    
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = NO;
    
    MarkerAnnotation *points0 = [MarkerAnnotation new];
    MarkerAnnotation *points1 = [MarkerAnnotation new];
    MarkerAnnotation *points2 = [MarkerAnnotation new];
    MarkerAnnotation *points3 = [MarkerAnnotation new];
    
    points0.coordinate = CLLocationCoordinate2DMake(41.000512, -109.050116);
    points1.coordinate = CLLocationCoordinate2DMake(41.002371, -102.052066);
    points2.coordinate = CLLocationCoordinate2DMake(36.993076, -102.041981);
    points3.coordinate = CLLocationCoordinate2DMake(36.99892, -109.045267);
    
    NSMutableArray *points = [[NSMutableArray alloc] initWithObjects:points0,points1,points2,points3, nil];
    
    
    if ([points count]>0) {
        
        NSInteger numberOfSteps = [points count];
        CLLocationCoordinate2D coordinates[numberOfSteps];
        
        for (int x = 0; x < numberOfSteps; x++) {
            
            MarkerAnnotation *route = (MarkerAnnotation*)[points objectAtIndex:x];
            
            coordinates[x] = CLLocationCoordinate2DMake(route.coordinate.latitude, route.coordinate.longitude);
        }
        
        MKPolygon *polygonPath = [MKPolygon polygonWithCoordinates:coordinates count:numberOfSteps];
        polygonPath.title = @"Red";
        [self.mapView addOverlay:polygonPath level:MKOverlayLevelAboveRoads];
        
        //Center of MAP
        [self centerMapShowWithoutUserLocation:points];
    }
    
}
-(void)centerMapShowWithoutUserLocation:(NSMutableArray*)arr
{
    
    MKCoordinateRegion region;
    CLLocationDegrees maxLat = -90.0;
    CLLocationDegrees maxLon = -180.0;
    CLLocationDegrees minLat = 90.0;
    CLLocationDegrees minLon = 180.0;
    
    for(int idx = 0; idx < arr.count; idx++)
    {
        MarkerAnnotation *currentLocation = (MarkerAnnotation*) [arr objectAtIndex:idx];
        
        if(currentLocation.coordinate.latitude > maxLat)
            maxLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.latitude < minLat)
            minLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.longitude > maxLon)
            maxLon = currentLocation.coordinate.longitude;
        if(currentLocation.coordinate.longitude < minLon)
            minLon = currentLocation.coordinate.longitude;
    }
    
    region.center.latitude     = (maxLat + minLat) / 2.0;//2.0
    region.center.longitude    = (maxLon + minLon) / 2.0;//2.0
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    
    region.span.latitudeDelta  = ((maxLat - minLat)<0.0) ? 100.0 :(maxLat - minLat);
    region.span.longitudeDelta = ((maxLon - minLon)<0.0) ? 100.0 :(maxLon - minLon);
    
    region.span.latitudeDelta  = MIN(region.span.latitudeDelta  * 2.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 2.0, 180.0);
    
    [self.mapView setRegion:region animated:YES];
    
}

-(IBAction)addMarkerOnMap:(UITapGestureRecognizer *)recognizer{
    
    //Remove Agent Annotation before adding
    for (id annotationAgent in self.mapView.annotations) {
        
        if ([annotationAgent isKindOfClass:[CustomerMapAnnotation class]])
        {
            [self.mapView removeAnnotation:(CustomerMapAnnotation*)annotationAgent];
        }
    }
    
    //User Annotation
    if (self.customAnnotation == nil) {
        
        self.customAnnotation = [[CustomerMapAnnotation alloc] init];
    }
    
    CGPoint point = [recognizer locationInView:self.mapView];
    
    CLLocationCoordinate2D tapPoint = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    
    self.customAnnotation.title = @"Name";
    self.customAnnotation.subtitle = [NSString stringWithFormat:@"Lat(%f) Lng(%f)",tapPoint.latitude,tapPoint.longitude];
    self.customAnnotation.coordinate = tapPoint;
    
    [self.mapView addAnnotation:self.customAnnotation];
    
    //Default showing Callout
    [self.mapView selectAnnotation:self.customAnnotation animated:TRUE];

    //MarkerInSideOutSidePolygon
    [self MarkerInSideOutSidePolygon];
}

-(void)MarkerInSideOutSidePolygon{
    
    BOOL isInside;
    
    CLLocationCoordinate2D sampleLocation = self.customAnnotation.coordinate;///13,80 is the latlong of clear colored area of the MKPolygon in the below image.
    MKMapPoint mapPoint = MKMapPointForCoordinate(sampleLocation);
    CGPoint mapPointAsCGP = CGPointMake(mapPoint.x, mapPoint.y);
    
    for (id<MKOverlay> overlay in self.mapView.overlays) {
        if([overlay isKindOfClass:[MKPolygon class]]){
            MKPolygon *polygon = (MKPolygon*) overlay;
            
            CGMutablePathRef mpr = CGPathCreateMutable();
            
            MKMapPoint *polygonPoints = polygon.points;
            
            for (int p=0; p < polygon.pointCount; p++){
                MKMapPoint mp = polygonPoints[p];
                if (p == 0)
                    CGPathMoveToPoint(mpr, NULL, mp.x, mp.y);
                else
                    CGPathAddLineToPoint(mpr, NULL, mp.x, mp.y);
            }
            
            if(CGPathContainsPoint(mpr , NULL, mapPointAsCGP, FALSE)){
                
                isInside = YES;
                
                NSLog(@"Inside");
                self.customAnnotation.title = @"Inside";
                
            }else{
                
                NSLog(@"Outside");
                self.customAnnotation.title = @"Outside";
            }
            
            CGPathRelease(mpr);
        }
    }
}

@end


