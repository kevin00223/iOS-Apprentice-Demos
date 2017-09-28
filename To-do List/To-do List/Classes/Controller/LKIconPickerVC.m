//
//  LKIconPickerVC.m
//  To-do List
//
//  Created by likai on 2017/9/26.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKIconPickerVC.h"

static NSString *cellID = @"cellID";

@interface LKIconPickerVC ()
{
    NSArray *_icons;
}

@end

@implementation LKIconPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _icons = @[
               @"No Icon",
               @"Appointments",
               @"Birthdays",
               @"Chores",
               @"Drinks",
               @"Folder",
               @"Groceries",
               @"Inbox",
               @"Photos",
               @"Trips"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *icon = _icons[indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(iconPicker:didSelectIcon:)]) {
        [self.delegate iconPicker:self didSelectIcon:_icons[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Choose Icon";
}

@end
