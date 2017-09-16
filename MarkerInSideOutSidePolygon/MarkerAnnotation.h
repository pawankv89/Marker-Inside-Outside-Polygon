//
//  MarkerAnnotation.h
//  GeoMapAPI
//
//  Created by Pawan kumar on 9/11/17.
//  Copyright © 2017 Pawan kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MarkerAnnotation : NSObject<MKAnnotation>
{
    NSString *title;
    NSString *subtitle;
    NSString *location;
    NSString *latitude;
    NSString *longitude;
    CLLocationCoordinate2D coordinate;
    NSString *markerUrl;
    NSString *address;
    NSString *contact;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, copy) NSString * location;
@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * longitude;
@property (nonatomic, copy) NSString * markerUrl;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * contact;

@end
