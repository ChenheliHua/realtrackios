//
//  RTViewParticipationsCell.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/29/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activities.h"
#import "Participations.h"

@interface RTViewParticipationsCell : UITableViewCell

// Properties on Interface Builder
@property (strong, nonatomic) IBOutlet UILabel *activityName;
@property (strong, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) IBOutlet UILabel *menUnder15;
@property (strong, nonatomic) IBOutlet UILabel *men15To24;
@property (strong, nonatomic) IBOutlet UILabel *menAbove24;
@property (strong, nonatomic) IBOutlet UILabel *womenUnder15;
@property (strong, nonatomic) IBOutlet UILabel *women15To24;
@property (strong, nonatomic) IBOutlet UILabel *womenAbove24;

@property (strong, nonatomic) IBOutlet UILabel *notes;

// Properties on CoreData
@property (strong, nonatomic) Activities *currentAct;
@property (strong, nonatomic) Participations *currentPart;

@end
