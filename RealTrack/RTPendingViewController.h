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
#import "RTPendingCell.h"
#import "Events.h"

@interface RTPendingViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    // CoreData
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Events array
@property (strong, nonatomic) NSArray * events;

@end
