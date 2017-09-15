//
//  LKListDetailVC.h
//  To-do List
//
//  Created by likai on 2017/9/14.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKChecklist.h"
@class LKListDetailVC;

@protocol LKListDetailDelegate <NSObject>

- (void)listDetail: (LKListDetailVC *)listDetail didEditList: (LKChecklist *)list;
- (void)listDetail: (LKListDetailVC *)listDetail didAddList: (LKChecklist *)list;

@end

@interface LKListDetailVC : UITableViewController

@property (nonatomic, strong) LKChecklist *listToEidt;
@property (nonatomic, weak) id<LKListDetailDelegate> delegate;

@end
