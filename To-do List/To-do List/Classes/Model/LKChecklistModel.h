//
//  LKChecklistModel.h
//  To-do List
//
//  Created by likai on 2017/6/27.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKChecklistModel : NSObject

@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *image;

+ (instancetype) checklistWithDict: (NSDictionary *)dict;

@end
