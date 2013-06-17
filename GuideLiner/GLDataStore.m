//
//  GLDataStore.m
//  GuideLiner
//
//  Created by James Foxlee on 17/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLDataStore.h"
#import "Networking.h"

@implementation GLDataStore
{
    NSMutableData *hospitalsJSON;
    NSMutableArray *hospitalList;
    
    NSURLConnection *connection;
}

#pragma mark - Class methods

+ (GLDataStore *)sharedStore
{
    static GLDataStore *sharedStore;
    
    @synchronized(self)
    {
        if (!sharedStore)
        {
            NSLog(@"Shared store not in existence. Creating..."); // DEBUG
            sharedStore = [[GLDataStore alloc] init];
        }
        else // DEBUG
            NSLog(@"Shared store exists. Returning..."); 
    }
    return sharedStore;
}

#pragma mark - Initialisation

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self fetchHospitals];
    }
    
    return self;
}

- (void)fetchHospitals
{
    hospitalsJSON = [[NSMutableData alloc] init];
    
    // request the JSON
    NSURL *hospURL = [NSURL URLWithString:kHospitalListURL];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:hospURL];
    connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:true];
    
}

- (void)logHospitals
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    #warning Implement properly!!!
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    #warning Implement properly!!!
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    #warning Implement properly!!!
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *dataCheck = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", dataCheck);
}

@end
