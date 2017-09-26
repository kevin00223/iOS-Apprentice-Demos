//
//  LKIconPickerVC.h
//  To-do List
//
//  Created by likai on 2017/9/26.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKIconPickerVC;

@protocol LKIconPickerDelegate <NSObject>

- (void)iconPicker: (LKIconPickerVC *)iconPicker didSelectIcon: (NSString *)iconName;

@end

@interface LKIconPickerVC : UITableViewController

@property (nonatomic, weak) id <LKIconPickerDelegate> delegate;

@end
