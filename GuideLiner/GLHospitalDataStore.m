//
//  GLHospitalDataStore.m
//  GuideLiner
//
//  Created by James Foxlee on 20/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLHospitalDataStore.h"
#import "GLHospitalViewController.h"

@implementation GLHospitalDataStore
{}

@synthesize hospitalList = _hospitalList;

+ (GLHospitalDataStore *)sharedStore
{
    static GLHospitalDataStore *sharedStore = nil;
    
    @synchronized(self)
    {
        if(!sharedStore)
            sharedStore = [[GLHospitalDataStore alloc] init];
    }
    return sharedStore;
}

#pragma mark - UITableViewDataSource

#warning - Incomplete implementation
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#warning - Incomplete implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hospCount = [self.hospitalList count];
    NSLog(@"Number of hospitals: %d", hospCount);
    return hospCount;
    
}

#warning - Incomplete implementation
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hospital_Cell"];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Hospital_Cell"];

    cell.textLabel.text = [[self.hospitalList objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

@end
