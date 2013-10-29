//
//  RTActivitiesViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/21/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAppDelegate.h"
#import "Projects.h"
#import "Activities.h"
#import "RTActivityCell.h"
#import "RTViewParticipationsCell.h"
#import <MessageUI/MessageUI.h>

@interface RTActivitiesViewController : UITableViewController <NSFetchedResultsControllerDelegate,MFMailComposeViewControllerDelegate>
{
    // CoreData
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Projects, activities & participations info
@property (nonatomic, strong) NSArray *projects;
@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, strong) NSArray *participations;

- (IBAction)exportCSV:(id)sender;

@end
