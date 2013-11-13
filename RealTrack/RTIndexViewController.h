//
//  RTViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/15/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLogo.h"
#import "RTButton.h"
#import <EventKit/EventKit.h>
#import "RTPendingViewController.h"

@interface RTIndexViewController : UIViewController

@property (strong, nonatomic) IBOutlet RTLogo *logo;

@property (strong, nonatomic) IBOutlet RTButton *enterData;

@property (strong, nonatomic) IBOutlet RTButton *myActivities;

@property (strong, nonatomic) IBOutlet RTButton *pending;

@property (strong, nonatomic) NSArray * events;

- (IBAction)enterDataView:(id)sender;
- (IBAction)myActivitiesView:(id)sender;
- (IBAction)pendingView:(id)sender;

@end
