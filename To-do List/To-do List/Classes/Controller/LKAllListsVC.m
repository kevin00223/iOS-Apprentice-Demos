//
//  LKAllListsVC.m
//  To-do List
//
//  Created by likai on 2017/9/14.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKAllListsVC.h"
#import "LKCheckListTableVC.h"
#import "LKChecklist.h"
#import "LKListDetailVC.h"
#import "LKNavigationController.h"

static NSString *cellID = @"cellID";

@interface LKAllListsVC () <LKListDetailDelegate, UINavigationControllerDelegate>


@end

@implementation LKAllListsVC 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册单元格
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

//- (instancetype)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewStylePlain];
//    if (self) {
//        [self loadChecklists];
//    }
//    return self;
//}
//
////加载数据
//- (void)loadChecklists
//{
//    NSString *path = [self dataFilePath];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//        _lists = [unarchiver decodeObjectForKey:@"AllLists"];
//        [unarchiver finishDecoding];
////        _lists = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//
//    }else{
//        _lists = [NSMutableArray array];
//        LKChecklist *list;
//        
//        list = [[LKChecklist alloc]init];
//        list.name = @"Birthdays";
//        [_lists addObject:list];
//        
//        list = [[LKChecklist alloc]init];
//        list.name = @"Groceries";
//        [_lists addObject:list];
//        
//        list = [[LKChecklist alloc]init];
//        list.name = @"Cool Apps";
//        [_lists addObject:list];
//        
//        list = [[LKChecklist alloc]init];
//        list.name = @"To Do";
//        [_lists addObject:list];
//    
//        for (LKChecklist *list in _lists) {
//            LKChecklistItem *item = [[LKChecklistItem alloc]init];
//            item.text = [NSString stringWithFormat:@"Item for %@", list.name];
//            [list.items addObject:item];
//        }
//    }
//}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKChecklist *list = self.dataModel.lists[indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = list.name;
    cell.imageView.image = [UIImage imageNamed:list.iconName];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    if (list.items.count == 0) {
        cell.detailTextLabel.text = @"(No Items)";
    }else if([list countUntoggledItems] == 0){
        cell.detailTextLabel.text = @"All Done";
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d remaining", [list countUntoggledItems]];
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    
    LKCheckListTableVC *vc = [[LKCheckListTableVC alloc]initWithStyle:UITableViewStyleGrouped];
    LKChecklist *model = self.dataModel.lists[indexPath.row];
    vc.checklist = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObject:self.dataModel.lists[indexPath.row]];
    //保存数据
//    [self saveDataToFile];
//    [self saveData:_lists];
    NSArray *indexpaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - LKListDetailDelegate
- (void)listDetail:(LKListDetailVC *)listDetail didEditList:(LKChecklist *)list
{
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    
//    NSInteger index = [self.dataModel.lists indexOfObject:list];
    //保存数据
//    [self saveDataToFile];
//    [self saveData:_lists];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = list.name;
}

- (void)listDetail:(LKListDetailVC *)listDetail didAddList:(LKChecklist *)list
{
    [self.dataModel.lists addObject:list];
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    
//    NSInteger index = [self.dataModel.lists count];
//    [self.dataModel.lists addObject:list];
    //保存数据
//    [self saveDataToFile];
//    [self saveData:_lists];
//    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    NSArray *indexPaths = @[newIndexPath];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - uinavigationcontrollerdelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //每次显示新控制器时 都会被调用
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedChecklist:-1]; //即用户没有选中任何checklist
    }
}

#pragma mark - action event
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    LKListDetailVC *vc = [[LKListDetailVC alloc]initWithStyle:UITableViewStyleGrouped];
    vc.delegate = self;
    vc.listToEidt = self.dataModel.lists[indexPath.row];
    LKNavigationController *nav = [[LKNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)itemRightClicked: (UIBarButtonItem *)sender
{
    LKListDetailVC *vc = [[LKListDetailVC alloc]initWithStyle:UITableViewStyleGrouped];
    vc.delegate = self;
    LKNavigationController *nav = [[LKNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"All Lists";
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemRightClicked:)];
    self.navigationItem.rightBarButtonItem = itemRight;
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    NSInteger index = [self.dataModel indexOfSelectedChecklist];
    if (index >= 0 && index < self.dataModel.lists.count) { //保证应用在进入详情页但未保存数据就退出的情况下 程序不崩溃
        LKChecklist *model = self.dataModel.lists[index];
        LKCheckListTableVC *vc = [[LKCheckListTableVC alloc]init];
        vc.checklist = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - data saving
//- (NSString *)documentDirectory
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath = [paths firstObject];
//    return documentPath;
//}
//
//- (NSString *)dataFilePath
//{
//    NSString *documentPath = [self documentDirectory];
//    NSString *filePath = [documentPath stringByAppendingPathComponent:@"AllLists.plist"];
//    return filePath;
//}
//
//- (void)saveDataToFile
//{
//    NSMutableData *data = [[NSMutableData alloc]init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [archiver encodeObject:_lists forKey:@"AllLists"];
//    [archiver finishEncoding];
//    [data writeToFile:[self dataFilePath] atomically:YES];
//}
//
//- (void)saveData: (id)data
//{
//    [NSKeyedArchiver archiveRootObject:data toFile:[self dataFilePath]];
//}

@end
