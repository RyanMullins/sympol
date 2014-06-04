//
//  SYMPOLComprehensionAssociationModel.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

@import Foundation;

#import "SYMPOLComprehensionProtocol.h"

@interface SYMPOLComprehensionAssociationModel : NSObject <SYMPOLComprehension>

- (BOOL) isLastSymbol;
- (void) associateMeaning;
- (void) prepareNextSymbol;

@end
