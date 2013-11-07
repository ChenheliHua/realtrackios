//
//  RTPendingCell.m
//  RealTrack
//
//  Created by Chenheli Hua on 11/6/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTPendingCell.h"

@implementation RTPendingCell

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

/*
- (IBAction)viewActivity:(id)sender {
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.currentAct.activity_name
                                                    message:[[[[[[[[[@"Start Date: " stringByAppendingString:[dateFormat stringFromDate:self.currentAct.start_date]]
                                                                    stringByAppendingString:@"\nEnd Date: "] stringByAppendingString:[dateFormat stringFromDate:self.currentAct.end_date]]
                                                                  stringByAppendingString:@"\nNotes: "] stringByAppendingString:self.currentAct.notes]
                                                                stringByAppendingString:@"\nOrganizations: "] stringByAppendingString:self.currentAct.organizations]
                                                              stringByAppendingString:@"\nCommunities: "] stringByAppendingString:self.currentAct.communities]
                          // NEED TO ADD REMINDERS AND INITIATIVES
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
- (IBAction)addParticipation:(id)sender {
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTAddEditParticipationViewController *addPart = [sb instantiateViewControllerWithIdentifier:@"addEditParticipationView"];
    
    // Pass the project and activity object
    addPart.currentProj = self.currentProj;
    addPart.currentAct = self.currentAct;
    
    // Set title
    addPart.title = @"Add Participation";
    
    // Push view controller
    [self.navController pushViewController:addPart animated:YES];
}

 */

@end
