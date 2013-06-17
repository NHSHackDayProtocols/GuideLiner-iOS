//
//  GLDataStore.h
//  GuideLiner
//
//  Created by James Foxlee on 17/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLDataStore : NSObject <UITableViewDataSource, NSURLConnectionDataDelegate>
{}

+ (GLDataStore *)sharedStore;

- (void)fetchHospitals;
- (void)logHospitals; // DEBUG method, remove

@end
