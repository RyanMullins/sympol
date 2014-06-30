//
//  SYMPOLSearchTaskController.m
//  Sympol
//
//  Created by Ryan Mullins on 5/15/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLTaskSearchController.h"
#import "SYMPOLEvaluationModel.h"
#import "SYMPOLTaskSearchModel.h"

#include <stdlib.h>

#define ARC4RANDOM_MAX 0x100000000

@interface SYMPOLTaskSearchController ()

@property (nonatomic) SYMPOLTaskSearchModel * model;
@property (nonatomic) NSDate * startTime;
@property (nonatomic) NSDate * endTime;

@end

@implementation SYMPOLTaskSearchController
@synthesize endTime;
@synthesize model;
@synthesize map;
@synthesize startTime;

#pragma mark - Initialization

- (void) viewDidLoad {
    [super viewDidLoad];
    self.model = (SYMPOLTaskSearchModel *)[[SYMPOLEvaluationModel sharedEvaluationModel] currentExperiment];
    [self.map setDelegate:self];
    
    // ---- Setting Map Parameters ----
    
    self.map.zoomEnabled = NO;
    self.map.scrollEnabled = NO;
    self.map.pitchEnabled = NO;
    self.map.rotateEnabled = NO;
    self.map.showsBuildings = NO;
    self.map.showsUserLocation = NO;
    [self.map setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(39.828333,-77.232222), 10000, 10000)];
    
    // ---- Adding Symbols ----
    
    [self addSymbols];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self.map removeAnnotations:self.map.annotations];
    self.map = nil;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) addSymbols {
    
    CLLocationCoordinate2D minCoordinate = CLLocationCoordinate2DMake(39.76, -77.29);
    CLLocationCoordinate2D maxCoordinate = CLLocationCoordinate2DMake(39.89, -77.19);
    
    CLLocationDegrees deltaX = maxCoordinate.longitude - minCoordinate.longitude;
    CLLocationDegrees deltaY = maxCoordinate.latitude - minCoordinate.latitude;
    
    for (NSInteger i = 0; i <= [self.model.symbolsOnMap integerValue]; i++) {
        
        SYMPOLSymbolModel * symbol;
        CLLocationDegrees lat = ((double)arc4random() / ARC4RANDOM_MAX) * (deltaY) + minCoordinate.latitude;
        CLLocationDegrees lon = -((double)arc4random() / ARC4RANDOM_MAX) * (deltaX) + maxCoordinate.longitude;
        
        if (i < [self.model.symbolsOnMap integerValue]) {
            symbol = [self randomSymbol];
            
            while ([symbol.uid isEqualToString:self.model.targetSymbol.uid]) {
                symbol = [self randomSymbol];
            }
        } else {
            symbol = self.model.targetSymbol;
        }
        
        [symbol setCoordinate:CLLocationCoordinate2DMake(lat, lon)];
        [self.map addAnnotation:symbol];
    }
}

- (SYMPOLSymbolModel *) randomSymbol {
    NSArray * symbols = ([SYMPOLEvaluationModel sharedEvaluationModel]).symbols;
    SYMPOLSymbolModel * symbol = (SYMPOLSymbolModel *)[symbols objectAtIndex:(arc4random() % [symbols count])];
    return [symbol copy];
}

- (UIImage *) annoationImageFromSymbol:(SYMPOLSymbolModel *)symbol {
    float heightToWidthRatio = symbol.image.size.height / symbol.image.size.width;
    float scaleFactor = 1;
    
    if (heightToWidthRatio > 0) {
        scaleFactor = 24 / symbol.image.size.height;
    } else {
        scaleFactor = 24 / symbol.image.size.width;
    }
    
    CGSize newSize2 = CGSizeMake(24, 24);
    newSize2.width = symbol.image.size.width * scaleFactor;
    newSize2.height = symbol.image.size.height * scaleFactor;
    
    UIGraphicsBeginImageContext(newSize2);
    [symbol.image drawInRect:CGRectMake(0,0,newSize2.width,newSize2.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Map View Delegate Methods

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[SYMPOLSymbolModel class]]) {
        MKAnnotationView * view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"SymbolAnnotationView"];
        
        if (!view) {
            view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"SymbolAnnotationView"];
        }
        
        view.annotation = annotation;
        view.image = [self annoationImageFromSymbol:((SYMPOLSymbolModel *)annotation)];
        view.canShowCallout = NO;
        
        return view;
    }
    
    return nil;
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[SYMPOLSymbolModel class]]) {
        self.endTime = [NSDate date];
        self.model.elapsedTime = [NSNumber numberWithDouble:[self.endTime timeIntervalSinceDate:self.startTime]];
        self.model.selectedSymbol = (SYMPOLSymbolModel *)view.annotation;        
        [self performSegueWithIdentifier:SEGUE_TASK_SEARCH_CERTAINTY sender:self];
    }
}

- (void) mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    self.startTime = [NSDate date];
}

@end
