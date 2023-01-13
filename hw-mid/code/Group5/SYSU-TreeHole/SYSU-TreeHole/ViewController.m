//
//  ViewController.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#import "ViewController.h"
#import "LoginController.h"
#import "ChangedViewController.h"
#import "View/SquarePage.h"
#import "View/UserDetailPage.h"

@interface ViewController ()

@property(strong, nonatomic) UIImage* ConfigImage;
@property(strong, nonatomic) UIImage* ConfigSelectedImage;
@property (nonatomic, strong) SquarePage *square;
@property (nonatomic, strong) UserDetailPage *detail;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarController* utbc = [[UITabBarController alloc] init];
    //set tabbar
    self.ConfigImage = [UIImage imageNamed:@"Config.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    self.ConfigSelectedImage = [UIImage imageNamed:@"ConfigSelected.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    LoginController* uic = [[LoginController alloc] init];
    uic.tabBarItem.title = @"我的";
    [uic.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    uic.tabBarItem.image = self.ConfigImage;
    [uic.tabBarItem setImage:[self.ConfigImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [uic.tabBarItem setSelectedImage:[self.ConfigSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    utbc.viewControllers = @[uic];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController setViewControllers:@[utbc]];
    
    /*
    UITabBarController* utbc = [[UITabBarController alloc] init];
    
    _square = [[SquarePage alloc] init];
    [utbc addChildViewController:_square];
    
    _detail = [[UserDetailPage alloc] init];
    [_detail loadPage:0];
    _detail.tabBarItem.title = @"我的";
    _detail.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine_f.png"]
                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _detail.tabBarItem.image = [[UIImage imageNamed:@"mine.png"]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [utbc addChildViewController:_detail];
    
    //set tabbar
    ChangedViewController* uic = [[ChangedViewController alloc] init];
    uic.tabBarItem.title = @"我的";
    // [uic.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    uic.tabBarItem.image = [[UIImage imageNamed:@"settingn.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    uic.tabBarItem.selectedImage = [[UIImage imageNamed:@"settings.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [utbc addChildViewController:uic];
    
    [self.navigationController setViewControllers:@[utbc]];
    // Do any additional setup after loading the view, typically from a nib.
     */
}


@end
