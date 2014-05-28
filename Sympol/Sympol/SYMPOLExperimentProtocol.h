//
//  SYMPOLExperimentProtocol.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SYMPOLExperimentProtocol <NSObject>

@property (nonatomic) NSNumber * certainty;
@property (nonatomic) NSString * directions;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * type;

+ (id) modelFromJSONObject:(NSDictionary *)json;

- (NSDictionary *) results;
- (void) reset;

@end
