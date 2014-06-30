//
//  SYMPOLSymbolModel.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLSymbolModel.h"

@interface SYMPOLSymbolModel ()

@property (nonatomic) NSDictionary * symbolData;

@end

@implementation SYMPOLSymbolModel
@synthesize symbolData;
@synthesize coordinate;     // MKAnnotation Properties
@synthesize title;
@synthesize subtitle;

- (NSString *) author {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_AUTHOR];
}

- (NSString *) created {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_CREATED];
}

- (NSString *) imagePath {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_IMAGEPATH];
}

- (NSString *) keywords {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_KEYWORDS];
}

- (NSString *) license {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_LICENSE];
}

- (NSString *) meaning {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_MEANING];
}

- (NSString *) name {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_NAME];
}

- (NSString *) symbolSet {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_SET];
}

- (NSString *) uid {
    return (NSString *)[self.symbolData objectForKey:SYMBOL_KEY_UID];
}

- (id) copyWithZone:(NSZone *)zone {
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        [copy setSymbolData:[self.symbolData copy]];
        [copy setImage:self.image];
    }
    
    return copy;
}

+ (SYMPOLSymbolModel *) symbolFromJSONObject:(NSDictionary *)json {
    SYMPOLSymbolModel * symbol = [[SYMPOLSymbolModel alloc] init];
    
    if (symbol) {
        symbol.symbolData = json;
        
        if ([symbol imagePath] && [symbol imagePath].length > 0) {
            NSURL * imageURL = [NSURL URLWithString:symbol.imagePath];
            NSData * imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
            symbol.image = [[UIImage alloc] initWithData:imageData];
        }
    }
    
    return symbol;
}

+ (NSDictionary *) JSONObjectFromSymbol:(SYMPOLSymbolModel *)symbol {
    return symbol.symbolData;
}

@end
