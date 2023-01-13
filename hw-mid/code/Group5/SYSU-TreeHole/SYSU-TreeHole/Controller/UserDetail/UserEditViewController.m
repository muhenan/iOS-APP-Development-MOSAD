//
//  UserEditViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEditViewController.h"
#import "UserDetailViewController.h"
#import <AFNetworking.h>
@implementation NewTextField1

static CGFloat leftMargin = 5;

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    bounds.origin.x = bounds.origin.x + leftMargin;
    return bounds;
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    bounds.origin.x = bounds.origin.x + leftMargin;
    return bounds;
    
}
@end
@interface UserEditViewController()

@property(strong, nonatomic) UILabel* namelabel;
@property(strong, nonatomic) NewTextField1* username;
@property(strong, nonatomic) UIButton* button;
@property(strong, nonatomic) UserDetailViewController* sup;

@end
@implementation UserEditViewController

- (UserEditViewController*) initWithSup:(UserDetailViewController* ) sups{
    self.sup = sups;
    return self;
}

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    self.namelabel.text = @"用户名：";
    self.namelabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.namelabel];
    
    self.username = [[NewTextField1 alloc] initWithFrame:CGRectMake(110, 200, 250, 30)];
    self.username.text = self.sup.name;
    self.username.layer.borderWidth = 1;
    self.username.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.username];
    
    self.button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self action:@selector(ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button setFrame:CGRectMake(280, 250, 80, 40)];
    [self.button setTitle:@"修改" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.layer.borderColor = [UIColor blackColor].CGColor;
    self.button.layer.borderWidth = 1;
    [self.button setExclusiveTouch:YES];
    [self.view addSubview:self.button];
}

- (void) ButtonClicked{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary* data = @{@"name":self.username.text};
    NSString* url = @"http://172.18.178.56/api/user/name";
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success %@", responseObject);
        self.sup.name = self.username.text;
        [self.sup viewDidLoad];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
@end
