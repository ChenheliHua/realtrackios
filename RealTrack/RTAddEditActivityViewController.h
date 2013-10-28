//
//  RTAddEditActivityViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/24/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTButton.h"
#import "RTAppDelegate.h"
#import "Projects.h"
#import "Activities.h"

@interface RTAddEditActivityViewController : UIViewController
{
    // CoreData
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UILabel *projectName;
@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (strong, nonatomic) IBOutlet RTButton *button;
@property (strong, nonatomic) IBOutlet UITextField *startDate;
@property (strong, nonatomic) IBOutlet UITextField *endDate;
@property (strong, nonatomic) IBOutlet UITextField *notes;

// Store the project a activity belongs to and the activity
@property (strong, nonatomic) Projects *currentProj;
@property (strong, nonatomic) Activities *currentAct;

- (IBAction)addEditActivity:(id)sender;

@end
