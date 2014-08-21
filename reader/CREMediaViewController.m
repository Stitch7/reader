//
//  CREMediaViewController.m
//  reader
//
//  Created by Christopher Reitz on 21.08.14.
//  Copyright (c) 2014 Christopher Reitz. All rights reserved.
//

#import "CREMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CREMediaViewController ()
@property (strong) MPMoviePlayerController *player;
@end

@implementation CREMediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL: self.enclosureURL];
    [self.player prepareToPlay];
    [self.player.view setFrame: self.view.bounds];  // player's frame must match parent's
    [self.view addSubview: self.player.view];
    [self.player play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
