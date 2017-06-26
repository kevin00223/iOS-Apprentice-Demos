//
//  InfoVC.m
//  Bull's Eye Game
//
//  Created by likai on 2017/6/26.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "InfoVC.h"
#import "Masonry.h"

@interface InfoVC ()

@property (nonatomic, strong)UIWebView *infoWebView;

@end

@implementation InfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景图片
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background"]];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //加载webview
    NSString *htmlFile = [[NSBundle mainBundle]pathForResource:@"BullsEye" ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    NSURL *htmlURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.infoWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:htmlURL];
    [self.view addSubview: self.infoWebView];
    [self.infoWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-75);
    }];
    
    //close按钮
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setTitle:@"CLOSE" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"Button-Normal"] forState:UIControlStateNormal];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"Button-Highlighted"] forState:UIControlStateSelected];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)closeBtnClicked: (UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//懒加载
- (UIWebView *)infoWebView
{
    if (!_infoWebView){
        _infoWebView = [[UIWebView alloc]init];
    }
    return _infoWebView;
}



@end
