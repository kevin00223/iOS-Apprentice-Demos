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

static NSString *cellID = @"cellID";

@interface LKItemDetailVC () <UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    UITextField *_textField;
    UIBarButtonItem *_itemRight;
    
    NSDate *_dueDate;
    UISwitch *_switchControl;
    BOOL _datePickerVisible;
    UILabel *_dueDateLabel;
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
    
//    [self setupUI];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
//        _textField.text = self.itemToEdit.text;
        //设置初始为能点击状态
        _itemRight.enabled = YES;
    }else{
        self.title = @"Add Item";
        //设置初始为不能点击状态
        _itemRight.enabled = NO;
    }
    
    //隐藏键盘
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollTap:)];
    myTap.delegate = self;
    [self.tableView addGestureRecognizer:myTap];
}

//- (void)setupUI
//{
//    //添加textField
//    UITextField *textField = [[UITextField alloc]init];
//    textField.placeholder = @"Name of the Item";
//    [self.tableView addSubview:textField];
//    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView).offset(8);
//        make.top.equalTo(self.view).offset(24);
//        make.height.offset(30);
//        make.width.offset(304);
//    }];
//    textField.backgroundColor = [UIColor whiteColor];
//    _textField = textField;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }else{
        return YES;
    }
}

- (void)checklistsBtnClicked: (UIBarButtonItem *)sender
{
    if ([self.delegate respondsToSelector:@selector(itemDetailVCDidCancel:)]) {
        [self.delegate itemDetailVCDidCancel:self];
    }
}

- (void)doneBtnClicked: (UIBarButtonItem *)sender
{
    if ([self.title isEqualToString:@"Edit Item"]) {
        self.itemToEdit.text = _textField.text;
        self.itemToEdit.shouldRemind = _switchControl.on;
//        self.itemToEdit.dueDate = _dueDate;
        self.itemToEdit.dueDate = [self convertStringToDate:_dueDateLabel.text];
        [self.itemToEdit scheduleNotifications];
        if ([self.delegate respondsToSelector:@selector(itemDetailVC:didFinishEditingItem:)]) {
            [self.delegate itemDetailVC:self didFinishEditingItem:self.itemToEdit];
        }
    }else{
        LKChecklistItem *model = [[LKChecklistItem alloc]init];
        model.text = _textField.text;
        model.shouldRemind = _switchControl.on;
        model.dueDate = _dueDate;
        [model scheduleNotifications];
        if([self.delegate respondsToSelector:@selector(itemDetailVC:didFinishAddingItem:)]){
            [self.delegate itemDetailVC:self didFinishAddingItem:model];
        }
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        if (_datePickerVisible == YES) {
            return 3;
        }else{
            return 2;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"Name of the Item";
        [cell addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(14);
            make.top.right.bottom.equalTo(cell);
        }];
        _textField = textField;
        if (self.itemToEdit != nil) {
            _textField.text = self.itemToEdit.text;
        }
        //设置代理
        _textField.delegate = self;
    }else{
        if (indexPath.row == 0) {
            UILabel *label = [[UILabel alloc]init];
            label.text = @"Remind Me";
            UISwitch *swch = [[UISwitch alloc]init];
            [cell addSubview:label];
            [cell addSubview:swch];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).offset(14);
                make.top.bottom.equalTo(cell);
            }];
            [swch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-14);
                make.top.equalTo(cell).offset(4);
                make.bottom.equalTo(cell).offset(-4);
            }];
            _switchControl = swch;
            if (self.itemToEdit != nil) {
                //编辑已有checkList switch状态就看该checkList的shouldRemind值
                _switchControl.on = self.itemToEdit.shouldRemind;
            }else
            {
                //新建checkList 就设置成关闭状态
                _switchControl.on = NO;
            }
        }else if(indexPath.row == 1){
            UILabel *label = [[UILabel alloc]init];
            UILabel *dueDate = [[UILabel alloc]init];
            label.text = @"Due Date";
            [cell addSubview:label];
            [cell addSubview:dueDate];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).offset(14);
                make.top.bottom.equalTo(cell);
            }];
            [dueDate mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-14);
                make.top.bottom.equalTo(cell);
            }];
            _dueDateLabel = dueDate;
            if (self.itemToEdit != nil) {
                _dueDate = self.itemToEdit.dueDate;
                _dueDateLabel.text = [self updateDueDateLabelWithDate:_dueDate];
            }else{
                //新建的checklist 其dueDate就是现在 即[NSDate date]
                _dueDate = [NSDate date];
                _dueDateLabel.text = [self updateDueDateLabelWithDate:_dueDate];
            }
        }else{
            if (_datePickerVisible == YES) {
                UIDatePicker *datePicker = [[UIDatePicker alloc]init];
                [cell.contentView addSubview:datePicker];
                [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell);
                }];
                [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 & indexPath.row == 2) {
        return 217;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 & indexPath.row == 1) {
        if (!_datePickerVisible) {
            [self showDatePicker];
        }else{
            [self hideDatePicker];
        }
    }
}

- (void)showDatePicker
{
    _datePickerVisible = YES;
    [self.tableView reloadData];
}

- (void)hideDatePicker
{
    _datePickerVisible = NO;
    [self.tableView reloadData];
}

- (NSString *)updateDueDateLabelWithDate: (NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSDate *)convertStringToDate: (NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

- (void)dateChanged:(UIDatePicker *)datePicker
{
    _dueDateLabel.text = [self updateDueDateLabelWithDate:datePicker.date];
    _dueDateLabel.textColor = [UIColor colorWithRed:4.0/255.0 green:169.0/255.0 blue:235.0/255.0 alpha:1];
}

#pragma mark - uitextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [_textField.text stringByReplacingCharactersInRange:range withString:string];
    _itemRight.enabled = ([newText length] > 0);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//TODO:
    //点击textField 隐藏datePicker, 以免键盘盖住datePicker
//    [self hideDatePicker];
}

//隐藏键盘
- (void)scrollTap: (id)sender
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:4.0/255.0 green:169.0/255.0 blue:235.0/255.0 alpha:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_textField becomeFirstResponder];
}


@end
