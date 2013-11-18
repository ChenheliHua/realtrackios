//
//  Projects.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "Projects.h"
#import "Activities.h"

@implementation Projects

@dynamic end_date;
@dynamic notes;
@dynamic project_name;
@dynamic start_date;
@dynamic activities;

+(NSArray*)retrieveProjectsWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort
{
    // Fetch all data
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * managedObjectContext= [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entDes = [NSEntityDescription entityForName:@"Projects" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entDes];
    
    // Set predicate and sortDescriptors
    if(pred!=nil)
        [fetchRequest setPredicate:pred];
    if(sort!=nil)
        [fetchRequest setSortDescriptors:@[sort]];
    
    NSError *err;

    return [managedObjectContext executeFetchRequest:fetchRequest error:&err];
}

-(void)setName:(NSString*)name startDate:(NSDate *) startDate endDate:(NSDate *)endDate notes:(NSString *)notes
{
    self.project_name = name;
    self.start_date = startDate;
    self.end_date = endDate;
    self.notes = notes;
}

@end
