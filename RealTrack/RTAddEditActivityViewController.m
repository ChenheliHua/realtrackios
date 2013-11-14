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
    self.organizations.delegate = self;
    self.communities.delegate = self;
    
    int radius = 5;
    [self.button setCornerRadius:radius];

    // Display project name
    self.projectName.text = self.currentProj.project_name;
    
    if(self.currentAct!=nil)
    {
        [self.activityName setText:self.currentAct.activity_name];
        [self.startDate setDate:self.currentAct.start_date];
        [self.endDate setDate:self.currentAct.end_date];
        
        
        for(UISwitch * sw in self.weekdaysS)
        {
            [sw setOn:([self.currentAct getTimeOnWeekday:sw.tag]!=nil)];
        }
        
        for(UIDatePicker * dp in self.weekdaysP)
        {
            if([self.currentAct getTimeOnWeekday:dp.tag]!=nil)
                [dp setDate:[self.currentAct getTimeOnWeekday:dp.tag]];
            else
                [dp setDate:[NSDate date]];
        }
        
        self.organizations.text = self.currentAct.organizations;
        self.communities.text = self.currentAct.communities;
        
        [self.widS setOn:[self.currentAct.wid boolValue]];
        [self.youthS setOn:[self.currentAct.youth boolValue]];
        [self.malariaS setOn:[self.currentAct.malaria boolValue]];
        [self.foodS setOn:[self.currentAct.food_security boolValue]];
        [self.ecpaS setOn:[self.currentAct.ecpa boolValue]];
         
        [self.currentAct setValue:self.notes.text forKey:@"notes"];
        
        [self.notes setText:self.currentAct.notes];
    }
    
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320,2250)];
    
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
            Activities * act = [NSEntityDescription insertNewObjectForEntityForName:@"Activities"inManagedObjectContext:self.managedObjectContext];
            
            for(UIDatePicker * dp in self.weekdaysP)
            {
                if([[self.weekdaysS objectAtIndex:(dp.tag-1)] isOn])
                    [act setWeekday:dp.tag withTime:dp.date];
                else
                    [act setWeekday:dp.tag withTime:nil];
            }
            
            [act setName:self.activityName.text startDate:self.startDate.date endDate:self.endDate.date organizatons:self.organizations.text communities:self.communities.text ecpa:[self.ecpaS isOn] foodSecurity:[self.foodS isOn] malaria:[self.malariaS isOn] youth:[self.youthS isOn] wid:[self.widS isOn] project:self.currentProj notes:self.notes.text];
            
            NSError * err;
            [managedObjectContext save:&err];
            
            [act addActivityEvent];
        }
        // Edit existing project
        else{
            for(UIDatePicker * dp in self.weekdaysP)
            {
                if([[self.weekdaysS objectAtIndex:(dp.tag-1)] isOn])
                    [self.currentAct setWeekday:dp.tag withTime:dp.date];
                else
                    [self.currentAct setWeekday:dp.tag withTime:nil];
            }
            
            [self.currentAct setName:self.activityName.text startDate:self.startDate.date endDate:self.endDate.date organizatons:self.organizations.text communities:self.communities.text ecpa:[self.ecpaS isOn] foodSecurity:[self.foodS isOn] malaria:[self.malariaS isOn] youth:[self.youthS isOn] wid:[self.widS isOn] project:self.currentProj notes:self.notes.text];
            
            NSError * err;
            [managedObjectContext save:&err];
            
            [self.currentAct updateActivityEvent];
        }
    }
    else{
        //TODO: POP AN ALERT FOR EMPTY ACT NAME
    }
    
    // Pop parent view
    [[self.navigationController popViewControllerAnimated:YES] viewWillAppear:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
