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
    
    self.projectName.delegate = self;
    
    int radius = 5;
    [self.button setCornerRadius:radius];
    
    // Load managedObjectContext
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
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
        
            proj.project_name = self.projectName.text;
        
            NSError * err;
            [managedObjectContext save:&err];
        }
        // Edit existing project
        else{
            // EDIT PROJECT TO BE IMPLEMENTED HERE
        }
    }
    else{
        // MAY POP AN ALERT FOR EMPTY PROJECT NAME
    }
    
    [[self.navigationController popViewControllerAnimated:YES] viewWillAppear:YES];
}
@end
