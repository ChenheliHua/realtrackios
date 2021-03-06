//
//  RTEnterDataViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/21/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTEnterDataViewController.h"

@interface RTEnterDataViewController ()

@end

@implementation RTEnterDataViewController

// CoreData
@synthesize fetchedResultsController, managedObjectContext;
@synthesize projects, activities;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sort projects by name
    NSSortDescriptor * sortProjName = [NSSortDescriptor sortDescriptorWithKey:@"project_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    self.projects = [Projects retrieveProjectsWithPredicate:nil andSortDescriptor:sortProjName];
    self.activities = [Activities retrieveActivitiesWithPredicate:nil andSortDescriptor:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Each project serves as a section
    return [self.projects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int num = 0;
    
    // Get project
    Projects *proj = [self.projects objectAtIndex:section];
    
    // Extract activities that belongs to that project
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"project == %@",proj];
    num = [[self.activities filteredArrayUsingPredicate:pred] count];
    
    // Return num + 1 to include the last "New Activity" cell
    return (num + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Select all activities that belong to a project
    Projects * proj = [self.projects objectAtIndex:indexPath.section];
    NSPredicate * proj_name = [NSPredicate predicateWithFormat:@"project == %@",proj];
    
    NSArray * subActivities = [self.activities filteredArrayUsingPredicate:proj_name];
    
    // Choose activitiesCell for activities, and newActivityCell for new activity
    // The first cell should be new activity
    if(indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"newActivityCell";
        RTNewActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // No activity name for new activity cell
        cell.label.text = @"";
        
        // Pass navigation controller for segues
        cell.navController = self.navigationController;
        
        // Pass project object
        cell.currentProj = proj;
        
        // Pass managedObjectContext
        cell.managedObjectContext = self.managedObjectContext;
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"activitiesCell";
        RTActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        // Sort subActivities
        NSSortDescriptor * sortActs = [NSSortDescriptor sortDescriptorWithKey:@"activity_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        subActivities = [subActivities sortedArrayUsingDescriptors:@[sortActs]];
        
        // Display activities
        Activities *act = [subActivities objectAtIndex:(indexPath.row-1)];
        cell.activityName.text = act.activity_name;
        
        // Pass navigation controller for segues
        cell.navController = self.navigationController;
        
        // Pass a cell's objects
        cell.currentProj = proj;
        cell.currentAct = act;
        
        // Pass managedObjectContext
        cell.managedObjectContext = self.managedObjectContext;
        
        return cell;
    }
}

// Setup section headers
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Projects * proj = [self.projects objectAtIndex:section];
    return proj.project_name;
}

// Disable editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// Refresh view every time
-(void)viewWillAppear:(BOOL)animated
{
    // Re-fetch from CoreData
    NSSortDescriptor * sortProjName = [NSSortDescriptor sortDescriptorWithKey:@"project_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    self.projects = [Projects retrieveProjectsWithPredicate:nil andSortDescriptor:sortProjName];
    self.activities = [Activities retrieveActivitiesWithPredicate:nil andSortDescriptor:nil];
    
    [self.table reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)newProject:(id)sender
{
    // Create view controller from storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RTAddEditProjectViewController *addEditProj = [sb instantiateViewControllerWithIdentifier:@"addEditProjectView"];
    
    // Set title to "new" and currentProj to nil
    addEditProj.title = @"New Project";
    addEditProj.currentProj = nil;
    
    // Pass down context
    addEditProj.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:addEditProj animated:YES];
    
}

@end
