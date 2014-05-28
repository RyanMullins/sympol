//
//  SYMPOLSymbolModel.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

@import Foundation;
@import CoreLocation;
@import MapKit;

@interface SYMPOLSymbolModel : NSObject <MKAnnotation>

@property (nonatomic) NSString * author;
@property (nonatomic) NSString * created;
@property (nonatomic) NSString * imagePath;
@property (nonatomic) NSString * keywords;
@property (nonatomic) NSString * license;
@property (nonatomic) NSString * meaning;
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * set;
@property (nonatomic) NSString * uid;
@property (nonatomic) UIImage * image;

+ (SYMPOLSymbolModel *) symbolFromJSONObject:(NSDictionary *) json;
+ (NSDictionary *) JSONObjectFromSymbol:(SYMPOLSymbolModel *) symbol;

@end
