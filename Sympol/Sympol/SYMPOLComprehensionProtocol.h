//
//  SYMPOLExperimentComprehensionProtocol.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYMPOLExperimentProtocol.h"
#import "SYMPOLSymbolModel.h"

@protocol SYMPOLComprehensionProtocol <SYMPOLExperimentProtocol>

@property (nonatomic) SYMPOLSymbolModel * symbol;
@property (nonatomic) NSString * meaning;

@end
