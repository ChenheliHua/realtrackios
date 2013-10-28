//
//  RTActivityCell.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/25/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddEditActivityViewController.h"
#import "Projects.h"
#import "Activities.h"

@interface RTActivityCell : UITableViewCell
{
    // CoreData
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UILabel *activityName;
- (IBAction)addParticipation:(id)sender;
- (IBAction)editActivity:(id)sender;
- (IBAction)viewActivity:(id)sender;
- (IBAction)deleteActivity:(id)sender;


@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) Projects *currentProj;
@property (strong, nonatomic) Activities *currentAct;

@end
