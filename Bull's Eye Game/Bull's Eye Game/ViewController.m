//
//  ViewController.m
//  Bull's Eye Game
//
//  Created by likai on 2017/6/6.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
    
}

- (void)setupUI
{
    UIButton *HitMeBtn = [[UIButton alloc]init];
    [HitMeBtn setTitle:@"Hit Me!" forState:UIControlStateNormal];
    [HitMeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [HitMeBtn sizeToFit];
    [HitMeBtn setBackgroundImage:[UIImage imageNamed:@"Button-Normal"] forState:UIControlStateNormal];
    [HitMeBtn setBackgroundImage:[UIImage imageNamed:@"Button-Highlighted"] forState:UIControlStateSelected];
    [self.view addSubview:HitMeBtn];
    [HitMeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
