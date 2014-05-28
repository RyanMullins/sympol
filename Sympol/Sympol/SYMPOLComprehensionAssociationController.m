//
//  SYMPOLComprehensionAssociationController.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLComprehensionAssociationController.h"

@interface SYMPOLComprehensionAssociationController ()

@property (nonatomic) SYMPOLComprehensionAssociationModel * model;

@end

@implementation SYMPOLComprehensionAssociationController
@synthesize model;

#pragma mark - Initialization

- (void) viewDidLoad {
    [super viewDidLoad];
    self.model = (SYMPOLComprehensionAssociationModel *)[[SYMPOLEvaluationModel sharedEvaluationModel] currentExperiment];
    [self prepareNextSymbol];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Experiment Proceedures

- (IBAction) associateMeaning:(id)sender {
    self.model.meaning = self.meaningTextView.text;
    self.model.certainty = [NSNumber numberWithDouble:self.certaintyTextField.text.doubleValue];
    [self.model associateMeaning];
    
    if (self.model.isLastSymbol) {
        [self performSegueWithIdentifier:@"unwindToEvaluation" sender:self];
    } else {
        [self prepareNextSymbol];
    }
}

- (void) prepareNextSymbol {
    [self.model prepareNextSymbol];
    [self.symbolImageView setImage:self.model.symbol.image];
    [self.meaningTextView setText:@"What meaning would you associate with this symbol?"];
    [self.certaintyTextField setText:@""];
}

@end
