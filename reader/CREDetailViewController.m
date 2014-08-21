//
//  CREDetailViewController.m
//  reader
//
//  Created by Christopher Reitz on 17.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import "CREDetailViewController.h"

@interface CREDetailViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation CREDetailViewController

#pragma mark - Managing the detail item


- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.entry) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.entry.link];
        [self.webView loadRequest:request];
    }
}

- (void)setNewEntry:(CREEntry*)inEntry
{
    if (self.entry != inEntry) {
        self.entry = inEntry;
        [self configureView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.webView setDelegate:self];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Web View Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
