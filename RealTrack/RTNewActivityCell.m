//
//  RTNewActivityCell.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/26/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTNewActivityCell.h"

@implementation RTNewActivityCell

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

- (IBAction)newAct:(id)sender {
    
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTAddEditActivityViewController *addEditAct = [sb instantiateViewControllerWithIdentifier:@"addEditActivityView"];
    
    // Pass the project object, set currentAct to nil for new activity
    addEditAct.currentProj = self.currentProj;
    addEditAct.currentAct = nil;
    
    // Set title
    addEditAct.title = @"New Activity";
    
    // Push view controller
    [self.navController pushViewController:addEditAct animated:YES];
}
@end
