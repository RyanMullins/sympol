//
//  SYMPOLExperimentModel.m
//  Sympol
//
//  Created by Ryan Mullins on 5/14/14.
//  Copyright (c) 2014 org.ryanmullins. All rights reserved.
//

#import "SYMPOLEvaluationModel.h"
#import "SYMPOLComprehensionAssociationModel.h"
#import "SYMPOLTaskSearchModel.h"
#import "SYMPOLSymbolModel.h"

static SYMPOLEvaluationModel * evaluation = nil;

@interface SYMPOLEvaluationModel ()

@property (nonatomic, readwrite) NSArray * experiments;
@property (nonatomic, readwrite) NSArray * symbols;
@property (nonatomic, readwrite) NSDictionary * evaulationInfo;
@property (nonatomic, readwrite) id<SYMPOLExperiment> currentExperiment;
@property (nonatomic) NSMutableArray * results;
@property NSUInteger indexOfCurrentExperiment;

- (void) shuffle;

@end

@implementation SYMPOLEvaluationModel
@synthesize currentExperiment;
@synthesize evaulationInfo;
@synthesize experiments;
@synthesize indexOfCurrentExperiment;
@synthesize results;
@synthesize symbols;

#pragma mark - Instance Methods

- (BOOL) isLastExperiment {
    return (indexOfCurrentExperiment == ([self.experiments count] - 1));
}

- (NSDictionary *) resultsJSONObject {
    return @{@"evaluationInfo": self.evaulationInfo, @"results" : self.results};
}

- (void) experimentCompleted {
    [self.results addObject:[self.currentExperiment results]];
    
    if (!self.isLastExperiment) {
        self.indexOfCurrentExperiment++;
        self.currentExperiment = [self.experiments objectAtIndex:self.indexOfCurrentExperiment];
    }
}

- (void) reset {
    [self.results removeAllObjects];
    [self shuffle];
    self.indexOfCurrentExperiment = 0;
    self.currentExperiment = [self.experiments objectAtIndex:self.indexOfCurrentExperiment];
}

- (void) shuffle {
    NSInteger count = [self.experiments count];
    NSMutableArray * exps = [NSMutableArray arrayWithArray:self.experiments];
    
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [exps exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    self.experiments = [NSArray arrayWithArray:exps];
}

#pragma mark - Initialization

+ (id <SYMPOLExperiment>) experimentFromJSONObject:(NSDictionary *)json {
    id <SYMPOLExperiment> model;
    
    if ([[json objectForKey:@"type"] isEqualToString:@"ComprehensionAssociation"]) {
        model = [SYMPOLComprehensionAssociationModel modelFromJSONObject:json];
    }
    
    if ([[json objectForKey:@"type"] isEqualToString:@"TaskSearch"]) {
        model = [SYMPOLTaskSearchModel modelFromJSONObject:json];
    }
    
    return model;
}

+ (SYMPOLEvaluationModel *) evaluationFromJSONObject:(NSDictionary *)json {
    NSMutableArray * experimentModels = [[NSMutableArray alloc] init];
    NSMutableArray * symbolModels = [[NSMutableArray alloc] init];
    
    for (NSDictionary * experiment in [json objectForKey:@"experiments"]) {
        id <SYMPOLExperiment> experimentModel = [SYMPOLEvaluationModel experimentFromJSONObject:experiment];
        
        if (experimentModel) {
            [experimentModels addObject:experimentModel];
        }
    }
    
    for (NSDictionary * symbol in [json objectForKey:@"symbols"]) {
        SYMPOLSymbolModel * symbolModel = [SYMPOLSymbolModel symbolFromJSONObject:symbol];
        
        if (symbolModel) {
            [symbolModels addObject:symbolModel];
        }
    }
    
    evaluation = [[SYMPOLEvaluationModel alloc] init];
    evaluation.evaulationInfo = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[json objectForKey:@"evaluationInfo"]];
    evaluation.experiments = [NSArray arrayWithArray:experimentModels];
    evaluation.symbols = [[NSArray alloc] initWithArray:symbolModels];
    
    [evaluation shuffle];
    
    evaluation.indexOfCurrentExperiment = 0;
    evaluation.currentExperiment = [experimentModels objectAtIndex:evaluation.indexOfCurrentExperiment];
    evaluation.results = [[NSMutableArray alloc] init];
    
    return evaluation;
}

+ (SYMPOLEvaluationModel *) sharedEvaluationModel {
    return evaluation;
}

@end
