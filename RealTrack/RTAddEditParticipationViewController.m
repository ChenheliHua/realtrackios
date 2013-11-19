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
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    
    [self.date setDate:self.defaultDate];
    
    int radius = 5;
    [self.button setCornerRadius:radius];
    
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320,600)];
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addParticipation:(id)sender
{
    Participations *part = [NSEntityDescription insertNewObjectForEntityForName:@"Participations" inManagedObjectContext:self.managedObjectContext];
    
    [part setDate:self.date.date menUnder15:[NSNumber numberWithInteger:[self.menUnder15.text intValue]] men15To24:[NSNumber numberWithInteger:[self.men15To24.text intValue]] menAvove24:[NSNumber numberWithInteger:[self.menAbove24.text intValue]] womenUnder15:[NSNumber numberWithInteger:[self.womenUnder15.text intValue]] women15To24:[NSNumber numberWithInteger:[self.women15To24.text intValue]] womenAbove24:[NSNumber numberWithInteger:[self.womenAbove24.text intValue]] notes:self.notes.text activity:self.currentAct];
    
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
                            // Remove event!
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(65.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    /*
     // If active text field is hidden by keyboard, scroll it so it's visible
     // Your app might not need or want this behavior.
     CGRect aRect = self.view.frame;
     aRect.size.height -= kbSize.height;
     if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
     [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
     }
     */
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
