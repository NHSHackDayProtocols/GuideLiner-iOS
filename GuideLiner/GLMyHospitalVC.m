//
//  GLChangeHospitalVC.m
//  GuideLiner
//
//  Created by James Foxlee on 23/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLMyHospitalVC.h"
#import "GLHospitalSelectVC.h"
#import "GLHospitalDataStore.h"
#import "Networking.h"

@interface GLMyHospitalVC ()

@end

@implementation GLMyHospitalVC
{
    NSMutableData *hospitalJSON;
    
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
    [self fetchHospitals];
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

#pragma mark - Data Connection & delegate

- (void)fetchHospitals
{
    hospitalJSON = [[NSMutableData alloc] init];
    
    NSURL *hospURL = [NSURL URLWithString:kHospitalListURL];
    NSLog(@"Trying to connect to URL %@...", hospURL);
    NSURLRequest *req = [[NSURLRequest alloc]
                         initWithURL:hospURL
                         cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                         timeoutInterval:60];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    connection = nil;
    hospitalJSON = nil;
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed with error: %@", [error localizedDescription]];
    NSLog(@"%@", errorString);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Collecting some JSON...");
    [hospitalJSON appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Connection complete...");
    [self fetchedData:hospitalJSON];
}

- (void)fetchedData:(NSData *)responseData
{
    NSError *parseError;
    NSLog(@"Deseriaising the received JSON...");
    [GLHospitalDataStore sharedStore].hospitalList =
    [NSJSONSerialization JSONObjectWithData:responseData
                                    options:kNilOptions
                                      error:&parseError];
    
    // dispose of the JSON
    responseData = nil;
    [[GLHospitalDataStore sharedStore] enumerateHospitals];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
