//
//  GLOrganisationDataStore.h
//  GuideLiner
//
//  Created by James Foxlee on 20/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLOrganisation.h"

@interface GLOrganisationDataStore : NSObject <UITableViewDataSource>
{}

@property BOOL dictIsSorted;
@property NSMutableDictionary *organisationsDict;
@property GLOrganisation *currentOrganisation;

+ (GLOrganisationDataStore *)sharedStore;

- (void)parseOrganisationJSON:(NSData *)json;
- (void)sortData;

// DEBUG METHODS

- (void)logOrganisations;
- (NSInteger)enumerateOrganisations;

@end
