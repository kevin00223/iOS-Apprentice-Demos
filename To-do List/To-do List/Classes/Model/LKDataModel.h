//
//  LKDataModel.h
//  To-do List
//
//  Created by likai on 2017/9/20.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKChecklist.h"

@interface LKDataModel : NSObject

@property (nonatomic, strong) NSMutableArray <LKChecklist *> *lists;

- (void)saveDataToFile;

//保存用户数据
- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist: (NSInteger)index;\

//对checklist进行排序
- (void)sortChecklists;


@end
