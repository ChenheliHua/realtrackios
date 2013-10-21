//
//  RTAppDelegate.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/15/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

// Table view controllers
#import "RTEnterDataViewController.h"
#import "RTActivitiesViewController.h"
#import "RTPendingViewController.h"

// Model objects
#import "Projects.h"
#import "Participations.h"
#import "Activities.h"

@interface RTAppDelegate : UIResponder <UIApplicationDelegate>
{
    // CoreData objects
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@property (strong, nonatomic) UIWindow *window;

@end
