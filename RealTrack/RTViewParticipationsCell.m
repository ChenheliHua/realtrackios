//
//  RTViewParticipationsCell.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/29/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTViewParticipationsCell.h"

@implementation RTViewParticipationsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setActivityName:(NSString *)actName date:(NSDate *)date memUnder15:(NSNumber *)menUnder15 men15To24:(NSNumber *)men15To24 menAbove24:(NSNumber *)menAbove24 womenUnder15:(NSNumber *)womenUnder15 women15To24:(NSNumber *)women15To24 womenAbove24:(NSNumber *)womenAbove24 notes:(NSString *)notes
{
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    self.activityName.text = actName;
    self.date.text = [dateFormat stringFromDate:date];
    self.menUnder15.text = [NSString stringWithFormat:@"%@", menUnder15];
    self.men15To24.text = [NSString stringWithFormat:@"%@", men15To24];
    self.menAbove24.text = [NSString stringWithFormat:@"%@", menAbove24];
    self.womenUnder15.text = [NSString stringWithFormat:@"%@", womenUnder15];
    self.women15To24.text = [NSString stringWithFormat:@"%@", women15To24];
    self.womenAbove24.text = [NSString stringWithFormat:@"%@", womenAbove24];
    self.notes.text = notes;
}

@end
