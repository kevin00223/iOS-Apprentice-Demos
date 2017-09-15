//
//  LKChecklistItem.m
//  To-do List
//
//  Created by likai on 2017/6/27.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKChecklistItem.h"

@implementation LKChecklistItem

//+ (instancetype)checklistWithDict:(NSDictionary *)dict
//{
//    LKChecklistItem *model = [[LKChecklistItem alloc]init];
//    [model setValuesForKeysWithDictionary:dict];
//    return model;
//}

//保存数据
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.show forKey:@"Show"];
}

//获取数据
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.show = [aDecoder decodeBoolForKey:@"Show"];
    }
    return self;
}

@end
