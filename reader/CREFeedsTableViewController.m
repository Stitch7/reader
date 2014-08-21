//
//  CREFeedsTableViewController.m
//  reader
//
//  Created by Christopher Reitz on 17.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import "CREFeedsTableViewController.h"
#import "CREEntriesTableViewController.h"
#import "CREFeed.h"

@interface CREFeedsTableViewController ()
    @property (strong) NSMutableArray *feeds;
@end

@implementation CREFeedsTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self loadFeeds];
    
    if (!self.feeds) {
        self.feeds = [NSMutableArray array];
        
        NSString *title = @"Bits und so";
        NSURL * url = [NSURL URLWithString:@"http://www.bitsundso.de/feed/"];
        
        CREFeed *feed = [CREFeed feedWithTitle:title url:url];
        
        [self.feeds addObject:feed];
        
        [self saveFeeds];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];

//    CREFeed *feed = [self.feeds objectAtIndex:indexPath.row];
    CREFeed *feed = self.feeds[indexPath.row];
    
    cell.textLabel.text = feed.title;
    cell.detailTextLabel.text = [feed.url absoluteString];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.feeds removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

#pragma mark - Seque

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PushToEntries"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CREFeed *feed = self.feeds[indexPath.row];
        [segue.destinationViewController setFeed:feed];
    } else if ([segue.identifier isEqualToString:@"ModalToAddFeed"]) {
//        [segue.destinationViewController setDelegate: self];
        ((CREAddFeedTableViewController*)[[segue.destinationViewController viewControllers] objectAtIndex:0]).delegate = self;
    }
}


#pragma mark - Add Feed Delegate

- (void)addFeedTableViewControllerDidFinish:(CREAddFeedTableViewController *)inController feed:(CREFeed *)inFeed
{
    dispatch_block_t complete = nil;
    
    if (inFeed) {
        [self.feeds addObject:inFeed];
        [self.tableView reloadData];
    
        NSString *feedTitle = inFeed.title;
        
        complete = ^{
            NSString *message = [NSString stringWithFormat:@"Succesfully added feed: %@", feedTitle];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added Feed"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        };
        
        [self saveFeeds];
    }
    
    [self dismissViewControllerAnimated:YES completion:complete];
}


#pragma mark - Persistant State

- (NSURL*)applicationDataDirectory
{
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSApplicationSupportDirectory
                                             inDomains:NSUserDomainMask];
    NSURL* appSupportDir = nil;
    NSURL* appDirectory = nil;
    
    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        appSupportDir = [possibleURLs objectAtIndex:0];
    }
    
    // If a valid app support directory exists, add the
    // app's bundle ID to it to specify the final directory.
    if (appSupportDir) {
        NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    
    return appDirectory;
}

- (NSString*)pathToSavedFeeds
{
    NSURL *applicationSupportURL = [self applicationDataDirectory];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[applicationSupportURL path]]) {
        NSError *error = nil;
        
        [[NSFileManager defaultManager] createDirectoryAtPath:[applicationSupportURL path] withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"error creating app support dir: %@", error);
        }
    }
    
    NSString *path = [[applicationSupportURL path] stringByAppendingPathComponent:@"savedFeed.plist"];
    
    return path;
}

- (void)loadFeeds
{
    NSString *path = [self pathToSavedFeeds];
    NSLog(@"loadFeeds: %@", path);
    
    self.feeds = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)saveFeeds
{
    [NSKeyedArchiver archiveRootObject:self.feeds toFile:[self pathToSavedFeeds]]; 
}

@end
