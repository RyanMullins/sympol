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

@interface SYMPOLSymbolModel : NSObject <NSCopying, MKAnnotation>

@property (nonatomic) UIImage * image;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (NSString *) author;
- (NSString *) created;
- (NSString *) imagePath;
- (NSString *) keywords;
- (NSString *) license;
- (NSString *) meaning;
- (NSString *) name;
- (NSString *) symbolSet;
- (NSString *) uid;

- (id) copyWithZone:(NSZone *)zone;

+ (SYMPOLSymbolModel *) symbolFromJSONObject:(NSDictionary *) json;
+ (NSDictionary *) JSONObjectFromSymbol:(SYMPOLSymbolModel *) symbol;

@end
