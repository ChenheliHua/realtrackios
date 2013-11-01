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
                    EKCalendar *cal = [eventStore calendarWithIdentifier:@"RealTrack"];
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
                        
                    }
                    
                    // Set up days
                    // Compute next monday
                    NSDate * startDate = self.start_date;
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:startDate];
                    NSUInteger weekdayToday = [components weekday]; // Sun is 1, Sat is 7
                    
                    // Monday
                    NSInteger daysToMonday = (9 - weekdayToday) % 7;
                    NSDate *nextMonday = [startDate dateByAddingTimeInterval:60*60*24*daysToMonday];
                    
                    // Date formats
                    NSDateFormatter * date = [[NSDateFormatter alloc] init];
                    [date setDateFormat:@"MM/dd/yyyy"];
                    
                    NSDateFormatter * time = [[NSDateFormatter alloc] init];
                    [time setDateFormat:@"HH:mm:ss"];
                    
                    NSDateFormatter * combine = [[NSDateFormatter alloc] init];
                    [combine setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                    
                    if([self.mon boolValue])
                    {
                        // combine next mon date + mon_time time and regiester event
                        NSDate * nextMonday = [startDate dateByAddingTimeInterval:60*60*24*(9 - weekdayToday) % 7];
                        NSString * timeString = [NSString stringWithFormat:@"%@ %@", [date stringFromDate:nextMonday], [time stringFromDate:self.mon_time]];
                        NSDate * eventDate = [combine dateFromString:timeString];
                        
                        EKEvent * event = [EKEvent eventWithEventStore:eventStore];
                        
                        // Set up event
                        event.calendar = cal;
                        event.location = self.communities;
                        event.title = [NSString stringWithFormat:@"%@: %@", self.project.project_name, self.activity_name];
                        event.startDate = eventDate;
                        event.endDate = [eventDate dateByAddingTimeInterval:60*60];
                        
                        // Set up recurrence rule (TO BE ADDED)
                        EKRecurrenceRule * rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:1 end:[EKRecurrenceEnd recurrenceEndWithEndDate:self.end_date]];
                        [event addRecurrenceRule:rule];
                        
                        // Save
                        NSError *err;
                        [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                    }
                    
                    // Tuesday
                    
                    // Wednesday
                    
                    // Thursday
                    
                    // Friday
                    
                    // Saturday
                    
                    // Sunday
                    
                    
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
    }

}

-(void)updateActivityEvent
{
    
}

-(void)deleteActivityEvent
{
    
}

@end
