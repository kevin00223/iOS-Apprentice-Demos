//
//  LKAddItemVC.h
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

- (void)addItemVCDidCancel:(LKItemDetailVC *)addItemVC;
- (void)additemVC: (LKItemDetailVC *)addItemVC didFinishAddingItem: (LKChecklistModel *)item;
- (void)additemVC: (LKItemDetailVC *)addItemVC didFinishEditingItem: (LKChecklistModel *)item;

@end

@interface LKItemDetailVC : UITableViewController

@property (nonatomic, weak) id <LKItemDetailVCDelegate> delegate;
@property (nonatomic, strong) LKChecklistModel *itemToEdit;

@end
