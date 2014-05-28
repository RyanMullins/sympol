//
//  SYMPOLExperimentTaskProtocol.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYMPOLExperimentProtocol.h"
#import "SYMPOLSymbolModel.h"

@protocol SYMPOLTaskProtocol <SYMPOLExperimentProtocol>

@property (nonatomic) NSArray * symbols;
@property (nonatomic) SYMPOLSymbolModel * targetSymbol;

@end
