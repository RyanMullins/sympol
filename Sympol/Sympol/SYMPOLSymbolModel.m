//
//  SYMPOLSymbolModel.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLSymbolModel.h"

@implementation SYMPOLSymbolModel
@synthesize author;         // Symbol Model Properties
@synthesize created;
@synthesize image;
@synthesize imagePath;
@synthesize keywords;
@synthesize license;
@synthesize meaning;
@synthesize name;
@synthesize set;
@synthesize uid;
@synthesize coordinate;     // MKAnnotation Properties
@synthesize title;
@synthesize subtitle;

+ (SYMPOLSymbolModel *) symbolFromJSONObject:(NSDictionary *)json {
    SYMPOLSymbolModel * symbol = [[SYMPOLSymbolModel alloc] init];
    
    if (symbol) {
        symbol.author = ([json objectForKey:SYMBOL_KEY_AUTHOR] ? [json objectForKey:SYMBOL_KEY_AUTHOR] : @"");
        symbol.created = ([json objectForKey:SYMBOL_KEY_CREATED] ? [json objectForKey:SYMBOL_KEY_CREATED] : @"");
        symbol.imagePath = ([json objectForKey:SYMBOL_KEY_IMAGEPATH] ? [json objectForKey:SYMBOL_KEY_IMAGEPATH] : @"");
        symbol.keywords = ([json objectForKey:SYMBOL_KEY_KEYWORDS] ? [json objectForKey:SYMBOL_KEY_KEYWORDS] : @"");
        symbol.license = ([json objectForKey:SYMBOL_KEY_LICENSE] ? [json objectForKey:SYMBOL_KEY_LICENSE] : @"");
        symbol.meaning = ([json objectForKey:SYMBOL_KEY_MEANING] ? [json objectForKey:SYMBOL_KEY_MEANING] : @"");
        symbol.name = ([json objectForKey:SYMBOL_KEY_NAME] ? [json objectForKey:SYMBOL_KEY_NAME] : @"");
        symbol.set = ([json objectForKey:SYMBOL_KEY_SET] ? [json objectForKey:SYMBOL_KEY_SET] : @"");
        symbol.uid = ([json objectForKey:SYMBOL_KEY_UID] ? [json objectForKey:SYMBOL_KEY_UID] : @"");
        
        if (symbol.imagePath && symbol.imagePath.length > 0) {
            NSURL * imageURL = [NSURL URLWithString:symbol.imagePath];
            NSData * imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
            symbol.image = [[UIImage alloc] initWithData:imageData];
        }
    }
    
    return symbol;
}

+ (NSDictionary *) JSONObjectFromSymbol:(SYMPOLSymbolModel *)symbol {
    return @{
        SYMBOL_KEY_AUTHOR: symbol.author,
        SYMBOL_KEY_CREATED : symbol.created,
        SYMBOL_KEY_IMAGEPATH : symbol.imagePath,
        SYMBOL_KEY_KEYWORDS : symbol.keywords,
        SYMBOL_KEY_LICENSE : symbol.license,
        SYMBOL_KEY_MEANING : symbol.meaning,
        SYMBOL_KEY_NAME : symbol.name,
        SYMBOL_KEY_SET : symbol.set,
        SYMBOL_KEY_UID : symbol.uid
    };
}

@end
