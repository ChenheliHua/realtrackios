//
//  Events.h
//  RealTrack
//
//  Created by Chenheli Hua on 11/5/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class Activities;

@interface Events : NSManagedObject

@property (nonatomic, retain) NSString * event_id;
@property (nonatomic, retain) Activities *activity;

// Retrieve data with specified predicate and sort descriptor. Pass nil to skip predicate and/or sort descriptor
+(NSArray*)retrieveEventsWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort;

-(void)setID:(NSString *)id activity:(Activities *)act;

@end
