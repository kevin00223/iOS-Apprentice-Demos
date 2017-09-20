//
//  LKDataModel.h
//  To-do List
//
//  Created by likai on 2017/9/20.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKDataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)saveDataToFile;

@end
