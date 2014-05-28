//
//  SYMPOLSearchTaskController.h
//  Sympol
//
//  Created by Ryan Mullins on 5/15/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

@import UIKit;
@import CoreLocation;
@import MapKit;

@interface SYMPOLTaskSearchController : UIViewController <MKMapViewDelegate>

@property (nonatomic) IBOutlet MKMapView * map;

@end
