//
//  SYMPOLSearchTaskModel.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYMPOLTaskProtocol.h"

@interface SYMPOLTaskSearchModel : NSObject <SYMPOLTask>

@property (nonatomic) SYMPOLSymbolModel * selectedSymbol;
@property (nonatomic) NSNumber * elapsedTime;
@property (nonatomic) NSNumber * symbolsOnMap;

@end
