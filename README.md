
MarkerInSideOutSidePolygon
=========

## MarkerInSideOutSidePolygon.
------------
 Added Some screens here.
 
[![](https://github.com/pawankv89/MarkerInSideOutSidePolygon/blob/master/images/screen_1.png)]
[![](https://github.com/pawankv89/MarkerInSideOutSidePolygon/blob/master/images/screen_2.png)]
[![](https://github.com/pawankv89/MarkerInSideOutSidePolygon/blob/master/images/screen_3.png)]


## Usage
------------
 iOS Demo showing how to use Inside or outside point in polygon on iPhone 6s devices in Objective-C.

```objective-c

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
```

### Examples


```objective-c
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
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each MBProgressHUD release can be found in the [CHANGELOG](CHANGELOG.mdown). 
