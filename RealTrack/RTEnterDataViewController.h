//
//  RTEnterDataViewController.h
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
#import "RTNewActivityCell.h"
#import "RTAddEditProjectViewController.h"

@interface RTEnterDataViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    // CoreData
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Projects & activities info
@property (nonatomic, strong) NSArray *projects;
@property (nonatomic, strong) NSArray *activities;

@property (strong, nonatomic) IBOutlet UITableView *table;

// New Project
- (IBAction)newProject:(id)sender;

@end
