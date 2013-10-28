//
//  RTNewActivityCell.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/26/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTNewActivityCell.h"

@implementation RTNewActivityCell

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

- (IBAction)editProj:(id)sender {
    
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTAddEditProjectViewController *editProj = [sb instantiateViewControllerWithIdentifier:@"addEditProjectView"];
    
    // Pass the project object
    editProj.currentProj = self.currentProj;
    
    // Set title
    editProj.title = @"Edit Project";
    
    // Push view controller
    [self.navController pushViewController:editProj animated:YES];
}

- (IBAction)viewProj:(id)sender {
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.currentProj.project_name
                                                    message:[[[[[@"Start Date: " stringByAppendingString:[dateFormat stringFromDate:self.currentProj.start_date]]
                                                                stringByAppendingString:@"\nEnd Date: "] stringByAppendingString:[dateFormat stringFromDate:self.currentProj.end_date]]
                                                              stringByAppendingString:@"\nNotes: "] stringByAppendingString:self.currentProj.notes]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)deleteProj:(id)sender {
    // Show alert asking for confirmatio
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Project" message:self.currentProj.project_name delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete!", nil];
    
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
        [self.managedObjectContext deleteObject:self.currentProj];
        
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
