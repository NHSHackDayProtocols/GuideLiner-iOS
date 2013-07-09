//
//  GLOrganisation.h
//  GuideLiner
//
//  Created by James Foxlee on 03/07/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GLOrganisation : NSObject

@property NSString *orgName;
@property CLLocation *orgLocation;

- (id)initWithName:(NSString *)name andLocation:(CLLocation *)loc;


@end
