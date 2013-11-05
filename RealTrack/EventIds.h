//
//  EventIds.h
//  RealTrack
//
//  Created by Chenheli Hua on 11/5/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activities;

@interface EventIds : NSManagedObject

@property (nonatomic, retain) NSString * event_id;
@property (nonatomic, retain) Activities *activity;

@end
