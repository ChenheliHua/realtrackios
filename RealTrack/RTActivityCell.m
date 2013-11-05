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
        // Delete events first
        [self.currentAct deleteActivityEvent];
        
        // Delete act object
        [self.managedObjectContext deleteObject:self.currentAct];
        
        NSError *err;
        [self.managedObjectContext save:&err];
        
        // Reload all data
        RTEnterDataViewController *vc = self.navController.visibleViewController;
        
        NSFetchRequest *fetchRequestProj = [[NSFetchRequest alloc] init];
        NSFetchRequest *fetchRequestAct = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *projs = [NSEntityDescription entityForName:@"Projects" inManagedObjectContext:managedObjectContext];
        NSEntityDescription *acts = [NSEntityDescription entityForName:@"Activities" inManagedObjectContext:managedObjectContext];
        
        [fetchRequestProj setEntity:projs];
        [fetchRequestAct setEntity:acts];
        
        NSSortDescriptor * sortProjName = [NSSortDescriptor sortDescriptorWithKey:@"project_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        [fetchRequestProj setSortDescriptors:[NSArray arrayWithObjects:sortProjName, nil]];
        
        vc.projects = [managedObjectContext executeFetchRequest:fetchRequestProj error:&err];
        vc.activities = [managedObjectContext executeFetchRequest:fetchRequestAct error:&err];
        
        [vc.table reloadData];
    }
}
@end
