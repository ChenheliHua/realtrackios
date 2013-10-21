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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
