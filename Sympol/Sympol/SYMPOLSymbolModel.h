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

@property (nonatomic) NSString * author;
@property (nonatomic) NSString * created;
@property (nonatomic) NSString * imagePath;
@property (nonatomic) NSString * keywords;
@property (nonatomic) NSString * license;
@property (nonatomic) NSString * meaning;
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * symbolSet;
@property (nonatomic) NSString * uid;
@property (nonatomic) UIImage * image;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id) copyWithZone:(NSZone *)zone;

+ (SYMPOLSymbolModel *) symbolFromJSONObject:(NSDictionary *) json;
+ (NSDictionary *) JSONObjectFromSymbol:(SYMPOLSymbolModel *) symbol;

@end
