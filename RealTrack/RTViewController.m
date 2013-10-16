//
//  RTViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/15/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTViewController.h"

@interface RTViewController ()

@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
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
