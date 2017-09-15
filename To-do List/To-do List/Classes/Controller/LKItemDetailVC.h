//
//  LKitemDetailVC.h
//  To-do List
//
//  Created by likai on 2017/8/3.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKChecklistItem.h"

@class LKItemDetailVC;
@class LKChecklistItem;

@protocol LKItemDetailVCDelegate <NSObject>

- (void)itemDetailVCDidCancel:(LKItemDetailVC *)itemDetailVC;
- (void)itemDetailVC: (LKItemDetailVC *)itemDetailVC didFinishAddingItem: (LKChecklistItem *)item;
- (void)itemDetailVC: (LKItemDetailVC *)itemDetailVC didFinishEditingItem: (LKChecklistItem *)item;

@end

@interface LKItemDetailVC : UITableViewController

@property (nonatomic, weak) id <LKItemDetailVCDelegate> delegate;
@property (nonatomic, strong) LKChecklistItem *itemToEdit;

@end
