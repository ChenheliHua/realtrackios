//
//  RTPendingViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/21/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Projects.h"
#import "Activities.h"

@interface RTPendingViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    // CoreData
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Projects and activities
@property (strong, nonatomic) NSArray * projects;
@property (strong, nonatomic) NSArray * activities;

@end
