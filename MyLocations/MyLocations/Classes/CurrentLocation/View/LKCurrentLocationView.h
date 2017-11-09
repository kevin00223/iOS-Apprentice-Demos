//
//  LKCurrentLocationView.h
//  MyLocations
//
//  Created by likai on 09/11/2017.
//  Copyright © 2017 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKCurrentLocationView : UIView

@property (weak, nonatomic) IBOutlet UILabel *MessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *LatitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagLocBtn;
@property (weak, nonatomic) IBOutlet UIButton *getLocBtn;

- (IBAction)tagLocation:(id)sender;
- (IBAction)getLocation:(id)sender;

@end
