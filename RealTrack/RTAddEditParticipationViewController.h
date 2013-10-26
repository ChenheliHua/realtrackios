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

@end
