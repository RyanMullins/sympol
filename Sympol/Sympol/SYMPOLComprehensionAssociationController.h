//
//  SYMPOLComprehensionAssociationController.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYMPOLEvaluationModel.h"
#import "SYMPOLComprehensionAssociationModel.h"

@interface SYMPOLComprehensionAssociationController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic) IBOutlet UIButton * submitButton;
@property (nonatomic) IBOutlet UILabel * rangeLabel;
@property (nonatomic) IBOutlet UIImageView * symbolImageView;
@property (nonatomic) IBOutlet UITextField * certaintyTextField;
@property (nonatomic) IBOutlet UITextView * meaningTextView;

- (IBAction) associateMeaning:(id)sender;

@end
