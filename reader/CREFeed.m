//
//  CREFeed.m
//  reader
//
//  Created by Christopher Reitz on 18.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import "CREFeed.h"

@implementation CREFeed

+ (id) feedWithTitle:(NSString*)inTitle url:(NSURL*)inURL;
{
    CREFeed *feed = [[CREFeed alloc] init];
    
    feed.title = inTitle;
    feed.url = inURL;
    
    return feed;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.url forKey:@"url"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (!(self = [super init])) {
        return nil;
    }
    
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.url   = [aDecoder decodeObjectForKey:@"url"];
    
    return self;
}

@end
