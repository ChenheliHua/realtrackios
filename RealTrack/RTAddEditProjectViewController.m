//
//  RTAddEditProjectViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/24/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTAddEditProjectViewController.h"

@interface RTAddEditProjectViewController ()

@end

@implementation RTAddEditProjectViewController

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
    
    // For hiding keyboard after finishing typing
    self.projectName.delegate = self;
    self.notes.delegate = self;
    
    int radius = 5;
    [self.button setCornerRadius:radius];
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    // Setup existing project name
    if(self.currentProj!=nil)
    {
        [self.projectName setText:self.currentProj.project_name];
        [self.startDate setDate:self.currentProj.start_date];
        [self.endDate setDate:self.currentProj.end_date];
        [self.notes setText:self.currentProj.notes];
    }
    
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320,640)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)addEditProject:(RTButton *)sender {

    // Save new project if not empty
    // Escape whitespaces
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStr = [self.projectName.text stringByTrimmingCharactersInSet:charSet];
    
    if(![trimmedStr isEqualToString:@""])
    {
        // Create new project
        if(self.currentProj == nil)
        {
            // Save new project
            Projects * proj = [NSEntityDescription insertNewObjectForEntityForName:@"Projects"inManagedObjectContext:self.managedObjectContext];
        
            [proj setValue:self.projectName.text forKey:@"project_name"];
            
            [proj setValue:self.startDate.date forKey:@"start_date"];
            [proj setValue:self.endDate.date forKey:@"end_date"];
            
            [proj setValue:self.notes.text forKey:@"notes"];
        
            NSError * err;
            [managedObjectContext save:&err];
        }
        // Edit existing project
        else{
            [self.currentProj setValue:self.projectName.text forKey:@"project_name"];
            
            [self.currentProj setValue:self.startDate.date forKey:@"start_date"];
            
            [self.currentProj setValue:self.endDate.date forKey:@"end_date"];
            
            [self.currentProj setValue:self.notes.text forKey:@"notes"];
            
            NSError * err;
            [managedObjectContext save:&err];
        }
    }
    else{
        // Invalid project name alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Project Name"
                                                        message:@"Project name should not be empty!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Pop parent view
    [[self.navigationController popViewControllerAnimated:YES] viewWillAppear:YES];
}
@end
