//
//  Projects.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/28/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

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

@end
