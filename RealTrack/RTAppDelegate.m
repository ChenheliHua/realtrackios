//
//  RTAppDelegate.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/15/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTAppDelegate.h"


@implementation RTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    RTEnterDataViewController *enterData = (RTEnterDataViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"enterDataView"];
    RTActivitiesViewController *activities = (RTActivitiesViewController*) [mainStoryboard instantiateViewControllerWithIdentifier:@"activitiesView"];
    RTPendingViewController *pending = (RTPendingViewController*) [mainStoryboard instantiateViewControllerWithIdentifier:@"pendingView"];
    
    // Link controllers to CoreData
    enterData.managedObjectContext = self.managedObjectContext;
    activities.managedObjectContext = self.managedObjectContext;
    pending.managedObjectContext = self.managedObjectContext;
    
    /*
    // Added dummy data for testing data display in RTEnterDataViewController
    Projects * newProj1 = [NSEntityDescription insertNewObjectForEntityForName:@"Projects" inManagedObjectContext:self.managedObjectContext];
    Projects * newProj2 = [NSEntityDescription insertNewObjectForEntityForName:@"Projects" inManagedObjectContext:self.managedObjectContext];
    Activities * newAct1 = [NSEntityDescription insertNewObjectForEntityForName:@"Activities" inManagedObjectContext:self.managedObjectContext];
    Activities * newAct2 = [NSEntityDescription insertNewObjectForEntityForName:@"Activities" inManagedObjectContext:self.managedObjectContext];
    Activities * newAct3 = [NSEntityDescription insertNewObjectForEntityForName:@"Activities" inManagedObjectContext:self.managedObjectContext];
    Activities * newAct4 = [NSEntityDescription insertNewObjectForEntityForName:@"Activities" inManagedObjectContext:self.managedObjectContext];
    Participations * newPart1 = [NSEntityDescription insertNewObjectForEntityForName:@"Participations" inManagedObjectContext:self.managedObjectContext];
    Participations * newPart2 = [NSEntityDescription insertNewObjectForEntityForName:@"Participations" inManagedObjectContext:self.managedObjectContext];
    Participations * newPart3 = [NSEntityDescription insertNewObjectForEntityForName:@"Participations" inManagedObjectContext:self.managedObjectContext];
    Participations * newPart4 = [NSEntityDescription insertNewObjectForEntityForName:@"Participations" inManagedObjectContext:self.managedObjectContext];

    
    newProj1.project_name = @"Proj No 1";
    newProj2.project_name = @"Proj No 2";
    
    newAct1.activity_name = @"Act No 1";
    newAct2.activity_name = @"Act No 2";
    newAct3.activity_name = @"Act No 3";
    newAct4.activity_name = @"Act No 4";
    
    newPart1.women_under_15 = [NSNumber numberWithInt:5];
    newPart1.men_under_15 = [NSNumber numberWithInt:5];;
    newPart1.women_15_to_24 = [NSNumber numberWithInt:5];
    newPart1.men_15_to_24 = [NSNumber numberWithInt:5];
    newPart1.women_above_24 = [NSNumber numberWithInt:5];
    newPart1.men_above_24 = [NSNumber numberWithInt:5];
    newPart2.women_under_15 = [NSNumber numberWithInt:10];
    newPart2.men_under_15 = [NSNumber numberWithInt:10];
    newPart2.women_15_to_24 = [NSNumber numberWithInt:10];
    newPart2.men_15_to_24 = [NSNumber numberWithInt:10];
    newPart2.women_above_24 = [NSNumber numberWithInt:10];
    newPart2.men_above_24 = [NSNumber numberWithInt:10];
    newPart3.women_under_15 = [NSNumber numberWithInt:15];
    newPart3.men_under_15 = [NSNumber numberWithInt:15];;
    newPart3.women_15_to_24 = [NSNumber numberWithInt:15];
    newPart3.men_15_to_24 = [NSNumber numberWithInt:15];
    newPart3.women_above_24 = [NSNumber numberWithInt:15];
    newPart3.men_above_24 = [NSNumber numberWithInt:15];
    newPart4.women_under_15 = [NSNumber numberWithInt:20];
    newPart4.men_under_15 = [NSNumber numberWithInt:20];
    newPart4.women_15_to_24 = [NSNumber numberWithInt:20];
    newPart4.men_15_to_24 = [NSNumber numberWithInt:20];
    newPart4.women_above_24 = [NSNumber numberWithInt:20];
    newPart4.men_above_24 = [NSNumber numberWithInt:20];
    
    [newProj1 addActivitiesObject:newAct1];
    [newProj1 addActivitiesObject:newAct2];
    [newProj2 addActivitiesObject:newAct3];
    [newProj2 addActivitiesObject:newAct4];
    
    [newAct1 addParticipationsObject:newPart1];
    [newAct2 addParticipationsObject:newPart2];
    [newAct3 addParticipationsObject:newPart3];
    [newAct4 addParticipationsObject:newPart4];
    
    // Save dummy data
    NSError *err;
    [managedObjectContext save:&err];
    */
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// CoreData methods
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"RealTrack.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}




// No explicit relase calls on managedObjectContext,
// managedObjectModel, and persistentStoreCoordinator
// becasue of Automatic Reference Counting


@end