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
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        //说明该item已经设置了通知 就取消当前通知 重新设置通知
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemID" : @(self.itemID)};
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"Scheduled notification %@ for ItemID %ld", localNotification, (long)self.itemID);
    }
}

- (UILocalNotification *)notificationForThisItem
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications) {
        //通过itemID判断
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if (number != nil && [number integerValue] == self.itemID) {
            return notification;
        }
    }
    return nil;
}

//删除checklistItem/整个checkList时 会被调用
- (void)dealloc
{
    //对象方法, 因此是在该类的对象被销毁时被调用
    UILocalNotification *localNotification = [self notificationForThisItem];
    if (localNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    }
}

@end
