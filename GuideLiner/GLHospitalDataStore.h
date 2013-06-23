//
//  GLHospitalDataStore.h
//  GuideLiner
//
//  Created by James Foxlee on 20/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLHospitalDataStore : NSObject <UITableViewDataSource>
{}

@property NSMutableArray *hospitalList;
@property NSString *currentHospital;

+ (GLHospitalDataStore *)sharedStore;

- (void)logHospitals;
- (void)enumerateHospitals;

@end
