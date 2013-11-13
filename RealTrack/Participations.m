//
//  Participations.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "Participations.h"
#import "Activities.h"


@implementation Participations

@dynamic date;
@dynamic men_15_to_24;
@dynamic men_above_24;
@dynamic men_under_15;
@dynamic notes;
@dynamic women_15_to_24;
@dynamic women_above_24;
@dynamic women_under_15;
@dynamic activity;

+(NSArray*)retrieveParticipationWithPredicate:(NSPredicate *)pred andSortDescriptor:(NSSortDescriptor *)sort
{
    // Fetch all data
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * managedObjectContext= [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entDes = [NSEntityDescription entityForName:@"Participations" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entDes];
    
    // Set predicate and sortDescriptors
    if(pred!=nil)
        [fetchRequest setPredicate:pred];
    if(sort!=nil)
        [fetchRequest setSortDescriptors:@[sort]];
    
    NSError *err;
    
    return [managedObjectContext executeFetchRequest:fetchRequest error:&err];
}

-(void)setDate:(NSDate *)date menUnder15:(int)menUnder15 men15To24:(int)men15To24 menAvove24:(int)menAbove24 womenUnder15:(int)womenUnder15 women15To24:(int)women15To24 womenAbove24:(int)womenAbove24 notes:(NSString *)notes activity:(Activities*) act
{
    return;
}

@end
