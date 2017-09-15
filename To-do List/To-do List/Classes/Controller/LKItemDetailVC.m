//
//  LKitemDetailVC.m
//  To-do List
//
//  Created by likai on 2017/8/3.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKItemDetailVC.h"
#import "masonry.h"
#import "LKNavigationController.h"

@interface LKItemDetailVC () <UITextFieldDelegate>
{
    UITextField *_textField;
    UIBarButtonItem *_itemRight;
}

@end

@implementation LKItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc]initWithTitle:@"Checklists" style:UIBarButtonItemStylePlain target:self action:@selector(checklistsBtnClicked:)];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnClicked:)];
    _itemRight = itemRight;
    self.navigationItem.leftBarButtonItem = itemLeft;
    self.navigationItem.rightBarButtonItem = _itemRight;
    
    [self setupUI];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        _textField.text = self.itemToEdit.text;
        //设置初始为能点击状态
        _itemRight.enabled = YES;
    }else{
        self.title = @"Add Item";
        //设置初始为不能点击状态
        _itemRight.enabled = NO;
    }
    
    //注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    //设置代理
    _textField.delegate = self;
    //隐藏键盘
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollTap:)];
    [self.tableView addGestureRecognizer:myTap];
}

- (void)setupUI
{
    //添加textField
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = @"Name of the Item";
    [self.tableView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView).offset(8);
        make.top.equalTo(self.view).offset(24);
        make.height.offset(30);
        make.width.offset(304);
    }];
    textField.backgroundColor = [UIColor whiteColor];
    _textField = textField;
}

- (void)checklistsBtnClicked: (UIBarButtonItem *)sender
{
    if ([self.delegate respondsToSelector:@selector(itemDetailVCDidCancel:)]) {
        [self.delegate itemDetailVCDidCancel:self];
    }
}

- (void)doneBtnClicked: (UIBarButtonItem *)sender
{
    LKChecklistItem *model = [[LKChecklistItem alloc]init];
    model.text = _textField.text;
    
    if ([self.title isEqualToString:@"Edit Item"]) {
        self.itemToEdit.text = _textField.text;
        if ([self.delegate respondsToSelector:@selector(itemDetailVC:didFinishEditingItem:)]) {
            [self.delegate itemDetailVC:self didFinishEditingItem:self.itemToEdit];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(itemDetailVC:didFinishAddingItem:)]){
            [self.delegate itemDetailVC:self didFinishAddingItem:model];
        }
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableview datasource


#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [_textField.text stringByReplacingCharactersInRange:range withString:string];
    _itemRight.enabled = ([newText length] > 0);
    return YES;
}

//隐藏键盘
- (void)scrollTap: (id)sender
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    //设置第一响应者
    [_textField becomeFirstResponder];
}



@end
