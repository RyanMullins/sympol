//
//  SYMPOLExperimentController.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLEvaluationController.h"
#import "SYMPOLComprehensionAssociationController.h"
#import "SYMPOLTaskSearchController.h"

#import "SYMPOLComprehensionAssociationModel.h"
#import "SYMPOLTaskSearchModel.h"

@interface SYMPOLEvaluationController ()

@property (nonatomic) SYMPOLEvaluationModel * evaluation;
@property BOOL hasEvaluationStarted;

@end

@implementation SYMPOLEvaluationController
@synthesize evaluation;
@synthesize hasEvaluationStarted;

#pragma mark - UIViewController Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (!self.hasEvaluationStarted) {
        [self defaultTitlesAndDirections];
    }
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue Methods

- (void) performSegueForCurrentExperiment {
    if ([self.evaluation.currentExperiment isKindOfClass:[SYMPOLComprehensionAssociationModel class]]) {
        [self performSegueWithIdentifier:SEGUE_COMPREHENSION_ASSOCIATION sender:self];
    }
    
    if ([self.evaluation.currentExperiment isKindOfClass:[SYMPOLTaskSearchModel class]]) {
        [self performSegueWithIdentifier:SEGUE_TASK_SEARCH sender:self];
    }
}

- (IBAction) progressExperiment:(id)sender {
    if (!self.hasEvaluationStarted) {
        self.hasEvaluationStarted = YES;
        [self updateTitlesAndDirections];
    } else {
        [self performSegueForCurrentExperiment];
    }
}

- (IBAction) unwindToEvaluation:(UIStoryboardSegue *)sender {
    [self.evaluation experimentCompleted];
    
    if (self.evaluation.isLastExperiment) {
        if ([MFMailComposeViewController canSendMail]) {
            NSString * subject = [NSString stringWithFormat:@"Completed Evaluation - %@",
                                  [self.evaluation.evaulationInfo objectForKey:@"title"]];
            NSString * message = @"Thank you for participating in this study. Please press the \"send\" button to end the evaluation and send the results away for analysis.";
            NSString * filename = [NSString stringWithFormat:@"Results for %@ - %@",
                                   [self.evaluation.evaulationInfo objectForKey:@"title"],
                                   [NSDate date]];
            NSData * results = [NSJSONSerialization dataWithJSONObject:[self.evaluation resultsJSONObject] options:NSJSONWritingPrettyPrinted error:nil];
            
            MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc] init];
            [mailController setMailComposeDelegate:self];
            [mailController setToRecipients:@[[self.evaluation.evaulationInfo objectForKey:@"email"]]];
            [mailController setSubject:subject];
            [mailController setMessageBody:message isHTML:NO];
            [mailController addAttachmentData:results mimeType:@"application/json" fileName:filename];
        } else  {
            // TODO: Implement File (iCloud?) Syncing
        }
    } else {
        [self updateTitlesAndDirections];
    }
}

#pragma mark - Evaluation and Experiment Intinitialization

- (void) setupEvaluation {
    NSString * configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSData * configData = [[NSData alloc] initWithContentsOfFile:configPath];
    NSDictionary * configuration = [NSJSONSerialization JSONObjectWithData:configData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
    self.evaluation = [SYMPOLEvaluationModel evaluationFromJSONObject:configuration];
}

- (void) setupEvaluationWithConfigAtURL:(NSString *)configPath {
    NSURL * configURL = [NSURL URLWithString:configPath];
    NSData * configData = [[NSData alloc] initWithContentsOfURL:configURL];
    NSDictionary * configuration = [NSJSONSerialization JSONObjectWithData:configData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
    self.evaluation = [SYMPOLEvaluationModel evaluationFromJSONObject:configuration];
}

- (void) updateTitlesAndDirections {
    [self.experimentTitleLabel setText:self.evaluation.currentExperiment.title];
    [self.experimentTitleLabel setTextColor:[UIColor whiteColor]];
    [self.directionsTextField setText:self.evaluation.currentExperiment.directions];
    [self.directionsTextField setTextColor:[UIColor whiteColor]];
    [self.progressButton setTitle:@"Start Experiment" forState:UIControlStateNormal];
    [self.progressButton setTitle:@"Start Experiment" forState:UIControlStateHighlighted];
    [self.progressButton setTitle:@"Start Experiment" forState:UIControlStateSelected];
}

- (void) defaultTitlesAndDirections {
    [self.experimentTitleLabel setText:[self.evaluation.evaulationInfo objectForKey:@"title"]];
    [self.experimentTitleLabel setTextColor:[UIColor whiteColor]];
    [self.directionsTextField setText:[self.evaluation.evaulationInfo objectForKey:@"description"]];
    [self.directionsTextField setTextColor:[UIColor whiteColor]];
    [self.progressButton setTitle:@"Begin Evaluation" forState:UIControlStateNormal];
    [self.progressButton setTitle:@"Begin Evaluation" forState:UIControlStateHighlighted];
    [self.progressButton setTitle:@"Begin Evaluation" forState:UIControlStateSelected];
}

#pragma mark - MFMailComposeViewControllerDelegate Methods

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error {
    if (result == MFMailComposeResultSent) {
        self.hasEvaluationStarted = NO;
        [self.evaluation reset];
        [self defaultTitlesAndDirections];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
