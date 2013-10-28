//
//  RTAddEditParticipationViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/26/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAppDelegate.h"
#import "Projects.h"
#import "Activities.h"
#import "Participations.h"

@interface RTAddEditParticipationViewController : UIViewController
{
    // CoreData
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Store project and activity info
@property (strong, nonatomic) Projects *currentProj;
@property (strong, nonatomic) Activities *currentAct;

@property (strong, nonatomic) IBOutlet UILabel *projectName;
@property (strong, nonatomic) IBOutlet UILabel *activityName;
@property (strong, nonatomic) IBOutlet UITextField *date;
@property (strong, nonatomic) IBOutlet UITextField *menUnder15;
@property (strong, nonatomic) IBOutlet UITextField *men15To24;
@property (strong, nonatomic) IBOutlet UITextField *menAbove24;
@property (strong, nonatomic) IBOutlet UITextField *womenUnder15;
@property (strong, nonatomic) IBOutlet UITextField *women15To24;
@property (strong, nonatomic) IBOutlet UITextField *womenAbove24;
@property (strong, nonatomic) IBOutlet UITextField *notes;
@property (strong, nonatomic) IBOutlet RTButton *button;

- (IBAction)addParticipation:(id)sender;

@end
