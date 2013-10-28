//
//  RTAddEditActivityViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/24/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTAddEditActivityViewController.h"

@interface RTAddEditActivityViewController ()

@end

@implementation RTAddEditActivityViewController

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
    
    // For hiding keyboard after finishing typing
    self.activityName.delegate = self;
    self.startDate.delegate = self;
    self.endDate.delegate = self;
    self.notes.delegate = self;
    
    int radius = 5;
    [self.button setCornerRadius:radius];
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    // Display project name
    self.projectName.text = self.currentProj.project_name;
    
    if(self.currentAct!=nil)
    {
        // For date format
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        
        [self.activityName setText:self.currentAct.activity_name];
        [self.startDate setText:[dateFormat stringFromDate:self.currentAct.start_date]];
        [self.endDate setText:[dateFormat stringFromDate:self.currentAct.end_date]];
        [self.notes setText:self.currentAct.notes];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addEditActivity:(id)sender {
    
    // Save new activity if not empty
    // Escape whitespaces
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStr = [self.activityName.text stringByTrimmingCharactersInSet:charSet];
    
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    if(![trimmedStr isEqualToString:@""])
    {
        // Create new activity
        if(self.currentAct == nil)
        {
            // Save new activity
            Activities * act = [NSEntityDescription insertNewObjectForEntityForName:@"Activities"inManagedObjectContext:self.managedObjectContext];
            
            // Set activity name
            [act setValue:self.activityName.text forKey:@"activity_name"];
            
            NSDate *dt = [dateFormat dateFromString:self.startDate.text];
            if(dt!=nil)
                [act setValue:dt forKey:@"start_date"];
            else
                [act setValue:[dateFormat dateFromString:@"01/01/2000"] forKey:@"start_date"];
            
            dt = [dateFormat dateFromString:self.endDate.text];
            if(dt!=nil)
                [act setValue:dt forKey:@"end_date"];
            else
                [act setValue:[dateFormat dateFromString:@"01/01/2000"] forKey:@"end_date"];
            
            [act setValue:self.notes.text forKey:@"notes"];
            
            // Build relations
            [self.currentProj addActivitiesObject:act];
            [act setProject:self.currentProj];
                        
            NSError * err;
            [managedObjectContext save:&err];
        }
        // Edit existing project
        else{
            // Update activity information
            [self.currentAct setValue:self.activityName.text forKey:@"activity_name"];
            
            // Skip editing date if invalid format is given
            NSDate *dt = [dateFormat dateFromString:self.startDate.text];
            if(dt!=nil)
                [self.currentAct setValue:dt forKey:@"start_date"];
            
            dt = [dateFormat dateFromString:self.endDate.text];
            if(dt!=nil)
                [self.currentAct setValue:dt forKey:@"end_date"];
            
            [self.currentAct setValue:self.notes.text forKey:@"notes"];
            
            NSError * err;
            [managedObjectContext save:&err];
        }
    }
    else{
        // MAY POP AN ALERT FOR EMPTY ACT NAME
    }
    
    // Pop parent view
    [[self.navigationController popViewControllerAnimated:YES] viewWillAppear:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
