//
//  Activities.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/30/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "Activities.h"
#import "Participations.h"
#import "Projects.h"


@implementation Activities

@dynamic activity_name;
@dynamic end_date;
@dynamic notes;
@dynamic start_date;
@dynamic organizations;
@dynamic communities;
@dynamic ecpa;
@dynamic food_security;
@dynamic malaria;
@dynamic youth;
@dynamic wid;
@dynamic mon;
@dynamic mon_time;
@dynamic tue;
@dynamic tue_time;
@dynamic wed;
@dynamic wed_time;
@dynamic thu;
@dynamic thu_time;
@dynamic fri;
@dynamic fri_time;
@dynamic sat;
@dynamic sat_time;
@dynamic sun;
@dynamic sun_time;
@dynamic participations;
@dynamic project;
@dynamic event_ids;

-(void)toggleWeekday:(NSInteger)day withBool:(BOOL)val
{
    int dayInt = day;
    switch (dayInt)
    {
        case 1:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"mon"];
            break;
        case 2:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"tue"];
            break;
        case 3:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"wed"];
            break;
        case 4:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"thu"];
            break;
        case 5:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"fri"];
            break;
        case 6:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"sat"];
            break;
        case 7:
            [self setValue:[NSNumber numberWithBool:val] forKey:@"sun"];
            break;
    }
}

-(void)setWeekday:(NSInteger)day withTime:(NSDate *)time
{
    int dayInt = day;
    switch(dayInt)
    {
        case 1:
            [self setValue:time forKey:@"mon_time"];
            break;
        case 2:
            [self setValue:time forKey:@"tue_time"];
            break;
        case 3:
            [self setValue:time forKey:@"wed_time"];
            break;
        case 4:
            [self setValue:time forKey:@"thu_time"];
            break;
        case 5:
            [self setValue:time forKey:@"fri_time"];
            break;
        case 6:
            [self setValue:time forKey:@"sat_time"];
            break;
        case 7:
            [self setValue:time forKey:@"sun_time"];
            break;
    }
}

-(BOOL)getWeekdayBool:(NSInteger)day
{
    
    int dayInt = day;
    switch(dayInt)
    {
        case 1:
            return [self.mon boolValue];
            break;
        case 2:
            return [self.tue boolValue];
            break;
        case 3:
            return [self.wed boolValue];
            break;
        case 4:
            return [self.thu boolValue];
            break;
        case 5:
            return [self.fri boolValue];
            break;
        case 6:
            return [self.sat boolValue];
            break;
        case 7:
            return [self.sun boolValue];
            break;
    }
    
    // If get here, just return NO
    return NO;
}

-(NSDate*)getTimeOnWeekday:(NSInteger)day
{
    int dayInt = day;
    switch(dayInt)
    {
        case 1:
            return self.mon_time;
            break;
        case 2:
            return self.tue_time;
            break;
        case 3:
            return self.wed_time;
            break;
        case 4:
            return self.thu_time;
            break;
        case 5:
            return self.fri_time;
            break;
        case 6:
            return self.sat_time;
            break;
        case 7:
            return self.sun_time;
            break;
    }
    
    // If get here, just return nil
    return nil;
}

// For Event Kit
-(void)addActivityEvent
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Cannot access Event Store!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                    
                    [alert show];
                }
                else if (!granted)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Permission Error!" message:@"Permission denied!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                    
                    [alert show];
                }
                else
                {
                    // Access or create RealTrack calendar
                    NSString * calID = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendarIdentifier"]; // Get calendar id
                    EKCalendar *cal = [eventStore calendarWithIdentifier:calID];
                    if(!cal)
                    {
                        // Create RealTrack calendar
                        cal = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
                        
                        [cal setTitle:@"RealTrack"];
                        
                        // Setup source as local
                        for(EKSource *s in eventStore.sources)
                        {
                            if(s.sourceType == EKSourceTypeLocal)
                            {
                                cal.source = s;
                                break;
                            }
                        }
                        
                        // Save calendar
                        NSError *err;
                        [eventStore saveCalendar:cal commit:YES error:&err];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:cal.calendarIdentifier forKey:@"calendarIdentifier"];
                    }
                    
                    // Set up days
                    // Compute next monday
                    // If the activity's start date is before today, only compute the next weekday after today rather than include past weekdays.
                    NSDate * startDate = [self.start_date laterDate:[NSDate date]];
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:startDate];
                    NSUInteger weekdayToday = [components weekday]; // Sun is 1, Sat is 7
                    
                    // Monday
                    if([self.mon boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextMonday = [startDate dateByAddingTimeInterval:60*60*24*((9 - weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextMonday at:self.mon_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    // Tuesday
                    if([self.tue boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextTuesday = [startDate dateByAddingTimeInterval:60*60*24*((10 - weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextTuesday at:self.tue_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    // Wednesday
                    if([self.wed boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextWednesday = [startDate dateByAddingTimeInterval:60*60*24*((11-weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextWednesday at:self.wed_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    // Thursday
                    if([self.thu boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextThursday = [startDate dateByAddingTimeInterval:60*60*24*((12 - weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextThursday at:self.thu_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    // Friday
                    if([self.fri boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextFriday = [startDate dateByAddingTimeInterval:60*60*24*((13 - weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextFriday at:self.fri_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    // Saturday
                    if([self.sat boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextSaturday = [startDate dateByAddingTimeInterval:60*60*24*((14 - weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextSaturday at:self.sat_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    // Sunday
                    if([self.sun boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextSunday = [startDate dateByAddingTimeInterval:60*60*24*((15 - weekdayToday) % 7)];
                        
                        [self addRecurrenceActOn:nextSunday at:self.sun_time onEventStore:eventStore onCalendar:cal];
                    }
                    
                    
                }
            });
        }];
    }
    else
    {
        // Code for iOS 4 & 5
        // No implementation here since the current development requires iOS 7
    }

}

-(void)addRecurrenceActOn:(NSDate *)nextWeekday at:(NSDate *)eventTime onEventStore:(EKEventStore *)eventStore onCalendar:(EKCalendar *)cal
{
    // Date formats
    NSDateFormatter * date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"MM/dd/yyyy"];
    
    NSDateFormatter * time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"HH:mm:ss"];
    
    NSDateFormatter * combine = [[NSDateFormatter alloc] init];
    [combine setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    // Configure time
    NSString * timeString = [NSString stringWithFormat:@"%@ %@", [date stringFromDate:nextWeekday], [time stringFromDate:eventTime]];
    NSDate * eventDate = [combine dateFromString:timeString];
    
    EKEvent * event = [EKEvent eventWithEventStore:eventStore];
    
    // Set up event
    event.calendar = cal;
    event.location = self.communities;
    event.title = [NSString stringWithFormat:@"Remember to enter data for Activity: %@ in Project: %@. ", self.activity_name, self.project.project_name];
    event.startDate = eventDate;
    event.endDate = [eventDate dateByAddingTimeInterval:60*60];
    
    // Set up recurrence rule (TO BE ADDED)
    EKRecurrenceRule * rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:1 end:[EKRecurrenceEnd recurrenceEndWithEndDate:self.end_date]];
    [event addRecurrenceRule:rule];
    
    // Save
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    EventIds * id = [NSEntityDescription insertNewObjectForEntityForName:@"EventIds"inManagedObjectContext:managedObjectContext];
    
    [id setValue:[[NSString alloc] initWithFormat:@"%@", event.eventIdentifier] forKey:@"event_id"];
    
    [self.event_ids addObject:id];
}

-(void)updateActivityEvent
{
    // Delete all exisiting events and re-add new ones
    [self deleteActivityEvent];
    [self addActivityEvent];
    
}

-(void)deleteActivityEvent
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    NSError * err;
    
    for (EventIds * id in self.event_ids)
    {
        // Delete all exisiting events
        [eventStore removeEvent:[eventStore eventWithIdentifier:id.event_id] span:EKSpanFutureEvents commit:YES error:&err];
    
        // Rewrite ids with an empty set
        self.event_ids = [[NSMutableSet alloc] init];
    }
}

@end
