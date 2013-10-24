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

    // Fetch all projects and activities information
    RTAppDelegate *appDelegate = (RTAppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequestProj = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequestAct = [[NSFetchRequest alloc] init];

    NSEntityDescription *projs = [NSEntityDescription entityForName:@"Projects" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *acts = [NSEntityDescription entityForName:@"Activities" inManagedObjectContext:managedObjectContext];
    
    [fetchRequestProj setEntity:projs];
    [fetchRequestAct setEntity:acts];
    NSError *err;
    
    self.projects = [managedObjectContext executeFetchRequest:fetchRequestProj error:&err];
    self.activities = [managedObjectContext executeFetchRequest:fetchRequestAct error:&err];
    
    // Test if fetch works
    for (Projects *proj in self.projects) {
        NSLog(@"Project Name: %@", proj.project_name);
    }

    for (Activities *act in self.activities) {
        NSLog(@"Activity Name: %@", act.activity_name);
    }
    
    /*
    Activities * newAct5 = [NSEntityDescription insertNewObjectForEntityForName:@"Activities" inManagedObjectContext:self.managedObjectContext];
    newAct5.activity_name = @"Act No 5";
    [self.projects[1] addActivitiesObject:newAct5];
    [managedObjectContext save:&err];
    */
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    Projects *proj = self.projects[section];
    
    for (Activities *act in self.activities) {
        if (act.project == proj)
            num++;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"activitiesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"# of projects: %d",[self.projects count]);
    NSLog(@"# of activities: %d",[self.activities count]);
    
    // Configure the cell...
    Activities *act = [self.activities objectAtIndex:indexPath.row];
    
    cell.textLabel.text = act.activity_name;
    
    return cell;
}

// Setup section headers
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Projects * proj = [self.projects objectAtIndex:section];
    return proj.project_name;
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

@end
