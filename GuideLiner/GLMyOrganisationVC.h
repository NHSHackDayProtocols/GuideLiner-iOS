//
//  GLMyOrganisationVC.h
//  GuideLiner
//
//  Created by James Foxlee on 23/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLMyOrganisationVC : UIViewController <NSURLConnectionDataDelegate>

- (IBAction)selectNearbyTapped:(id)sender;
- (IBAction)selectFromListTapped:(id)sender;

- (void)fetchOrganisations;
- (void)parseOrganisationJSON:(NSData *)json;

@end
