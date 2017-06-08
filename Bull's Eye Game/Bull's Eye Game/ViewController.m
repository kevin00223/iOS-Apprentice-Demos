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

@property (nonatomic, weak)UILabel *scoreLabel;
@property (nonatomic, weak)UILabel *roundLabel;

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
    
    //说明标签
    UILabel *descLabel = [[UILabel alloc]init];
    descLabel.text = @"Put the Bull's Eye as Close as You Can to: 18";
    descLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
    }];
    
    //slider
    UISlider *slider = [[UISlider alloc]init];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.value = 0;
    slider.continuous = NO;
    [slider setThumbImage:[UIImage imageNamed:@"SliderThumb-Normal"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"SliderThumb-Highlighted"] forState:UIControlStateHighlighted];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"SliderTrackLeft"] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage imageNamed:@"SliderTrackRight"] forState:UIControlStateNormal];
    [self.view addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(descLabel.mas_bottom).offset(44);
        make.width.offset(400);
    }];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //slider两侧的数字label
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.text = @"1";
    leftLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(slider);
        make.right.equalTo(slider.mas_left).offset(-20);
    }];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.text = @"100";
    rightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(slider);
        make.left.equalTo(slider.mas_right).offset(20);
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
        make.centerX.equalTo(self.view);
        make.top.equalTo(slider.mas_bottom).offset(44);
    }];
    [HitMeBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //resetBtn
    UIButton *resetBtn = [[UIButton alloc]init];
    [resetBtn setImage:[UIImage imageNamed:@"SmallButton"] forState:UIControlStateNormal];
    [self.view addSubview:resetBtn];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset (44);
        make.bottom.equalTo(self.view).offset (-44);
    }];
    UIButton *leftBtn = [[UIButton alloc]init];
    [leftBtn setImage:[UIImage imageNamed:@"StartOverIcon"] forState:UIControlStateNormal];
    [resetBtn addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(resetBtn);
    }];
    [leftBtn addTarget:self action:@selector(leftBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //infoBtn
    UIButton *infoBtn = [[UIButton alloc]init];
    [infoBtn setImage:[UIImage imageNamed:@"SmallButton"] forState:UIControlStateNormal];
    [self.view addSubview:infoBtn];
    [infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(resetBtn);
        make.right.equalTo(self.view).offset(-44);
    }];
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"InfoButton"] forState:UIControlStateNormal];
    [infoBtn addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(infoBtn);
    }];
    
    //scoreLabel
    UILabel *scoreLabel = [[UILabel alloc]init];
    scoreLabel.text = @"Score: 0";
    scoreLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(resetBtn);
        make.left.equalTo(resetBtn.mas_right).offset(44);
    }];
    self.scoreLabel = scoreLabel;
    
    //roundLabel
    UILabel *roundLabel = [[UILabel alloc]init];
    roundLabel.text = @"Round: 1";
    roundLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:roundLabel];
    [roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(infoBtn);
        make.right.equalTo(infoBtn.mas_left).offset(-44);
    }];
    self.roundLabel = roundLabel;
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

- (void)leftBtnSelected: (UIButton *)sender
{
    self.scoreLabel.text = @"Score: 0";
}

//slider滑动事件
- (void)valueChanged: (UISlider *)sender
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %f", sender.value];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
