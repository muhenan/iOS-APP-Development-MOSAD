//
//  RootTabBarController.m
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import "RootTabBarController.h"
#import "Page/Mypage.h"
#import "Page/MakeRecord.h"
#import "ViewController.h"
#import "Const/Const.h"
@implementation RootTabBarController

-(id) init{
    self = [super init];
    return self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    // 给tabBarController添加子控制器
    
    
    ViewController *vc1 = [[ViewController alloc] init];
    vc1.tabBarItem.tag = 0;
    vc1.title = @"发现";
    vc1.tabBarItem.selectedImage =[[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.image =[[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    MakeRecord *vc2 = [[MakeRecord alloc]init];
    vc2.tabBarItem.tag = 1;
    vc2.tabBarItem.selectedImage =[[UIImage imageWithContentsOfFile:IMAGE_PATH_RECORD] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.image =[[UIImage imageWithContentsOfFile:IMAGE_PATH_RECORDGRAY] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.title = @"打卡";
    
    
    
    Mypage *vc3 = [[Mypage alloc] init];
    vc3.tabBarItem.tag = 2;
    vc3.title = @"我的";
    vc3.tabBarItem.selectedImage =[[UIImage imageWithContentsOfFile:IMAGE_PATH_ME] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.image =[[UIImage imageWithContentsOfFile:IMAGE_PATH_MEGRAY] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    
    vc2.delegae = vc1;
}

@end
