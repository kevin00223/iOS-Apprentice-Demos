//
//  LKListDetailVC.m
//  To-do List
//
//  Created by likai on 2017/9/14.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKListDetailVC.h"
#import "Masonry.h"
#import "LKIconPickerVC.h"

static NSString *cellID = @"cellID";

@interface LKListDetailVC () <UITextFieldDelegate, LKIconPickerDelegate>
{
    UITextField *_textField;
    UIBarButtonItem *_itemRight;
    NSString *_iconName;
}

@end

@implementation LKListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle: UITableViewStyleGrouped];
    if (self) {
        _iconName = @"Folder";
    }
    return self;
}

#pragma mark - action
- (void)allListsClicked: (UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneClicked: (UIBarButtonItem *)sender
{
    if (self.listToEidt != nil) {
        //修改
        self.listToEidt.name = _textField.text;
        if ([self.delegate respondsToSelector:@selector(listDetail:didEditList:)]) {
            [self.delegate listDetail:self didEditList:self.listToEidt];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(listDetail:didAddList:)]) {
            LKChecklist *model = [[LKChecklist alloc]init];
            model.name = _textField.text;
            [self.delegate listDetail:self didAddList:model];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - uitableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"   Name of the List";
        [cell.contentView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
        _textField = textField;
        _textField.delegate = self;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *iconLabel = [[UILabel alloc]init];
        UIImageView *iconImage = [[UIImageView alloc]init];
        iconLabel.text = @"   ICON";
        iconImage.image = [UIImage imageNamed:_iconName];
        [cell.contentView addSubview:iconLabel];
        [cell.contentView addSubview:iconImage];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(cell);
        }];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell);
            make.right.equalTo(cell).offset(-24);
            make.width.offset(44);
        }];
    }
    return cell;
}


#pragma mark - uitableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        LKIconPickerVC *iconVC = [[LKIconPickerVC alloc]init];
        iconVC.delegate = self;
        [self.navigationController pushViewController:iconVC animated:YES];
    }
}

#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newStr = [_textField.text stringByReplacingCharactersInRange:range withString:string];
    _itemRight.enabled = (newStr.length > 0);
    return YES;
}

#pragma mark - LKIconPickerDelegate
- (void)iconPicker:(LKIconPickerVC *)iconPicker didSelectIcon:(NSString *)iconName
{
    _iconName = iconName;
    [self.tableView reloadData];
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc]initWithTitle:@"AllLists" style:UIBarButtonItemStylePlain target:self action:@selector(allListsClicked:)];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    _itemRight = itemRight;
    self.navigationItem.leftBarButtonItem = itemLeft;
    self.navigationItem.rightBarButtonItem = _itemRight;
    
    if (self.listToEidt != nil){
        _itemRight.enabled = YES;
        self.title = @"Edit List";
        _textField.text = self.listToEidt.name;
    }else{
        _itemRight.enabled = NO;
        self.title = @"List Detail";
    }
    
    //设置第一响应者
    [_textField becomeFirstResponder];
    
}


@end
