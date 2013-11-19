//
//  RTPendingViewController.m
//  RealTrack
//
//  Created by Chenheli Hua on 10/21/13.
//  Copyright (c) 2013 Peace Corps. All rights reserved.
//

#import "RTPendingViewController.h"

@interface RTPendingViewController ()

@end

@implementation RTPendingViewController

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
    
    // Start a new query of all past due events through eventStore.
    // I tried to pass the queried EKEvent array in IndexViewController to PendingViewController.
    // However, doing so makes accessing eventIdentifier for individual events fail. Reasons unknown.
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    NSString * calID = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendarIdentifier"];
    EKCalendar *cal = [eventStore calendarWithIdentifier:calID];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:[[NSDate date] dateByAddingTimeInterval:-3600*24*365*2] endDate:[NSDate date] calendars:@[cal]];
    self.events = [eventStore eventsMatchingPredicate:predicate];
    
    // Sort events by time
    NSSortDescriptor * timeDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
    self.events = [self.events sortedArrayUsingDescriptors:@[timeDescriptor]];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pendingCell";
    RTPendingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.currentEvent = [self.events objectAtIndex:indexPath.row];
    
    // Get Events object and related activity & project
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"event_id == %@", cell.currentEvent.eventIdentifier];
    NSArray * evArr = [Events retrieveEventsWithPredicate:pred andSortDescriptor:nil];

    Events * ev = [evArr objectAtIndex:0];
    cell.currentAct = ev.activity;
    cell.currentProj = cell.currentAct.project;
    cell.date = cell.currentEvent.startDate;
    
    // Pass down navigation controller & managed obj context
    cell.navController = self.navigationController;
    cell.managedObjectContext = self.managedObjectContext;
    
    // Date format
    NSDateFormatter * eventDate = [[NSDateFormatter alloc] init];
    [eventDate setDateFormat:@"MM/dd/yyyy"];
    
    cell.title.text = [NSString stringWithFormat:@"%@ on %@", cell.currentEvent.title, [eventDate stringFromDate:cell.currentEvent.startDate]];
    
    return cell;
    
}

// Disable editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// Refresh view every time
-(void)viewWillAppear:(BOOL)animated
{
    // TO DO: Reload data and refresh page
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
