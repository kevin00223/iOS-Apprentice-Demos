//
//  LKCheckListTableVC.m
//  To-do List
//
//  Created by likai on 2017/6/27.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKCheckListTableVC.h"
#import "LKChecklistItem.h"
#import "LKItemDetailVC.h"
#import "LKNavigationController.h"
#import "LKCheckListCell.h"

static NSString *cellID = @"cellID";

@interface LKCheckListTableVC () <LKItemDetailVCDelegate>
{
//    NSMutableArray *self.checklist.items;
    //是否显示左侧checkmark的bool值
    BOOL _show;
}


@end

@implementation LKCheckListTableVC

//初始化模型数组
//- (instancetype)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewStylePlain];
//    if(self){
//        [self loadChecklistItems];
//    }
//    return self;
//}
//
////初始化模型数组
//- (void)loadChecklistItems
//{
//    NSString *path = [self dataFilePath];
//    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
//        //如果该文件路径存在
//        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//        self.checklist.items = [unarchiver decodeObjectForKey:@"ChecklistItems"];
//        [unarchiver finishDecoding];
//    }else{
//        self.checklist.items = [NSMutableArray array];
//        
//        LKChecklistItem *item;
//        
//        item = [[LKChecklistItem alloc] init];
//        item.text = @"Walk the dog";
//        [self.checklist.items addObject:item];
//        
//        item = [[LKChecklistItem alloc] init];
//        item.text = @"Brush my teeth";
//        [self.checklist.items addObject:item];
//        
//        item = [[LKChecklistItem alloc] init];
//        item.text = @"Learn iOS development";
//        [self.checklist.items addObject:item];
//        
//        item = [[LKChecklistItem alloc] init];
//        item.text = @"Soccer practice";
//        [self.checklist.items addObject:item];
//        
//        item = [[LKChecklistItem alloc] init];
//        item.text = @"Eat ice cream";
//        [self.checklist.items addObject:item];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"LKCheckListCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    NSLog(@"%@", NSHomeDirectory());
    
}

//获取数据
//- (NSMutableArray *)loadData
//{
    //解析plist
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CheckListPlist.plist" ofType:nil];
//    NSArray *plistArr = [[NSArray alloc]initWithContentsOfFile:plistPath];
//    NSMutableArray *mArr = [NSMutableArray array];
//    for (NSDictionary *dict in plistArr) {
//        [mArr addObject:[LKChecklistItem checklistWithDict:dict]];
//    }
//    
//    NSMutableArray *mArr = [NSMutableArray array];
//    
//    LKChecklistItem *item;
//    
//    item = [[LKChecklistItem alloc] init];
//    item.text = @"Walk the dog";
//    [mArr addObject:item];
//    
//    item = [[LKChecklistItem alloc] init];
//    item.text = @"Brush my teeth";
//    [mArr addObject:item];
//    
//    item = [[LKChecklistItem alloc] init];
//    item.text = @"Learn iOS development";
//    [mArr addObject:item];
//    
//    item = [[LKChecklistItem alloc] init];
//    item.text = @"Soccer practice";
//    [mArr addObject:item];
//    
//    item = [[LKChecklistItem alloc] init];
//    item.text = @"Eat ice cream";
//    [mArr addObject:item];
//    
//    return mArr;
//}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.checklist.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    //设置accessoryType
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    LKChecklistItem *model = self.checklist.items[indexPath.row];
    cell.projectLabel.text = model.text;
    if (!model.show) {
        cell.toggleLabel.text = @"";
    }else{
        cell.toggleLabel.text = @"√";
    }
//    if ([model isKindOfClass:[NSString class]]) {
//        cell.projectLabel.text = (NSString *)model;
//    }else{
//        cell.projectLabel.text = model.text;
//    }

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LKCheckListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    LKChecklistItem *model = self.checklist.items[indexPath.row];

    if (!model.show){
        //显示
        cell.toggleLabel.text = @"√";
        model.show = 1;
    }else{
        //不显示
        cell.toggleLabel.text = @"";
        model.show = 0;
    }
    //保存数据到沙盒
//    [self saveChecklistItems];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    LKItemDetailVC *itemDetailVC = [[LKItemDetailVC alloc]initWithStyle:UITableViewStyleGrouped];
    itemDetailVC.delegate = self;
    itemDetailVC.itemToEdit = self.checklist.items[indexPath.row];
    LKNavigationController *nav = [[LKNavigationController alloc]initWithRootViewController:itemDetailVC];
    [self presentViewController:nav animated:YES completion:nil];
}

//删除任意行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    //数据保存到沙盒
//    [self saveChecklistItems];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - LKItemDetailVCDelegate
- (void)itemDetailVCDidCancel:(LKItemDetailVC *)itemDetailVC
{
    [itemDetailVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailVC:(LKItemDetailVC *)itemDetailVC didFinishAddingItem:(LKChecklistItem *)item
{
    NSInteger newRowIndex = [self.checklist.items count];
    [self.checklist.items addObject:item];
    //数据保存到沙盒
//    [self saveChecklistItems];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)itemDetailVC:(LKItemDetailVC *)itemDetailVC didFinishEditingItem:(LKChecklistItem *)item
{
    NSInteger index = [self.checklist.items indexOfObject:item];
    //数据保存到沙盒
//    [self saveChecklistItems];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LKCheckListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.projectLabel.text = item.text;
}

//点击事件
- (void)addBtncClicked: (UIBarButtonItem *)sender
{
    LKItemDetailVC *itemDetailVC = [[LKItemDetailVC alloc]initWithStyle:UITableViewStyleGrouped];
    itemDetailVC.delegate = self;
    LKNavigationController *nav = [[LKNavigationController alloc]initWithRootViewController:itemDetailVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - data saving
////创建沙盒目录
//- (NSString *)documentsDirectory
//{
//    //获取documents路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths firstObject];
//    return documentsDirectory;
//}
//
//- (NSString *)dataFilePath
//{
//    //拼接路径地址
//    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
//}
//
////保存数据到沙盒
//- (void)saveChecklistItems
//{
//    NSMutableData *data = [[NSMutableData alloc]init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [archiver encodeObject:self.checklist.items forKey:@"ChecklistItems"]; //self.checklist.items存的是model, 因此需要让model遵守NSCoding协议 实现对应方法
//    [archiver finishEncoding];
//    [data writeToFile:[self dataFilePath] atomically:YES];
//}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    self.title = self.checklist.name;
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtncClicked:)];
    //    self.navigationController.navigationItem.rightBarButtonItem = itemRight; //不要用navigationController去调navigationItem
    self.navigationItem.rightBarButtonItem = itemRight;
    
    //重新刷新数据
    [self.tableView reloadData];
}


@end
