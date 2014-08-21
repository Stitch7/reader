//
//  CREFeed.h
//  reader
//
//  Created by Christopher Reitz on 18.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CREFeed : NSObject <NSCoding>

@property (strong) NSString *title;
@property (strong) NSURL *url;

+ (id) feedWithTitle:(NSString*)inTitle url:(NSURL*)inURL;

@end
