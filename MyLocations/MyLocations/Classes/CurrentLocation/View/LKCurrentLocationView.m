//
//  LKCurrentLocationView.m
//  MyLocations
//
//  Created by likai on 09/11/2017.
//  Copyright © 2017 yinbake. All rights reserved.
//

#import "LKCurrentLocationView.h"

@implementation LKCurrentLocationView


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    NSLog(@"ui gets setup");
}


- (IBAction)tagLocation:(id)sender {
    NSLog(@"tagLocBtn clicked");
}

- (IBAction)getLocation:(id)sender {
    NSLog(@"getLocBtn clicked");
}
@end
