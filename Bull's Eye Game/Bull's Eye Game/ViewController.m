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
    //背景
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background"]];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //hitme按钮
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
    
    //按钮添加点击事件
    [HitMeBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
}

//按钮点击事件
- (void)btnSelected: (UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello World" message:@"ios apprentice demo" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了");
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
