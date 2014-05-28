//
//  SYMPOLTaskSearchCertaintyController.h
//  Sympol
//
//  Created by Ryan Mullins on 5/20/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYMPOLTaskSearchCertaintyController : UIViewController

@property (nonatomic) IBOutlet UIButton * submitButton;
@property (nonatomic) IBOutlet UILabel * certaintyLabel;
@property (nonatomic) IBOutlet UITextField * certaintyTextField;

- (IBAction) submitAnswer:(id)sender;

@end
