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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) adjustViewWithOffset:(NSInteger)offset {
    CGRect frame = self.view.frame;
    frame.origin.y -= offset;
    frame.size.height += offset;
    self.view.frame = frame;
}

- (NSInteger) viewOriginOffset:(id)sender {
    if (sender) {
        UIView * senderView = (UIView *)sender;
        return senderView.frame.origin.y - 50;
    }
    
    return 0;
}

#pragma mark - Experiment Proceedures

- (IBAction) associateMeaning:(id)sender {
    self.model.meaning = self.meaningTextView.text;
    self.model.certainty = [NSNumber numberWithFloat:[self.certaintySlider value]];
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
    [self.certaintySlider setValue:3.0];
}

#pragma mark - UITextField Delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView Delegate Methods

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    if (textView == self.meaningTextView) {
        [self adjustViewWithOffset:[self viewOriginOffset:textView]];
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    if (textView == self.meaningTextView) {
        [self adjustViewWithOffset:-[self viewOriginOffset:textView]];
    }
}

@end
