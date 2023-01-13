//
//  ViewController.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/21.
//  Copyright © 2020 itlab. All rights reserved.
//

#import "ViewController.h"
#import "RootTabBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, self.view.frame.size.height/2-35, 100, 70)];
    [btn setTitle:@"Log In" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(JumpToRootController) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor = [UIColor redColor];//button的背景颜色
    [self.view addSubview:btn];
}

- (void)JumpToRootController
{
    RootTabBarContorller *RTC = [[RootTabBarContorller alloc] init];
    
    [self presentViewController:RTC animated: YES completion:nil];//跳转
    // [self dismissViewControllerAnimated: YES completion: nil ];//返回
}

@end
