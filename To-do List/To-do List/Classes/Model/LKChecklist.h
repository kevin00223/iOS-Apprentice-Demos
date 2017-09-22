//
//  LKChecklist.h
//  To-do List
//
//  Created by likai on 2017/9/14.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKChecklistItem.h"

@interface LKChecklist : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, strong) NSMutableArray<LKChecklistItem *> *items;

- (int)countUntoggledItems;

@end
