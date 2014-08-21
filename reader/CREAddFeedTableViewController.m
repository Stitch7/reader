//
//  CREAddFeedTableViewController.m
//  reader
//
//  Created by Christopher Reitz on 20.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import "CREAddFeedTableViewController.h"
#import "CREFeed.h"

@interface CREAddFeedTableViewController ()
    @property (weak, nonatomic) IBOutlet UITextField *urlTextField;
    @property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@end

@implementation CREAddFeedTableViewController

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


#pragma mark - Actions

- (IBAction)cancelAction:(id)sender
{
    [self.delegate addFeedTableViewControllerDidFinish:self feed:nil];
}

- (IBAction)doneAction:(id)sender
{
    CREFeed *newFeed = nil;
    
    if ([self.urlTextField.text length] && [self.titleTextField.text length]) {
        newFeed = [CREFeed feedWithTitle:self.titleTextField.text url:[NSURL URLWithString:self.urlTextField.text]];
    }
    
    [self.delegate addFeedTableViewControllerDidFinish:self feed:newFeed];
}

@end
