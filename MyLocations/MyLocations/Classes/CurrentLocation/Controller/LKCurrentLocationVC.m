//
//  LKCurrentLocationVC.m
//  MyLocations
//
//  Created by likai on 08/11/2017.
//  Copyright © 2017 yinbake. All rights reserved.
//

#import "LKCurrentLocationVC.h"
#import "LKCurrentLocationView.h"

@interface LKCurrentLocationVC ()

@end

@implementation LKCurrentLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LKCurrentLocationView *currentLocationView = [[NSBundle mainBundle] loadNibNamed:@"LKCurrentLocation" owner:nil options:nil].lastObject;
    self.view = currentLocationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
