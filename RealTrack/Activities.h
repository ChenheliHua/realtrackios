//
//  Activities.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>
#import "EventIds.h"
#import "RTAppDelegate.h"

@class Participations, Projects, EventIds;

@interface Activities : NSManagedObject

@property (nonatomic, retain) NSString * activity_name;
@property (nonatomic, retain) NSDate * end_date;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSString * organizations;
@property (nonatomic, retain) NSString * communities;
@property (nonatomic, retain) NSNumber * ecpa;
@property (nonatomic, retain) NSNumber * food_security;
@property (nonatomic, retain) NSNumber * malaria;
@property (nonatomic, retain) NSNumber * youth;
@property (nonatomic, retain) NSNumber * wid;
@property (nonatomic, retain) NSNumber * mon;
@property (nonatomic, retain) NSDate * mon_time;
@property (nonatomic, retain) NSNumber * tue;
@property (nonatomic, retain) NSDate * tue_time;
@property (nonatomic, retain) NSNumber * wed;
@property (nonatomic, retain) NSDate * wed_time;
@property (nonatomic, retain) NSNumber * thu;
@property (nonatomic, retain) NSDate * thu_time;
@property (nonatomic, retain) NSNumber * fri;
@property (nonatomic, retain) NSDate * fri_time;
@property (nonatomic, retain) NSNumber * sat;
@property (nonatomic, retain) NSDate * sat_time;
@property (nonatomic, retain) NSNumber * sun;
@property (nonatomic, retain) NSDate * sun_time;
@property (nonatomic, retain) NSSet *participations;
@property (nonatomic, retain) Projects *project;
@property (nonatomic, retain) NSMutableSet *event_ids;

@end

@interface Activities (CoreDataGeneratedAccessors)

- (void)addParticipationsObject:(Participations *)value;
- (void)removeParticipationsObject:(Participations *)value;
- (void)addParticipations:(NSSet *)values;
- (void)removeParticipations:(NSSet *)values;
- (void)addEventIdsObject:(EventIds *)value;
- (void)removeEventIdsObject:(EventIds *)value;
- (void)addEventIds:(NSSet *)values;
- (void)removeEventIds:(NSSet *)values;


// For add/edit activity
-(void)toggleWeekday:(NSInteger)day withBool:(BOOL)val;
-(void)setWeekday:(NSInteger)day withTime:(NSDate*)time;

-(BOOL)getWeekdayBool:(NSInteger)day;
-(NSDate*)getTimeOnWeekday:(NSInteger)day;

// For Event Kit
-(void)addActivityEvent;
-(void)updateActivityEvent;
-(void)deleteActivityEvent;

// Retrieve data with specified predicate and sort descriptor. Pass nil to skip predicate and/or sort descriptor
+(NSArray*)retrieveActivitiesWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort;

-(void)setName:(NSString *)name startDate:(NSDate *)startDate endDate:(NSDate *)endDate organizatons:(NSString *)orgs communities:(NSString *)comms ecpa:(BOOL)ecpa foodSecurity:(BOOL)foodSecurity malaria:(BOOL)malaria youth:(BOOL)youth wid:(BOOL)wid monTime:(NSDate *)mon tueTime:(NSDate *)tue wed:(NSDate *)wed thu:(NSDate *)thu fri:(NSDate *)fri sat:(NSDate*)sat sun:(NSDate *)sun project:(Projects *)proj;

@end
