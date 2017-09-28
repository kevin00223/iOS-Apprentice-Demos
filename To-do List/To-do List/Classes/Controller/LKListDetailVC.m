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

@interface LKListDetailVC () <UITextFieldDelegate, LKIconPickerDelegate, UIGestureRecognizerDelegate>
{
    UITextField *_textField;
    UIBarButtonItem *_itemRight;
    NSString *_iconName;
}

@end

@implementation LKListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc]initWithTitle:@"AllLists" style:UIBarButtonItemStylePlain target:self action:@selector(allListsClicked:)];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    _itemRight = itemRight;
    self.navigationItem.leftBarButtonItem = itemLeft;
    self.navigationItem.rightBarButtonItem = _itemRight;
    
    if (self.listToEidt != nil){
        _itemRight.enabled = YES;
        _iconName = self.listToEidt.iconName;
        self.title = @"Edit Chekclist";
    }else{
        _itemRight.enabled = NO;
        self.title = @"List Detail";
    }
    
    //添加取消键盘的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelKeyboard)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle: UITableViewStyleGrouped];
    if (self) {
        if (self.listToEidt != nil){
            _iconName = self.listToEidt.iconName;
        }else{
            _iconName = @"Folder";
        }
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
        self.listToEidt.iconName = _iconName;
        if ([self.delegate respondsToSelector:@selector(listDetail:didEditList:)]) {
            [self.delegate listDetail:self didEditList:self.listToEidt];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(listDetail:didAddList:)]) {
            LKChecklist *model = [[LKChecklist alloc]init];
            model.name = _textField.text;
            model.iconName = _iconName;
            [self.delegate listDetail:self didAddList:model];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelKeyboard
{
    [_textField resignFirstResponder];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }else{
        return YES;
    }
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
        textField.placeholder = @"Name of the List";
        [cell.contentView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(14);
            make.top.bottom.right.equalTo(cell);
        }];
        _textField = textField;
        if (self.listToEidt != nil){
            _textField.text = self.listToEidt.name;
        }
        _textField.delegate = self;
    }else if(indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *iconLabel = [[UILabel alloc]init];
        UIImageView *iconImage = [[UIImageView alloc]init];
        iconLabel.text = @"ICON";
        iconImage.image = [UIImage imageNamed:_iconName];
        [cell.contentView addSubview:iconLabel];
        [cell.contentView addSubview:iconImage];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(14);
            make.top.bottom.equalTo(cell);
        }];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell);
            make.right.equalTo(cell).offset(-34);
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
    self.listToEidt.name = newStr;
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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:4.0/255.0 green:169.0/255.0 blue:235.0/255.0 alpha:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_textField becomeFirstResponder];
}

@end
