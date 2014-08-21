//
//  CREEntriesTableViewController.m
//  reader
//
//  Created by Christopher Reitz on 18.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import "CREEntriesTableViewController.h"
#import "CREDetailViewController.h"
#import "CREFeed.h"
#import "CREEntry.h"

@interface CREEntriesTableViewController ()
    @property (strong) NSMutableArray *entries;
    @property (strong) NSXMLParser *xmlParser;
    @property (strong) CREEntry *currentEntry;
    @property (strong) NSString *currentString;
@end

@implementation CREEntriesTableViewController

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
    
    self.entries = [NSMutableArray array];
    
    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:self.feed.url];
    [self.xmlParser setDelegate:self];
    [self.xmlParser parse];
    
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
    return [self.entries count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
    
//    cell.textLabel.text = ((CREEntry*)[self.entries objectAtIndex:indexPath.row]).title;
    cell.textLabel.text = ((CREEntry*)self.entries[indexPath.row]).title;
    
    return cell;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - XML Parser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"]) {
        self.currentEntry = [[CREEntry alloc] init];
    }
    
    self.currentString = nil;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        [self.entries addObject:self.currentEntry];
        self.currentEntry = nil;
    } else if ([elementName isEqualToString:@"title"]) {
        self.currentEntry.title = self.currentString;
    } else if ([elementName isEqualToString:@"link"]) {
        self.currentEntry.link = [NSURL URLWithString:self.currentString];
    }
    
    self.currentString = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentString != nil) {
        self.currentString = [self.currentString stringByAppendingString:string];
    } else {
        self.currentString = string;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.tableView reloadData];
}


#pragma mark - Seque

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PushToDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CREEntry *entry = self.entries[indexPath.row];
        [segue.destinationViewController setEntry:entry];
    }
}

@end
