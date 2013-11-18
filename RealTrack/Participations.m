//
//  Participations.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "Participations.h"

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

// Pass nil for 0 participants
-(void)setDate:(NSDate *)date menUnder15:(NSNumber *)menUnder15 men15To24:(NSNumber *)men15To24 menAvove24:(NSNumber *)menAbove24 womenUnder15:(NSNumber *)womenUnder15 women15To24:(NSNumber *)women15To24 womenAbove24:(NSNumber *)womenAbove24 notes:(NSString *)notes activity:(Activities*) act
{
    self.date = date;
    
    if(menUnder15!=nil)
        self.men_under_15 = menUnder15;
    else
        self.men_under_15 = 0;
    
    if(men15To24!=nil)
        self.men_15_to_24 = men15To24;
    else
        self.men_15_to_24 = 0;
    
    if(menAbove24!=nil)
        self.men_above_24 = menAbove24;
    else
        self.men_above_24 = 0;
    if(womenUnder15)
        self.women_under_15 = womenUnder15;
    else
        self.women_under_15 = 0;
    
    if(women15To24!=nil)
        self.women_15_to_24 = women15To24;
    else
        self.women_15_to_24 = 0;
    
    if(womenAbove24!=nil)
        self.women_above_24 = womenAbove24;
    else
        self.women_above_24 = 0;
    
    self.notes = notes;
    self.activity = act;
    [act addParticipationsObject:self];
}

@end
