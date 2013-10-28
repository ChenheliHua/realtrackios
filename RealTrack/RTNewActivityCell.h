//
//  RTNewActivityCell.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/26/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddEditProjectViewController.h"
#import "RTAddEditActivityViewController.h"
#import "Projects.h"

@interface RTNewActivityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)newAct:(id)sender;
- (IBAction)editProj:(id)sender;
- (IBAction)viewProj:(id)sender;
- (IBAction)deleteProj:(id)sender;


@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) Projects *currentProj;

@end
