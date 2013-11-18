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
#import "Projects.h"
#import "Participations.h"
#import "Events.h"
#import "RTAppDelegate.h"

@class Participations, Projects, Events;

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
@property (nonatomic, retain) NSDate * mon_time;
@property (nonatomic, retain) NSDate * tue_time;
@property (nonatomic, retain) NSDate * wed_time;
@property (nonatomic, retain) NSDate * thu_time;
@property (nonatomic, retain) NSDate * fri_time;
@property (nonatomic, retain) NSDate * sat_time;
@property (nonatomic, retain) NSDate * sun_time;
@property (nonatomic, retain) NSSet *participations;
@property (nonatomic, retain) Projects *project;
@property (nonatomic, retain) NSMutableSet *events;

@end

@interface Activities (CoreDataGeneratedAccessors)

- (void)addParticipationsObject:(Participations *)value;
- (void)removeParticipationsObject:(Participations *)value;
- (void)addParticipations:(NSSet *)values;
- (void)removeParticipations:(NSSet *)values;
- (void)addEventsObject:(Events *)value;
- (void)removeEventsObject:(Events *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;


// For add/edit activity
// Pass nill to withTime to turn off the weekday reminder
-(void)setWeekday:(NSInteger)day withTime:(NSDate*)time;

// Returns nil if the weekday is turned off
-(NSDate*)getTimeOnWeekday:(NSInteger)day;

// For Event Kit
-(void)addActivityEvent;
-(void)updateActivityEvent;
-(void)deleteActivityEvent;

// Retrieve data with specified predicate and sort descriptor. Pass nil to skip predicate and/or sort descriptor
+(NSArray*)retrieveActivitiesWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort;

-(void)setName:(NSString *)name startDate:(NSDate *)startDate endDate:(NSDate *)endDate organizatons:(NSString *)orgs communities:(NSString *)comms ecpa:(BOOL)ecpa foodSecurity:(BOOL)foodSecurity malaria:(BOOL)malaria youth:(BOOL)youth wid:(BOOL)wid project:(Projects *)proj notes:(NSString *)notes;

@end
