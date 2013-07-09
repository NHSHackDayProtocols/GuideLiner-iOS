//
//  GLOrganisationDataStore.m
//  GuideLiner
//
//  Created by James Foxlee on 20/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLOrganisation.h"
#import "GLOrganisationDataStore.h"
//#import "GLOrganisationSelectVC.h"

@implementation GLOrganisationDataStore
{
    NSMutableArray *_rawOrganisationData;
    NSMutableArray *_arrayKeys;
}

@synthesize dictIsSorted;
@synthesize organisationsDict = _organisationsDict;
@synthesize currentOrganisation = _currentOrganisation;

#pragma mark - Class methods

+ (GLOrganisationDataStore *)sharedStore
{
    static GLOrganisationDataStore *sharedStore = nil;
    
    @synchronized(self)
    {
        if(!sharedStore)
            sharedStore = [[GLOrganisationDataStore alloc] init];
    }
    
    return sharedStore;
}

#pragma mark - Initialisation

-(id)init
{
    self = [super init];
    
#warning Initialisation handling. Review once persistence finalised
    if(self)
    {
        _arrayKeys = [[NSMutableArray alloc] init];
        self.dictIsSorted = FALSE;
        self.organisationsDict = [[NSMutableDictionary alloc] init];
        // needs changing once persistence added
        self.currentOrganisation = nil;
    }
    return self;
}

#pragma mark - Debug/logging
 
- (void)logOrganisations
{
    NSLog(@"\nLogging organisations in data store...\n");
    for (NSString *key in _arrayKeys)
    {
        NSMutableArray *array = [self.organisationsDict objectForKey:key];
        for (GLOrganisation *org in array)
            NSLog(@"Org: %@", org.orgName);
    }

    
}

- (NSInteger)enumerateOrganisations
{
    NSInteger total = 0;
    
    for (NSString *key in _arrayKeys)
    {
        NSUInteger arrCount = [[self.organisationsDict objectForKey:key] count];
        total += arrCount;
    }
    NSLog(@"NUMBER OF ORGANISATIONS: %d", total);
    return total;
}

#pragma mark - Data manipulation & querying

- (void)parseOrganisationJSON:(NSData *)json
{
    dispatch_queue_t bgQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(bgQueue, ^{
        NSError *parseError;
        NSLog(@"Deserialising the received JSON on GCD...");
        _rawOrganisationData =
        [NSJSONSerialization JSONObjectWithData:json
                                        options:kNilOptions
                                          error:&parseError];
        if (!parseError)
        {
            NSLog(@"Finished JSON extract...");
            
            // iterate through the raw data array
            // unpack each dictionary, get the name and first letter
            for(NSDictionary *org in _rawOrganisationData)
            {
                NSString *orgName = [org objectForKey:@"name"];
                NSString *firstLetter = [orgName substringToIndex:1];
                
                // NSNumber shenanigans to get location into CLLocation object
                NSNumber *longObj = [org objectForKey:@"lng"];
                CLLocationDegrees lng = [longObj doubleValue];
                longObj = nil;
                NSNumber *latObj = [org objectForKey:@"lat"];
                CLLocationDegrees lat = [latObj doubleValue];
                latObj = nil;
                CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat
                                                             longitude:lng];
                
                // create the new GLOrganisation object
                GLOrganisation *newOrg = [[GLOrganisation alloc] initWithName:orgName andLocation:loc];
            
                // check if a dictionary with that first letter key exists
                BOOL containsKey = [_arrayKeys containsObject:firstLetter];
                if (containsKey)
                    // add org to array with that first letter key
                    [[self.organisationsDict objectForKey:firstLetter] addObject:newOrg];
                else
                {
                    // if not, add the new first letter to the keys array and
                    // create a new array for that letter
                    [_arrayKeys addObject:firstLetter];
                    NSMutableArray *newArray = [[NSMutableArray alloc] init];
                    [newArray addObject:newOrg];
                    [self.organisationsDict setObject:newArray forKey:firstLetter];
                }
            }
            _rawOrganisationData = nil;
            [self sortData];
        }
        else
            NSLog(@"Failed JSON parsing with error: %@",
                  [parseError localizedDescription]);
    });
}

- (void)sortData
{
    // sort the keys array using a ^block
    NSLog(@"\n*** Sorting keys array... ***");
    [_arrayKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        return [obj1 compare:obj2];
    }];
    
    // sort the arrays in the dict using descriptors
    NSLog(@"\n*** Sorting organisations... ***");
    
    NSSortDescriptor *orgSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orgName" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:orgSortDescriptor];
    
    for(NSString *firstLetter in _arrayKeys)
    {
        NSMutableArray *arrayForLetter =
            [self.organisationsDict objectForKey:firstLetter];
        [arrayForLetter sortUsingDescriptors:descriptors];
    }
    
    NSLog(@"\n*** Sorting done. ***");
    self.dictIsSorted = TRUE;
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrayKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.organisationsDict objectForKey:[_arrayKeys objectAtIndex:section]] count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_arrayKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Organisation_Cell"];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Organisation_Cell"];

    NSString *key = [_arrayKeys objectAtIndex:indexPath.section];
    NSMutableArray *array = [self.organisationsDict objectForKey:key];
    key = nil;
    GLOrganisation *org = [array objectAtIndex:indexPath.row];
    array = nil;
    cell.textLabel.text = org.orgName;
    
    return cell;
}

// Indexed list methods

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _arrayKeys;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [_arrayKeys indexOfObject:title];
}

@end
