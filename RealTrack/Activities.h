//
//  Activities.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/28/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Participations, Projects;

@interface Activities : NSManagedObject

@property (nonatomic, retain) NSString * activity_name;
@property (nonatomic, retain) NSDate * end_date;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSSet *participations;
@property (nonatomic, retain) Projects *project;
@end

@interface Activities (CoreDataGeneratedAccessors)

- (void)addParticipationsObject:(Participations *)value;
- (void)removeParticipationsObject:(Participations *)value;
- (void)addParticipations:(NSSet *)values;
- (void)removeParticipations:(NSSet *)values;

@end
