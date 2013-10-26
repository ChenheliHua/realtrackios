//
//  RTAddEditProjectViewController.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/24/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTButton.h"
#import "Projects.h"
#import "RTAppDelegate.h"

@interface RTAddEditProjectViewController : UIViewController
{
    // CoreData
    NSManagedObjectContext *managedObjectContext;
}

// CoreData
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet RTButton *button;
@property (strong, nonatomic) IBOutlet UITextField *projectName;

// Store current project for editing, nil for new project
@property (strong, nonatomic) Projects *currentProj;

-(BOOL)textFieldShouldReturn:(UITextField*)textField;

- (IBAction)addEditProject:(RTButton *)sender;

@end
