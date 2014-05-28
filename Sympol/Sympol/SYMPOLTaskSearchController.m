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
    [self.map addAnnotations:[self.model symbols]];
    [self.map addAnnotation:self.model.targetSymbol];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Map View Delegate Methods

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[SYMPOLSymbolModel class]]) {
        MKAnnotationView * view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"SymbolAnnotationView"];
        
        if (!view) {
            view = [[MKAnnotationView alloc] init];
        }
        
        view.annotation = annotation;
        view.image = ((SYMPOLSymbolModel *)annotation).image;
        view.canShowCallout = NO;
        
        return view;
    }
    
    return nil;
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[SYMPOLSymbolModel class]]) {
        self.endTime = [NSDate date];
        self.model.elapsedTime = [NSNumber numberWithDouble:[self.endTime timeIntervalSinceDate:self.startTime]];
        self.model.selectedSymbol = view.annotation;
        [self performSegueWithIdentifier:SEGUE_TASK_SEARCH_CERTAINTY sender:self];
    }
}

- (void) mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    self.startTime = [NSDate date];
}

@end
