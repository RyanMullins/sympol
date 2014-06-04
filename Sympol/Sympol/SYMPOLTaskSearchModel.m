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
@synthesize selectedSymbol;
@synthesize symbolsOnMap;
@synthesize targetSymbol;
@synthesize title;
@synthesize type;

#pragma mark - Experiment Protocol Methods

+ (id) modelFromJSONObject:(NSDictionary *)json {
    SYMPOLTaskSearchModel * model = [[SYMPOLTaskSearchModel alloc] init];
    
    if (model) {
        model.directions = [json objectForKey:@"directions"];
        model.symbolsOnMap = [json objectForKey:@"symbolsOnMap"];
        model.targetSymbol = [SYMPOLSymbolModel symbolFromJSONObject:[json objectForKey:@"targetSymbol"]];
        model.title = @"Search for a Symbol";
        model.type = @"TaskSearch";
    }
    
    return model;
}

- (NSDictionary *) results {
    
    NSLog(@"INFO: Target Symbol = %@", [SYMPOLSymbolModel JSONObjectFromSymbol:self.targetSymbol]);
    NSLog(@"INFO: Selected Symbol = %@", [SYMPOLSymbolModel JSONObjectFromSymbol:self.selectedSymbol]);
    
    return @{
        @"type": self.type,
        @"targetSymbol" : [SYMPOLSymbolModel JSONObjectFromSymbol:self.targetSymbol],
        @"selectedSymbol" : [SYMPOLSymbolModel JSONObjectFromSymbol:self.selectedSymbol],
        @"certainty" : self.certainty,
        @"elapsedTime" : self.elapsedTime
    };
}

- (void) reset {
    self.certainty = nil;
    self.elapsedTime = nil;
    self.selectedSymbol = nil;
}

@end
