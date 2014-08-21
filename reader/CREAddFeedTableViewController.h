//
//  CREAddFeedTableViewController.h
//  reader
//
//  Created by Christopher Reitz on 20.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CREFeed;

@protocol CREAddFeedTableViewControllerDelegate;

@interface CREAddFeedTableViewController : UITableViewController

@property (weak) id<CREAddFeedTableViewControllerDelegate> delegate;

@end

@protocol CREAddFeedTableViewControllerDelegate <NSObject>

- (void) addFeedTableViewControllerDidFinish:(CREAddFeedTableViewController*)inController feed:(CREFeed*)inFeed;

@end