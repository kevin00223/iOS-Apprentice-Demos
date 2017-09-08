//
//  LKAddItemVC.h
//  To-do List
//
//  Created by likai on 2017/8/3.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKChecklistModel.h"

@class LKAddItemVC;
@class LKChecklistModel;

@protocol LKAddItemVCDelegate <NSObject>

- (void)addItemVCDidCancel:(LKAddItemVC *)addItemVC;
- (void)additemVC: (LKAddItemVC *)addItemVC didFinishAddingItem: (LKChecklistModel *)item;
- (void)additemVC: (LKAddItemVC *)addItemVC didFinishEditingItem: (LKChecklistModel *)item;

@end

@interface LKAddItemVC : UITableViewController

@property (nonatomic, weak) id <LKAddItemVCDelegate> delegate;
@property (nonatomic, strong) LKChecklistModel *itemToEdit;

@end
