//
//  RTPendingCell.h
//  RealTrack
//
//  Created by Chenheli Hua on 11/6/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Projects.h"
#import "Activities.h"
#import <EventKit/EventKit.h>

@interface RTPendingCell : UITableViewCell

@property (strong, nonatomic) UINavigationController * navController;
@property (strong, nonatomic) Projects * currentProj;
@property (strong, nonatomic) Activities * currentAct;
@property (strong, nonatomic) EKEvent * currentEvent;

@property (strong, nonatomic) IBOutlet UILabel *title;
/*
- (IBAction)addParticipation:(id)sender;
- (IBAction)viewActivity:(id)sender;
*/
@end
