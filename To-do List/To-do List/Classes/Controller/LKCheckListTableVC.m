//
//  LKCheckListTableVC.m
//  To-do List
//
//  Created by likai on 2017/6/27.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKCheckListTableVC.h"
#import "LKChecklistModel.h"

static NSString *cellID = @"cellID";

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface LKCheckListTableVC ()
{
    NSArray *_mArr;
}

@end

@implementation LKCheckListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _mArr = [self loadData];
    
    //注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

//获取数据
- (NSArray *)loadData
{
    //解析plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CheckListPlist.plist" ofType:nil];
    NSArray *plistArr = [[NSArray alloc]initWithContentsOfFile:plistPath];
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSDictionary *dict in plistArr) {
        [mArr addObject:[LKChecklistModel checklistWithDict:dict]];
    }
    
    return mArr.copy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //目的:显示detailLabel
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    LKChecklistModel *model = _mArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.image];
    cell.textLabel.text = model.text;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    //给cell添加两个accessoryType
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)addBtncClicked: (UIBarButtonItem *)sender
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"CheckLists";
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtncClicked:)];
    self.navigationController.navigationItem.rightBarButtonItem = itemRight;
}

@end
