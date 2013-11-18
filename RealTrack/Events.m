//
//  Events.m
//  RealTrack
//
//  Created by Chenheli Hua on 11/5/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "Events.h"
#import "Activities.h"

@implementation Events

@dynamic event_id;
@dynamic activity;

+(NSArray*)retrieveEventsWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort
{
    // Fetch all data
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * managedObjectContext= [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entDes = [NSEntityDescription entityForName:@"Events" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entDes];
    
    // Set predicate and sortDescriptors
    if(pred!=nil)
        [fetchRequest setPredicate:pred];
    if(sort!=nil)
        [fetchRequest setSortDescriptors:@[sort]];
    
    NSError *err;
    
    return [managedObjectContext executeFetchRequest:fetchRequest error:&err];
}

-(void)setID:(NSString *)eventId activity:(Activities *)act
{
    self.event_id = eventId;
    self.activity = act;
}

@end
