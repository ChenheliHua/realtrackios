//
//  Activities.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/17/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Projects.h"

@interface Activities : NSManagedObject

@property (nonatomic, retain) NSString * activity_name;
@property (nonatomic, retain) Projects *project;
@property (nonatomic, retain) NSSet *participations;
@end

@interface Activities (CoreDataGeneratedAccessors)

- (void)addParticipationsObject:(NSManagedObject *)value;
- (void)removeParticipationsObject:(NSManagedObject *)value;
- (void)addParticipations:(NSSet *)values;
- (void)removeParticipations:(NSSet *)values;

@end
