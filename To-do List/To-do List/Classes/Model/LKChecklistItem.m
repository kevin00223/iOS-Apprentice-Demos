//
//  LKChecklistItem.m
//  To-do List
//
//  Created by likai on 2017/6/27.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKChecklistItem.h"
#import "LKDataModel.h"

@implementation LKChecklistItem

- (instancetype)init
{
    if (self = [super init]) {
        self.itemID = [LKDataModel nextChecklistItemID];
    }
    return self;
}

//保存数据
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.show forKey:@"Show"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInteger:self.itemID forKey:@"ItemID"];
}

//获取数据
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.show = [aDecoder decodeBoolForKey:@"Show"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemID = [aDecoder decodeIntegerForKey:@"ItemID"];
    }
    return self;
}

- (void)scheduleNotifications
{
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        
    }
}

@end
