//
//  GLHospitalDataStore.m
//  GuideLiner
//
//  Created by James Foxlee on 20/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLHospitalDataStore.h"
#import "GLHospitalSelectVC.h"

@implementation GLHospitalDataStore
{}

@synthesize hospitalList = _hospitalList;
@synthesize currentHospital = _currentHospital;

#pragma mark - Class methods

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

#pragma  mark - Debug/logging
 
- (void)logHospitals
{
    for (NSDictionary *hospital in self.hospitalList)
        NSLog(@"%@", [hospital objectForKey:@"name"]);
}

- (void)enumerateHospitals
{
    NSLog(@"NUMBER OF HOSPITALS: %d", [self.hospitalList count]);
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hospCount = [self.hospitalList count];
    NSLog(@"Number of hospitals: %d", hospCount);
    return hospCount;
    
}

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
