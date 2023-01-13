//
//  RootTabBarController.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/21.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootTabBarController.h"
#import "Controller/LocalFilePage.h"
#import "Controller/CloudFilePage.h"
#import "Controller/TransferHistoryPage.h"
#import "HomeViewController.h"
@interface RootTabBarContorller()

@property (nonatomic, strong)UIButton *back;

@end

@implementation RootTabBarContorller

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINavigationController *nc1 = [[UINavigationController alloc] init];
    // tabbar icon setting
    nc1.tabBarItem.title = @"我的云盘";
    nc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"cloud_s.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc1.tabBarItem.image = [[UIImage imageNamed:@"cloud.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UINavigationController *nc2 = [[UINavigationController alloc] init];
    nc2.tabBarItem.title = @"首页";
    nc2.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected.png"] ;
    nc2.tabBarItem.image = [UIImage imageNamed:@"home.png"] ;
    
    
    UINavigationController *nc3 = [[UINavigationController alloc] init];
    nc3.tabBarItem.title = @"传输历史";
    nc3.tabBarItem.selectedImage = [UIImage imageNamed:@"history_s.png"] ;
    nc3.tabBarItem.image = [UIImage imageNamed:@"history.png"] ;
    
    
    
    
    //UINavigationController *nc3 = [[UINavigationController alloc] init];
    
    CloudFilePage *CFP = [[CloudFilePage alloc] init];
    HomeViewController* home = [[HomeViewController alloc] init];
    TransferHistoryPage *THP = [[TransferHistoryPage alloc] init];
    
    
    [nc1 pushViewController:CFP animated:YES];
    [nc2 pushViewController:home animated:YES];
    [nc3 pushViewController:THP animated:YES];
    //[nc3 pushViewController:THP animated:YES];
    
    [self addChildViewController:nc2];
    [self addChildViewController:nc1];
    [self addChildViewController:nc3];
}

- (void)loadBackButtun
{
     _back = [[UIButton alloc]initWithFrame:CGRectMake(100, self.view.frame.size.height/2-35, 100, 70)];
     [_back setTitle:@"Log Out" forState:UIControlStateNormal];
     [_back addTarget:self action:@selector(JumpBackToLoginPage) forControlEvents:UIControlEventTouchDown];
     _back.backgroundColor = [UIColor blueColor];//button的背景颜色
     [self.view addSubview:_back];
}

- (void)JumpBackToLoginPage
{
    // [self presentViewController:RTC animated: YES completion:nil];//跳转
    [self dismissViewControllerAnimated: YES completion: nil ];//返回
}

@end
