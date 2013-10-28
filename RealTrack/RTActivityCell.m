//
//  RTActivityCell.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/25/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTActivityCell.h"

@implementation RTActivityCell

@synthesize managedObjectContext;

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
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.currentAct.activity_name
                                                    message:[[[[[@"Start Date: " stringByAppendingString:[dateFormat stringFromDate:self.currentAct.start_date]]
                                                                stringByAppendingString:@"\nEnd Date: "] stringByAppendingString:[dateFormat stringFromDate:self.currentAct.end_date]]
                                                                stringByAppendingString:@"\nNotes: "] stringByAppendingString:self.currentAct.notes]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)deleteActivity:(id)sender {
    // Show alert asking for confirmatio
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Activity" message:self.currentAct.activity_name delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete!", nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // If cancel, do nothing
    if (buttonIndex == 0)
    {
        return;
    }
    // Confirmed deletion
    else
    {
        [self.managedObjectContext deleteObject:self.currentAct];
        
        NSError *err;
        [self.managedObjectContext save:&err];
    }
}
@end
