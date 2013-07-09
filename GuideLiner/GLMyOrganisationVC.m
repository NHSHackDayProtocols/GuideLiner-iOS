//
//  GLMyOrganisationVC.m
//  GuideLiner
//
//  Created by James Foxlee on 23/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLMyOrganisationVC.h"
#import "GLOrganisationSelectVC.h"
#import "GLOrganisationDataStore.h"
#import "Networking.h"

@interface GLMyOrganisationVC ()

@end

@implementation GLMyOrganisationVC
{
    NSMutableData *_organisationsJSON;
    NSURLConnection *_URLConnection;
    
    __weak IBOutlet UILabel *_labelCurrentOrganisation;
}

#pragma mark - Initialisation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *myOrgImage = [UIImage imageNamed:@"SetHome_30_30.png"];
        UITabBarItem *myOrgBarItem = [[UITabBarItem alloc] initWithTitle:@"My Organisation" image:myOrgImage tag:1];
        self.tabBarItem = myOrgBarItem;
    }
    return self;
}

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fetchOrganisations];
}

#pragma mark - Buttons

- (IBAction)selectNearbyTapped:(id)sender
{
    NSLog(@"Select Nearby tapped");
}

- (IBAction)selectFromListTapped:(id)sender {
    NSLog(@"Select From List tapped");
    if (![[GLOrganisationDataStore sharedStore] dictIsSorted]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No hospital list" message:@"The data may still be downloading, or there may be no internet connection." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        GLOrganisationSelectVC *orgSelectVC = [[GLOrganisationSelectVC alloc] init];
        [self presentViewController:orgSelectVC animated:YES completion:nil];
    }
}

#pragma mark - Data Connection & delegate

- (void)fetchOrganisations
{
    _organisationsJSON = [[NSMutableData alloc] init];
    
    NSURL *orgURL = [NSURL URLWithString:kOrganisationsListURL];
    NSLog(@"Trying to connect to URL %@...", orgURL);
    NSURLRequest *req = [[NSURLRequest alloc]
                         initWithURL:orgURL
                         cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                         timeoutInterval:60];
    _URLConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    connection = nil;
    _organisationsJSON = nil;
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed with error: %@", [error localizedDescription]];
    NSLog(@"%@", errorString);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_organisationsJSON appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Connection complete...");
    connection = nil;
    [[GLOrganisationDataStore sharedStore] parseOrganisationJSON:_organisationsJSON];
    _organisationsJSON = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
