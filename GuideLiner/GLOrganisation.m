//
//  GLOrganisation.m
//  GuideLiner
//
//  Created by James Foxlee on 03/07/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import "GLOrganisation.h"

@implementation GLOrganisation
{}

@synthesize orgName;
@synthesize orgLocation;


- (id)init
{
    // return default empty entry if init called
    return [self initWithName:@"empty" andLocation:[NSArray array]];
}

- (id)initWithName:(NSString *)name andLocation:(CLLocation *)loc
{
    self = [super init];
    if(self)
    {
        self.orgName = name;
        self.orgLocation = loc;
    }
    return self;
}

@end
