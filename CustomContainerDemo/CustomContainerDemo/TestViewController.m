//
//  TestViewController.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/12.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "TestViewController.h"
#import "TestPresntedViewController.h"
#import "CustomPresention.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self randomColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.center = self.view.center;
    [btn setTitle:@"进入下一页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
- (void)goNext:(UIButton *)btn{
    if (_isFirst) {
        TestViewController *tvc = [[TestViewController alloc]init];
        tvc.isFirst = NO;
        [self presentViewController:tvc animated:YES completion:nil];
        return;
    }
    TestPresntedViewController * Pvc = [[TestPresntedViewController alloc]init];
    CustomPresention *pr = [[CustomPresention alloc]init];
    Pvc.modalPresentationStyle = UIModalPresentationCustom;
    Pvc.transitioningDelegate = pr;
    [self presentViewController:Pvc animated:YES completion:nil];
}
- (UIColor *)randomColor{
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
}
- (void)willMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"即将添加的容器");
}
- (void)didMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"已经添加到容器");
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
