//
//  Projects.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RTAppDelegate.h"

@class Activities;

@interface Projects : NSManagedObject

@property (nonatomic, retain) NSDate * end_date;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * project_name;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSSet *activities;
@end

@interface Projects (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(Activities *)value;
- (void)removeActivitiesObject:(Activities *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

// Retrieve data with specified predicate and sort descriptor. Pass nil to skip predicate and/or sort descriptor
+(NSArray*)retrieveProjectsWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort;

-(void)setName:(NSString*)name startDate:(NSDate *) startDate endDate:(NSDate *)endDate notes:(NSString *)notes;

@end
