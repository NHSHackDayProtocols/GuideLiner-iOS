//
//  GLChangeHospitalVC.m
//  GuideLiner
//
//  Created by James Foxlee on 23/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLMyHospitalVC.h"
#import "GLHospitalSelectVC.h"

@interface GLMyHospitalVC ()

@end

@implementation GLMyHospitalVC
{
    __weak IBOutlet UILabel *labelCurrentHospital;
}

#pragma mark - Initialisation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *myHospitalImage = [UIImage imageNamed:@"SetHome_30_30.png"];
        UITabBarItem *myHospitalBarItem = [[UITabBarItem alloc] initWithTitle:@"My Hospital" image:myHospitalImage tag:1];
        self.tabBarItem = myHospitalBarItem;
    }
    return self;
}

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Buttons

- (IBAction)selectNearbyTapped:(id)sender
{
    NSLog(@"Select Nearby tapped");
}

- (IBAction)selectFromListTapped:(id)sender {
    NSLog(@"Select From List tapped");
    GLHospitalSelectVC *hospitalSelectVC = [[GLHospitalSelectVC alloc] init];
    [self presentViewController:hospitalSelectVC animated:YES completion:nil];
    
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
