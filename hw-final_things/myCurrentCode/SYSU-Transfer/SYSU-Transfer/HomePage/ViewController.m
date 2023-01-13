//
//  ViewController.m
//  HomePage
//
//  Created by nz on 2020/12/19.
//

#import "ViewController.h"
#import "HomeViewController.h"
@interface ViewController ()
@property(strong, nonatomic) UIImage* HomeImage;
@property(strong, nonatomic) UIImage* HomeSelectedImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HomeImage = [UIImage imageNamed:@"home.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    self.HomeSelectedImage = [UIImage imageNamed:@"home_selected.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    UITabBarController* utbc = [[UITabBarController alloc] init];
    HomeViewController* home = [[HomeViewController alloc] init];
    [self setTitle:@"Home"];
    home.tabBarItem.title = @"Home";
    home.tabBarItem.image = self.HomeImage;
    [home.tabBarItem setImage:[self.HomeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [home.tabBarItem setSelectedImage:[self.HomeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    utbc.viewControllers = @[home];
    [self.navigationController setViewControllers:@[utbc]];
    // Do any additional setup after loading the view.
}


@end
