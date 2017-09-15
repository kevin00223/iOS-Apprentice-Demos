//
//  LKCheckListCell.m
//  To-do List
//
//  Created by likai on 2017/9/7.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKCheckListCell.h"
#import "LKChecklistItem.h"

@interface LKCheckListCell ()



@end

@implementation LKCheckListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)setupUI
{
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
