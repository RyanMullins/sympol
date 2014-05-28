//
//  SYMPOLTaskSearchCertaintyController.m
//  Sympol
//
//  Created by Ryan Mullins on 5/20/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLTaskSearchCertaintyController.h"
#import "SYMPOLTaskSearchModel.h"
#import "SYMPOLEvaluationModel.h"

@interface SYMPOLTaskSearchCertaintyController ()

@property (nonatomic) SYMPOLTaskSearchModel * model;

@end

@implementation SYMPOLTaskSearchCertaintyController
@synthesize certaintyLabel;
@synthesize certaintyTextField;
@synthesize submitButton;

- (void) viewDidLoad {
    [super viewDidLoad];
    self.model = (SYMPOLTaskSearchModel *)[[SYMPOLEvaluationModel sharedEvaluationModel] currentExperiment];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) submitAnswer:(id)sender {
    self.model.certainty = [NSNumber numberWithDouble:[[self.certaintyTextField text] doubleValue]];
    [self performSegueWithIdentifier:SEGUE_UNWIND_EVALUATION sender:self];
}

@end
