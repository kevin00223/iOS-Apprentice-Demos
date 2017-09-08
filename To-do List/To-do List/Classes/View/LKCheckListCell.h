//
//  LKCheckListCell.h
//  To-do List
//
//  Created by likai on 2017/9/7.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKCheckListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *toggleLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;

@end
