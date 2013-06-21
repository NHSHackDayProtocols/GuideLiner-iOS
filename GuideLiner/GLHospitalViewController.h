//
//  GLHospitalViewController.h
//  GuideLiner
//
//  Created by James Foxlee on 17/06/2013.
//  Copyright (c) 2013 Goatfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLHospitalViewController : UITableViewController
{}

- (void)fetchHospitals;
- (void)fetchedData:(NSData *)responseData;

@end
