//
//  OriginViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../Model/DataModel.h"
#import "OriginViewController.h"
#import "ConfigCell.h"
#import "AwardViewController.h"
#import "ChangedViewController.h"

@interface OriginViewController ()
@property(strong, nonatomic) UIViewController* sup;
@property(strong, nonatomic) UserLoginInfo* user;

@property(strong, nonatomic) UITableView* main;

@property(strong, nonatomic) UIImageView* uiView;
@property(strong, nonatomic) UILabel* uitf;

@property(strong, nonatomic) UIView* circleView;

@property(strong, nonatomic) UILabel* uilabel;
@property(strong, nonatomic) UILabel* username;
@property(strong, nonatomic) UILabel* state;

@property(nonatomic)NSMutableArray* menuarray;
@property(nonatomic)NSIndexPath *selectedIndexPath;

@property(strong, nonatomic) LoginBackground* bgView;

@property(strong, nonatomic) UILabel* about;
@property(strong, nonatomic) UILabel* aboutdetail;

@property(strong, nonatomic) UIButton *button;
@property(strong, nonatomic) UIButton *detail;

@end

@implementation OriginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [self.sup setTitle:@"我的"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bgView = [[LoginBackground alloc] initWithFrame:CGRectMake(-50, -100, 500, 1100)];
    [self.view addSubview:self.bgView];
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
    self.circleView.center = self.view.center;
    self.circleView.alpha = 0.5;
    self.circleView.layer.cornerRadius = 100;
    self.circleView.backgroundColor = [UIColor clearColor];
    self.circleView.layer.borderColor = [UIColor grayColor].CGColor;
    self.circleView.layer.borderWidth = 3;
            
    UIGestureRecognizer* clickLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gologin)];
    [self.circleView addGestureRecognizer:clickLogin];
            
    [self.view addSubview:self.circleView];
            
    self.uilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    self.uilabel.center = self.view.center;
    self.uilabel.text = @"登录";
            
    self.uilabel.font = [UIFont systemFontOfSize:28];
    [self.view addSubview:self.uilabel];
}
- (OriginViewController*) initWithSuper:(UIViewController* ) sups {
    self = [self init];
    self.sup = sups;
    return self;
}



- (void)gologin {
    LoginController* lc = [[LoginController alloc] init];
    [self.navigationController pushViewController:lc animated:YES];
}

- (void)login:(UserLoginInfo*) user {
    self.user = user;
}

- (void)exitLogin {
    [self.navigationController popViewControllerAnimated:YES];
    ChangedViewController* cc = [[ChangedViewController alloc]initWithSuper:self];
    [self.navigationController pushViewController:cc animated:YES];
    
}



@end
