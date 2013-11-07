//
//  RTAddEditParticipationViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/26/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTAddEditParticipationViewController.h"

@interface RTAddEditParticipationViewController ()

@end

@implementation RTAddEditParticipationViewController

@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    // Display project & activity names
    self.projectName.text = self.currentProj.project_name;
    self.activityName.text = self.currentAct.activity_name;
    
    // Set text field delegates to hide keyboard
    self.menUnder15.delegate = self;
    self.men15To24.delegate = self;
    self.menAbove24.delegate = self;
    self.womenUnder15.delegate = self;
    self.women15To24.delegate = self;
    self.womenAbove24.delegate = self;
    self.notes.delegate = self;
    
    int radius = 5;
    [self.button setCornerRadius:radius];
    
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320,640)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addParticipation:(id)sender {
    Participations *part = [NSEntityDescription insertNewObjectForEntityForName:@"Participations"inManagedObjectContext:self.managedObjectContext];
    

    [part setValue:self.date.date forKey:@"date"];
    
    // For number of attendants and notes
    if(self.menUnder15.text!=nil)
        part.men_under_15 = [NSNumber numberWithInteger:[self.menUnder15.text intValue]];
    else
        part.men_under_15 = 0;
    
    if(self.men15To24.text!=nil)
        part.men_15_to_24 = [NSNumber numberWithInteger:[self.men15To24.text intValue]];
    else
        part.men_15_to_24 = 0;
    
    if(self.menAbove24.text!=nil)
        part.men_above_24 = [NSNumber numberWithInteger:[self.menAbove24.text intValue]];
    else
        part.men_above_24 = 0;
    
    if(self.womenUnder15.text!=nil)
        part.women_under_15 = [NSNumber numberWithInteger:[self.womenUnder15.text intValue]];
    else
        part.men_under_15 = 0;
    
    if(self.women15To24.text!=nil)
        part.women_15_to_24 = [NSNumber numberWithInteger:[self.women15To24.text intValue]];
    else
        part.women_15_to_24 = 0;
    
    if(self.womenAbove24.text!=nil)
        part.women_above_24 = [NSNumber numberWithInteger:[self.womenAbove24.text intValue]];
    else
        part.women_above_24 = 0;
    
    part.notes = self.notes.text;
    
    // Added participation into the activity
    [self.currentAct addParticipationsObject:part];
    
    // Save
    NSError * err;
    [managedObjectContext save:&err];
    
    // Remove calendar event
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
                    // Access RealTrack calendar
                    NSString * calID = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendarIdentifier"];
                    EKCalendar *cal = [eventStore calendarWithIdentifier:calID];
                    
                    // If calendar exists
                    if(cal)
                    {
                        
                        // Search RealTrack events that happen between one hour before the participation time and one hour after
                        NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:[self.date.date dateByAddingTimeInterval:-3600] endDate:[self.date.date dateByAddingTimeInterval:3600] calendars:@[cal]];
                        NSArray * events = [eventStore eventsMatchingPredicate:predicate];
                        
                        // Treat all retrived events as participated and remove them
                        NSError * err;
                        for(EKEvent *event in events)
                        {
                            [eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:&err];
                        }
                    }
                }
            });
        }];
    }
    
    // Pop parent view
    [[self.navigationController popViewControllerAnimated:YES] viewWillAppear:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
