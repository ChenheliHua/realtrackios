//
//  Participations.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activities;

@interface Participations : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * men_15_to_24;
@property (nonatomic, retain) NSNumber * men_above_24;
@property (nonatomic, retain) NSNumber * men_under_15;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * women_15_to_24;
@property (nonatomic, retain) NSNumber * women_above_24;
@property (nonatomic, retain) NSNumber * women_under_15;
@property (nonatomic, retain) Activities *activity;

// Retrieve data with specified predicate and sort descriptor. Pass nil to skip predicate and/or sort descriptor
+(NSArray*)retrieveParticipationWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort;

-(void)setDate:(NSDate *)date menUnder15:(int)menUnder15 men15To24:(int)men15To24 menAvove24:(int)menAbove24 womenUnder15:(int)womenUnder15 women15To24:(int)women15To24 womenAbove24:(int)womenAbove24 notes:(NSString *)notes activity:(Activities*) act;

@end
