//
//  SYMPOLComprehensionAssociationModel.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLComprehensionAssociationModel.h"
#import "SYMPOLSymbolModel.h"

@interface SYMPOLComprehensionAssociationModel ()

@property (nonatomic) NSArray * symbols;
@property (nonatomic) NSMutableArray * associations;
@property NSUInteger symbolIndex;

@end

@implementation SYMPOLComprehensionAssociationModel
@synthesize associations;
@synthesize certainty;
@synthesize directions;
@synthesize meaning;
@synthesize symbol;
@synthesize symbolIndex;
@synthesize symbols;
@synthesize title;
@synthesize type;

- (BOOL) isLastSymbol {
    return (self.symbolIndex == ([self.symbols count] - 1));
}

- (void) associateMeaning {
    [self.associations addObject:@{
        @"symbol" : [SYMPOLSymbolModel JSONObjectFromSymbol:self.symbol],
        @"meaning" : self.meaning,
        @"certainty" : self.certainty
    }];
}

- (void) prepareNextSymbol {
    if (!self.isLastSymbol) {
        self.symbolIndex++;
        self.symbol = [self.symbols objectAtIndex:self.symbolIndex];
    }
}

#pragma mark - Experiment Protocol Methods

- (void) reset {
    self.symbol = nil;
    self.symbolIndex = -1;
    [self.associations removeAllObjects];
}

- (NSDictionary *) results {
    return @{
        @"type" : self.type,
        @"associations" : self.associations
    };
}

+ (id) modelFromJSONObject:(NSDictionary *)json {
    SYMPOLComprehensionAssociationModel * model = [[SYMPOLComprehensionAssociationModel alloc] init];
    
    if (model) {
        NSMutableArray * tempSymbols = [[NSMutableArray alloc] init];
        
        for (NSDictionary * symbol in [json objectForKey:@"symbols"]) {
            [tempSymbols addObject:[SYMPOLSymbolModel symbolFromJSONObject:symbol]];
        }
        
        model.associations = [[NSMutableArray alloc] init];
        model.directions = [json objectForKey:@"directions"];
        model.symbolIndex = -1;
        model.symbols = [[NSArray alloc] initWithArray:tempSymbols];
        model.title = ([json objectForKey:@"title"] ? [json objectForKey:@"title"] : @"Associating a Meaning");
        model.type = @"ComprehensionAssociation";
    }
    
    return model;
}

@end
