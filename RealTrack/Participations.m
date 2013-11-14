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

-(void)setDate:(NSDate *)date menUnder15:(NSNumber *)menUnder15 men15To24:(NSNumber *)men15To24 menAvove24:(NSNumber *)menAbove24 womenUnder15:(NSNumber *)womenUnder15 women15To24:(NSNumber *)women15To24 womenAbove24:(NSNumber *)womenAbove24 notes:(NSString *)notes activity:(Activities*) act
{
    self.date = date;
    self.men_under_15 = menUnder15;
    self.men_15_to_24 = men15To24;
    self.men_above_24 = menAbove24;
    self.women_under_15 = womenUnder15;
    self.women_15_to_24 = women15To24;
    self.women_above_24 = womenAbove24;
    self.notes = notes;
    self.activity = act;
    [act addParticipationsObject:self];
}

@end
