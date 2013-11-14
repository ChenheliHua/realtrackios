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
    
    NSSortDescriptor * sortProjName = [NSSortDescriptor sortDescriptorWithKey:@"project_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    self.projects = [Projects retrieveProjectsWithPredicate:nil andSortDescriptor:sortProjName];
    self.activities = [Activities retrieveActivitiesWithPredicate:nil andSortDescriptor:nil];
    self.participations = [Participations retrieveParticipationWithPredicate:nil andSortDescriptor:nil];
    
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
    
    // Extract activities that belongs to that project
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"activity.project == %@",proj];
    num = [[self.participations filteredArrayUsingPredicate:pred] count];
    
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
    
    [cell setActivityName:part.activity.activity_name date:part.date memUnder15:part.men_under_15 men15To24:part.men_15_to_24 menAbove24:part.men_above_24 womenUnder15:part.women_under_15 women15To24:part.women_15_to_24 womenAbove24:part.women_above_24 notes:part.notes];
    
    return cell;
}

// Disable editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215;
}

// Ask for confimation
- (IBAction)exportCSV:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Export CSV" message:@"Export CSV to innovation@peacecorps.gov" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Export!",nil];
    
    [alert show];

}

// If Export! is clicked, do export
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        // Check if the phone is configured for mail
        if (![MFMailComposeViewController canSendMail]) {
            NSString *errorTitle = @"Error";
            NSString *errorString = @"This device is not configured to send email.";
            UIAlertView *errorView =
            [[UIAlertView alloc] initWithTitle:errorTitle
                                       message:errorString delegate:self cancelButtonTitle:nil
                             otherButtonTitles:@"OK", nil];
            [errorView show];
        } else {
            // Create mail view
            MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
            mailView.mailComposeDelegate = self;
            [mailView setSubject:@"Real Track CSV"];
            [mailView setMessageBody:@"This is a message" isHTML:NO];
            
            // Get csv data in string format
            NSString* csv = [self getCSVString];
            NSData * data = [csv dataUsingEncoding:NSUTF8StringEncoding];
            
            // Removed trailing \0
            data = [data subdataWithRange:NSMakeRange(0,[data length]-1)];
            [mailView addAttachmentData:data mimeType:@"text/csv" fileName:@"realtrackios.csv"]; // Added CSV file here
            [mailView setToRecipients:[NSArray arrayWithObjects:@"innovation@peacecorps.gov",nil]];
            [self presentViewController:mailView animated:YES completion:nil];
        }
        
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // If any error
    if (error) {
        NSString *errorTitle = @"Mail Error";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc]
                                  initWithTitle:errorTitle
                                  message:errorDescription
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
        [errorView show];
        
    } else {
        // Setup MFMailComposeResult to export csv
        switch (result)
        {
            case MFMailComposeResultSent:
            {
                // Send email
                UIAlertView * sent = [[UIAlertView alloc] initWithTitle:@"CSV Sent!" message:@"Your .csv file has been sent!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [sent show];
                break;
            }
            case MFMailComposeResultSaved:
            {
                // Save email
                UIAlertView * saved = [[UIAlertView alloc] initWithTitle:@"CSV Saved!" message:@"Your .csv file has been saved!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [saved show];
                break;
            }
            case MFMailComposeResultCancelled:
            {
                // Do nothing
                break;
            }
            case MFMailComposeResultFailed:
            {
                // Do nothing
                UIAlertView * failed = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Failed to send your .csv file.!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [failed show];
                break;
            }
        }
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}


// Return a string representation of csv data
-(NSString *)getCSVString
{
    
    // For date format
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableString * csv = [NSMutableString stringWithString:@"Project, Activity, Date, Men Under 15, Men 15 To 24, Men Above 24, Women Under 15, Women 15 To 24, Women Above 24, Notes\n"];
    
    for(Participations *part in self.participations)
    {
        // Appened each participation
        [csv appendString:[NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@\n",
                           part.activity.project.project_name, part.activity.activity_name, [dateFormat stringFromDate:part.date],
                           part.men_under_15, part.men_15_to_24, part.men_above_24,
                           part.women_under_15, part.women_15_to_24, part.women_above_24,
                           part.notes]];
    }
    
    return csv;
}

@end
