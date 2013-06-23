//
//  GLSyncVC.m
//  GuideLiner
//
//  Created by James Foxlee on 23/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLSyncVC.h"

@interface GLSyncVC ()

@end

@implementation GLSyncVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *syncImage = [UIImage imageNamed:@"Sync_30_30.png"];
        UITabBarItem *syncBarItem = [[UITabBarItem alloc] initWithTitle:@"Check Updates" image:syncImage tag:2];
        self.tabBarItem = syncBarItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
