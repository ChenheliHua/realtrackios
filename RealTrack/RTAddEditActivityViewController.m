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
    
    int radius = 5;
    [self.button setCornerRadius:radius];
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    // Display project name
    self.projectName.text = self.currentProj.project_name;
    [self.activityName setText:self.currentAct.activity_name];
    
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
            act.activity_name = self.activityName.text;
            
            // Build relations
            [self.currentProj addActivitiesObject:act];
            [act setProject:self.currentProj];
                        
            NSError * err;
            [managedObjectContext save:&err];
        }
        // Edit existing project
        else{
            self.currentAct.activity_name = self.activityName.text;
            
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
@end
