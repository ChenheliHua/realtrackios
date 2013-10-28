//
//  RTActivityCell.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/25/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTActivityCell.h"

@implementation RTActivityCell

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

- (IBAction)addParticipation:(id)sender {
}

- (IBAction)editActivity:(id)sender {
    
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTAddEditActivityViewController *addEditAct = [sb instantiateViewControllerWithIdentifier:@"addEditActivityView"];
    
    // Pass the project & activity object
    addEditAct.currentProj = self.currentProj;
    addEditAct.currentAct = self.currentAct;
    
    // Set title
    addEditAct.title = @"Edit Activity";
    
    // Push view controller
    [self.navController pushViewController:addEditAct animated:YES];

}

- (IBAction)viewActivity:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.currentAct.activity_name
                                                    message:@"Activity Details"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
