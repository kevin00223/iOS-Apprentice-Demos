//
//  ViewController.m
//  Bull's Eye Game
//
//  Created by likai on 2017/6/6.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "InfoVC.h"

@interface ViewController ()
{
    int _currentValue;
    int _targetValue;
    int _differenceValue;
    int _round;
}

@property (nonatomic, weak)UILabel *scoreLabel;
@property (nonatomic, weak)UILabel *roundLabel;
@property (nonatomic, weak)UILabel *descLabel;
@property (nonatomic, weak)UISlider *slider;
@property (nonatomic, weak)UITextView *infoView;
@property (nonatomic, weak)UIButton *closeBtn;
@property (nonatomic, strong)UIWebView *aboutWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
    [self startNewRound];
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
    descLabel.textColor = [UIColor whiteColor];
//    descLabel.text = [NSString stringWithFormat:@"Put the Bull's Eye as Close as You Can to: %d", arc4random() % 101];
    [self.view addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
    }];
    self.descLabel = descLabel;
    
    //slider
    UISlider *slider = [[UISlider alloc]init];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
//    slider.value = 50;
    slider.continuous = NO;
    [slider setThumbImage:[UIImage imageNamed:@"SliderThumb-Normal"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"SliderThumb-Highlighted"] forState:UIControlStateHighlighted];
    
    UIImage *leftTrackImage = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [slider setMinimumTrackImage:leftTrackImage forState:UIControlStateNormal];
    UIImage *rightTrackImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [slider setMaximumTrackImage:rightTrackImage forState:UIControlStateNormal];
//    [slider setMinimumTrackTintColor:[UIColor redColor]];
//    [slider setMaximumTrackTintColor:[UIColor blueColor]];
    [self.view addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(descLabel.mas_bottom).offset(44);
        make.width.offset(400);
    }];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider = slider;
    
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
    [rightBtn addTarget:self action:@selector(infoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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
    _round = 1;
    roundLabel.text = [NSString stringWithFormat:@"Round: %d", _round];
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
//    if (_targetValue > _currentValue){
//        _differenceValue = _targetValue - _currentValue;
//    }else if (_currentValue > _targetValue){
//        _differenceValue = _currentValue - _targetValue;
//    }else{
//        _differenceValue = 0;
//    }
    
    _differenceValue = abs(_targetValue - _currentValue);
    //10分 bravo
    //20分 very good  you almost had it
    //30分 good   not even close...
    //40分
    
    NSString *alertTitle;
    if (_differenceValue == 0){
        alertTitle = @"Bravo!";
    }else if(_differenceValue < 5){
        alertTitle = @"You almost had it!";
    }else if(_differenceValue < 10){
        alertTitle = @"Pretty good!";
    }else{
        alertTitle = @"Not even close...";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:[NSString stringWithFormat:@"the value of the slider is %d \nthe target value is %d \nand the difference is %d", _currentValue, _targetValue, _differenceValue] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       // NSLog(@"点击了");
        [self startNewRound];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 100-_differenceValue];
        self.roundLabel.text = [NSString stringWithFormat:@"Round: %d", 1+_round++];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)infoBtnClicked: (UIButton *)sender{
    
    InfoVC *infoVC = [[InfoVC alloc]init];
    [self presentViewController:infoVC animated:YES completion:nil];
}

- (void)leftBtnSelected: (UIButton *)sender
{
    self.scoreLabel.text = @"Score: 0";
    _round = 1;
    self.roundLabel.text = [NSString stringWithFormat:@"Round: %d",_round];
}

//slider滑动事件
- (void)valueChanged: (UISlider *)sender
{
    _currentValue = (int)sender.value;
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)sender.value];
}

- (void)startNewRound
{
    _targetValue = arc4random()%101;
    self.descLabel.text = [NSString stringWithFormat:@"Put the Bull's Eye as Close as You Can to: %d", _targetValue];
    self.slider.value = 50;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
