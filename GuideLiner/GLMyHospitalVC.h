//
//  GLChangeHospitalVC.h
//  GuideLiner
//
//  Created by James Foxlee on 23/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLMyHospitalVC : UIViewController <NSURLConnectionDataDelegate>

- (IBAction)selectNearbyTapped:(id)sender;
- (IBAction)selectFromListTapped:(id)sender;

- (void)fetchHospitals;
- (void)fetchedData:(NSData *)responseData;

@end
