//
//  RTViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/15/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTIndexViewController.h"

@interface RTIndexViewController ()

@end

@implementation RTIndexViewController

@synthesize fetchedResultsController, managedObjectContext;
@synthesize projects, activities;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Load Peace Corps logo
    [self.logo loadLogo];
    
    // Set corner radius of buttons
    int radius = 5;
    [self.enterData setCornerRadius:radius];
    [self.myActivities setCornerRadius:radius];
    [self.pending setCornerRadius:radius];
    
    // Retrieve pending events
    // Get all past events without participation
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    self.projects = [Projects retrieveProjectsWithPredicate:nil andSortDescriptor:nil];
    self.activities = [Activities retrieveActivitiesWithPredicate:nil andSortDescriptor:nil];
    
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
                        // Retrieve all existing RealTrack in the recent two years events until today
                        // Note: predicateForEventsWithStartDate: endDate: calendars: can only retrive events within a certain period. If the start date is too far ago from now (e.g. 2005-01-01), it
                        //       simply returns nil. Reasons unknown.
                        NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:[[NSDate date] dateByAddingTimeInterval:-3600*24*365*2] endDate:[NSDate date] calendars:@[cal]];
                        self.events = [eventStore eventsMatchingPredicate:predicate];
                        
                        [self.pending setButtonTitle:[NSString stringWithFormat:@"Pending (%d)", [self.events count]]];
                        
                    }
                    else
                        NSLog(@"Unable to connect RealTrack calendar!");
                }
            });
        }];
    }
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)enterDataView:(id)sender {
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTEnterDataViewController *enterData = [sb instantiateViewControllerWithIdentifier:@"enterDataView"];
    
    enterData.projects = self.projects;
    enterData.activities = self.activities;
    enterData.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:enterData animated:YES];
}

- (IBAction)myActivitiesView:(id)sender {
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTActivitiesViewController *myActs = [sb instantiateViewControllerWithIdentifier:@"myActivitiesView"];
    
    myActs.projects = self.projects;
    myActs.activities = self.activities;
    myActs.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:myActs animated:YES];
}

- (IBAction)pendingView:(id)sender {
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTPendingViewController *pending = [sb instantiateViewControllerWithIdentifier:@"pendingView"];
    
    pending.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:pending animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    // TODO: Reload data & refresh page. 
}

@end
