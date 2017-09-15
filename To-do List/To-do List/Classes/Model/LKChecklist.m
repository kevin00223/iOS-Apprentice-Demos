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
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
    }
    return self;
}

@end
