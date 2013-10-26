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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
