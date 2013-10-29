//
//  RTActivitiesViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/21/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTActivitiesViewController.h"

@interface RTActivitiesViewController ()

@end

@implementation RTActivitiesViewController

// CoreData
@synthesize fetchedResultsController, managedObjectContext;

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
    NSFetchRequest *fetchRequestPart = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *projs = [NSEntityDescription entityForName:@"Projects" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *acts = [NSEntityDescription entityForName:@"Activities" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *parts = [NSEntityDescription entityForName:@"Participations" inManagedObjectContext:managedObjectContext];
    
    [fetchRequestProj setEntity:projs];
    [fetchRequestAct setEntity:acts];
    [fetchRequestPart setEntity:parts];
    
    NSSortDescriptor * sortProjName = [NSSortDescriptor sortDescriptorWithKey:@"project_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [fetchRequestProj setSortDescriptors:[NSArray arrayWithObjects:sortProjName, nil]];
    
    NSError *err;
    self.projects = [managedObjectContext executeFetchRequest:fetchRequestProj error:&err];
    self.activities = [managedObjectContext executeFetchRequest:fetchRequestAct error:&err];
    self.participations = [managedObjectContext executeFetchRequest:fetchRequestPart error:&err];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.projects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int num = 0;
    
    Projects *proj = [self.projects objectAtIndex:section];
    
    for (Participations *part in self.participations) {
        if (part.activity.project == proj)
            num++;
    }
        
    // Return num
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequque dedicated cell
    static NSString *CellIdentifier = @"viewPartCell";
    RTViewParticipationsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Select all activities that belong to a project
    Projects * proj = [self.projects objectAtIndex:indexPath.section];
    NSPredicate * proj_name = [NSPredicate predicateWithFormat:@"activity.project.project_name == %@",proj.project_name];
    
    // Filter all participations belonging to this project
    NSArray * subParticipations = [self.participations filteredArrayUsingPredicate:proj_name];
    
    // Configure the cell...
    // Get one participation
    Participations *part = [subParticipations objectAtIndex:indexPath.row];
    
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    // Set labels
    cell.activityName.text = part.activity.activity_name;
    cell.date.text = [dateFormat stringFromDate:part.date];
    cell.menUnder15.text = [NSString stringWithFormat:@"%@",part.men_under_15];
    cell.men15To24.text = [NSString stringWithFormat:@"%@",part.men_15_to_24];
    cell.menAbove24.text = [NSString stringWithFormat:@"%@",part.men_above_24];
    cell.womenUnder15.text = [NSString stringWithFormat:@"%@",part.women_under_15];
    cell.women15To24.text = [NSString stringWithFormat:@"%@",part.women_15_to_24];
    cell.womenAbove24.text = [NSString stringWithFormat:@"%@",part.women_above_24];
    cell.notes.text = part.notes;
    
    return cell;
}

// Disable editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215;
}

- (IBAction)exportCSV:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Export CSV" message:@"Export CSV to innovation@peacecorps.gov" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Export!",nil];
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        // Export to email here!
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:?"]];
        
    }
}

@end
