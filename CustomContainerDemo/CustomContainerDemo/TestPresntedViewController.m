//
//  TestPresntedViewController.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/13.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "TestPresntedViewController.h"
#import "CustomPresention.h"

@interface TestPresntedViewController ()

@end

@implementation TestPresntedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.center = self.view.center;
}

- (void)dismissAction:(UIButton *)btn{
    CustomPresention *pr = [[CustomPresention alloc]init];
    self.transitioningDelegate = pr;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
