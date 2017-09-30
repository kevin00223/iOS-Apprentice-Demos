//
//  LKChecklistItem.h
//  To-do List
//
//  Created by likai on 2017/6/27.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKChecklistItem : NSObject <NSCoding>

@property (nonatomic, copy)NSString *text;
@property (nonatomic, assign)BOOL show;

//LocalNotification
@property (nonatomic, copy)NSDate *dueDate;
@property (nonatomic, assign)BOOL shouldRemind;
@property (nonatomic, assign)NSInteger itemID;

- (void)scheduleNotifications;

@end
