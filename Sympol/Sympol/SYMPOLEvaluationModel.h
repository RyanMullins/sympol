//
//  SYMPOLExperimentModel.h
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

@import Foundation;

#import "SYMPOLExperimentProtocol.h"

@interface SYMPOLEvaluationModel : NSObject

@property (nonatomic, readonly) NSArray * experiments;
@property (nonatomic, readonly) NSArray * symbols;
@property (nonatomic, readonly) NSDictionary * evaulationInfo;
@property (nonatomic, readonly) id<SYMPOLExperiment> currentExperiment;

+ (SYMPOLEvaluationModel *) evaluationFromJSONObject:(NSDictionary *)json;
+ (SYMPOLEvaluationModel *) sharedEvaluationModel;

- (BOOL) isLastExperiment;
- (NSDictionary *) resultsJSONObject;
- (void) experimentCompleted;
- (void) reset;

@end
