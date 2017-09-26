//
//  LKChecklist.m
//  To-do List
//
//  Created by likai on 2017/9/14.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKChecklist.h"

@implementation LKChecklist

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.items = [NSMutableArray array];
        self.iconName = @"No Icon";
    }
    return self;
}

- (int)countUntoggledItems
{
    int count = 0;
    for (LKChecklistItem *item in self.items) {
        if (!item.show) {
            count++;
        }
    }
    return count;
}

- (NSComparisonResult)compare: (LKChecklist *)otherChecklist
{
    return [self.name localizedCompare:otherChecklist.name];
}

@end
