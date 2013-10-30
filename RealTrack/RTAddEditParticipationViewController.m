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
    
    // Pop parent view
    [[self.navigationController popViewControllerAnimated:YES] viewWillAppear:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
