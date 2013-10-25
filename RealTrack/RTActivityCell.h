//
//  RTActivityCell.h
//  RealTrack
//
//  Created by Chenheli Hua on 10/25/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTActivityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *activityName;
- (IBAction)addParticipation:(id)sender;
- (IBAction)editActivity:(id)sender;

@end
