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
        [self.activityName setText:self.currentAct.activity_name];
        [self.startDate setDate:self.currentAct.start_date];
        [self.endDate setDate:self.currentAct.end_date];
        [self.notes setText:self.currentAct.notes];
    }
    
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320,720)];
    
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
    
    if(![trimmedStr isEqualToString:@""])
    {
        // Create new activity
        if(self.currentAct == nil)
        {
            // Save new activity
            Activities * act = [NSEntityDescription insertNewObjectForEntityForName:@"Activities"inManagedObjectContext:self.managedObjectContext];
            
            // Set activity name
            [act setValue:self.activityName.text forKey:@"activity_name"];
            
            [act setValue:self.startDate.date forKey:@"start_date"];
            
            [act setValue:self.endDate.date forKey:@"end_date"];
            
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
            

            [self.currentAct setValue:self.startDate.date forKey:@"start_date"];

            [self.currentAct setValue:self.endDate.date forKey:@"end_date"];
            
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
