//
//  CREEntriesTableViewController.h
//  reader
//
//  Created by Christopher Reitz on 18.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CREFeed;

@interface CREEntriesTableViewController : UITableViewController <NSXMLParserDelegate>

@property (strong) CREFeed *feed;

@end
