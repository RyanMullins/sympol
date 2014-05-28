//
//  SYMPOLSearchTaskModel.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLTaskSearchModel.h"

@implementation SYMPOLTaskSearchModel
@synthesize certainty;
@synthesize directions;
@synthesize elapsedTime;
@synthesize symbols;
@synthesize targetSymbol;
@synthesize title;
@synthesize type;

#pragma mark - Experiment Protocol Mehtods

+ (id) modelFromJSONObject:(NSDictionary *)json {
    SYMPOLTaskSearchModel * model = [[SYMPOLTaskSearchModel alloc] init];
    
    if (model) {
        
    }
    
    return model;
}

- (NSDictionary *) results {
    return @{
        @"type": @"TaskSearch",
        @"targetSymbol" : [SYMPOLSymbolModel JSONObjectFromSymbol:self.targetSymbol],
        @"selectedSymbol" : [SYMPOLSymbolModel JSONObjectFromSymbol:self.selectedSymbol],
        @"elapsedTime" : self.elapsedTime
    };
}

- (void) reset {
    
}

@end
