//
//  CREDetailViewController.h
//  reader
//
//  Created by Christopher Reitz on 17.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CREEntry.h"


@interface CREDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) CREEntry *entry;

- (void)setNewEntry:(CREEntry*)inEntry;

@end
