//
//  SYMPOLExperimentController.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

@import Foundation;
@import MessageUI;

#import "SYMPOLEvaluationModel.h"

@interface SYMPOLEvaluationController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic) IBOutlet UIButton * progressButton;
@property (nonatomic) IBOutlet UILabel * experimentTitleLabel;
@property (nonatomic) IBOutlet UITextView * directionsTextField;

- (IBAction) progressExperiment:(id)sender;
- (IBAction) unwindToEvaluation:(UIStoryboardSegue *)segue;
- (void) setupEvaluation;
- (void) setupEvaluationWithConfigAtURL:(NSString *) configPath;

@end
