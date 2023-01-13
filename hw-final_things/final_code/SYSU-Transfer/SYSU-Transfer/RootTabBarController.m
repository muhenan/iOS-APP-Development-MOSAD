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
#import "Controller/ChangedConfig/ChangedViewController.h"
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
    
    UIImageSymbolConfiguration * symbolConf = [UIImageSymbolConfiguration unspecifiedConfiguration];
    
    UINavigationController *nc1 = [[UINavigationController alloc] init];
    // tabbar icon setting
    nc1.tabBarItem.title = @"我的云盘";
    nc1.tabBarItem.image = [[UIImage systemImageNamed:@"cloud" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    // nc1.tabBarItem.selectedImage = [[UIImage systemImageNamed:@"cloud.fill" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    
    UINavigationController *nc2 = [[UINavigationController alloc] init];
    nc2.tabBarItem.title = @"首页";
    // nc2.tabBarItem.selectedImage = [[UIImage systemImageNamed:@"house.fill" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    nc2.tabBarItem.image = [[UIImage systemImageNamed:@"house" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    
    
    UINavigationController *nc3 = [[UINavigationController alloc] init];
    nc3.tabBarItem.title = @"分享历史";
    // nc3.tabBarItem.selectedImage = [[UIImage systemImageNamed:@"square.and.arrow.up.fill" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    nc3.tabBarItem.image = [[UIImage systemImageNamed:@"square.and.arrow.up" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    
    UINavigationController *nc4 = [[UINavigationController alloc] init];
    nc4.tabBarItem.title = @"本地";
    nc4.tabBarItem.image = [[UIImage systemImageNamed:@"iphone" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    // nc4.tabBarItem.selectedImage = [[UIImage systemImageNamed:@"iphone" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    
    UINavigationController *nc5 = [[ChangedViewController alloc] init];
    nc5.tabBarItem.title = @"我的";
    // nc5.tabBarItem.selectedImage = [[UIImage systemImageNamed:@"person.fill" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    nc5.tabBarItem.image = [[UIImage systemImageNamed:@"person" withConfiguration:symbolConf] imageWithBaselineOffsetFromBottom:[UIFont systemFontSize] / 2];
    
    
    //UINavigationController *nc3 = [[UINavigationController alloc] init];
    
    CloudFilePage *CFP = [[CloudFilePage alloc] init];
    CFP.path = @"/";
    [CFP.navigationItem setTitle:@"云盘"];
    
    LocalFilePage *LFP = [[LocalFilePage alloc] init];
    LFP.path = @"";
    [LFP.navigationItem setTitle:@"本地"];
    
    HomeViewController* home = [[HomeViewController alloc] init];
    TransferHistoryPage *THP = [[TransferHistoryPage alloc] init];
    
    
    [nc1 pushViewController:CFP animated:YES];
    [nc2 pushViewController:home animated:YES];
    [nc3 pushViewController:THP animated:YES];
    [nc4 pushViewController:LFP animated:YES];
    
    [self addChildViewController:nc2];
    [self addChildViewController:nc3];
    [self addChildViewController:nc1];
    [self addChildViewController:nc4];
    [self addChildViewController:nc5];
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
