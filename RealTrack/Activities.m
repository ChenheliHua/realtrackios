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

@end
