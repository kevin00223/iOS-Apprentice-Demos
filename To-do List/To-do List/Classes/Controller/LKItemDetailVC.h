//
//  LKitemDetailVC.h
//  To-do List
//
//  Created by likai on 2017/8/3.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKChecklistModel.h"

@class LKItemDetailVC;
@class LKChecklistModel;

@protocol LKItemDetailVCDelegate <NSObject>

- (void)itemDetailVCDidCancel:(LKItemDetailVC *)itemDetailVC;
- (void)itemDetailVC: (LKItemDetailVC *)itemDetailVC didFinishAddingItem: (LKChecklistModel *)item;
- (void)itemDetailVC: (LKItemDetailVC *)itemDetailVC didFinishEditingItem: (LKChecklistModel *)item;

@end

@interface LKItemDetailVC : UITableViewController

@property (nonatomic, weak) id <LKItemDetailVCDelegate> delegate;
@property (nonatomic, strong) LKChecklistModel *itemToEdit;

@end
