//
//  LKListDetailVC.m
//  To-do List
//
//  Created by likai on 2017/9/14.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKListDetailVC.h"
#import "Masonry.h"

@interface LKListDetailVC () <UITextFieldDelegate>
{
    UITextField *_textField;
    UIBarButtonItem *_itemRight;
}

@end

@implementation LKListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
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
    _textField.delegate = self;
}

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

#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newStr = [_textField.text stringByReplacingCharactersInRange:range withString:string];
    _itemRight.enabled = (newStr.length > 0);
    return YES;
}

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
