//
//  RegisterViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/20.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterViewController.h"
#import "../View/LoginTextField.h"

@interface registerviewcontroller ()

@property(strong, nonatomic) UILabel* namelabel;
@property(strong, nonatomic) UILabel* passwordlabel;
@property(strong, nonatomic) UILabel* emaillabel;
@property(strong, nonatomic) UILabel* nicklabel;
@property(strong, nonatomic) LoginTextField* username;
@property(strong, nonatomic) LoginTextField* password;
@property(strong, nonatomic) LoginTextField* email;
@property(strong, nonatomic) LoginTextField* nickname;
@property(strong, nonatomic) UIButton* button;
@property(strong, nonatomic) UIButton* back;
@property(strong, nonatomic) UIViewController* sup;
@property(nonatomic) bool bo;

@end
@implementation registerviewcontroller
- (registerviewcontroller*) initWithSuper:(UIViewController* ) sups {
    
    self = [self init];
    self.sup = sups;
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    self.title = @"用户注册";
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    self.namelabel.text = @"用户名：";
    self.namelabel.font = [UIFont systemFontOfSize:15];
    self.namelabel.alpha = 1;
    [self.view addSubview:self.namelabel];
    
    self.username = [[LoginTextField alloc] initWithFrame:CGRectMake(110, 200, 250, 30)];
    self.username.placeholder = @"please enter username";
    self.username.layer.borderWidth = 1;
    self.username.layer.borderColor = [UIColor grayColor].CGColor;
    self.username.alpha = 1;
    self.username.spellCheckingType = UITextSpellCheckingTypeNo;
    self.username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.username];
    
    self.passwordlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 200, 30)];
    self.passwordlabel.text = @"密码：";
    self.passwordlabel.font = [UIFont systemFontOfSize:15];
    self.passwordlabel.alpha = 1;
    [self.view addSubview:self.passwordlabel];
    
    self.password = [[LoginTextField alloc] initWithFrame:CGRectMake(110, 250, 250, 30)];
    self.password.placeholder = @"please enter password";
    [self.password setSecureTextEntry:YES];
    self.password.layer.borderWidth = 1;
    self.password.layer.borderColor = [UIColor grayColor].CGColor;
    self.password.alpha =1;
    self.password.spellCheckingType = UITextSpellCheckingTypeNo;
    self.password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.password];
    
    self.emaillabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 200, 30)];
    self.emaillabel.text = @"邮箱";
    self.emaillabel.font = [UIFont systemFontOfSize:15];
    self.emaillabel.alpha = 1;
    [self.view addSubview:self.emaillabel];
    
    self.email = [[LoginTextField alloc] initWithFrame:CGRectMake(110, 300, 250, 30)];
    self.email.placeholder = @"please enter email";
    self.email.layer.borderWidth = 1;
    self.email.layer.borderColor = [UIColor grayColor].CGColor;
    self.email.alpha = 1;
    self.email.spellCheckingType = UITextSpellCheckingTypeNo;
    self.email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.email];
    
    self.nicklabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 350, 200, 30)];
    self.nicklabel.text = @"昵称";
    self.nicklabel.font = [UIFont systemFontOfSize:15];
    self.nicklabel.alpha = 1;
    [self.view addSubview:self.nicklabel];
    
    self.nickname = [[LoginTextField alloc] initWithFrame:CGRectMake(110, 350, 250, 30)];
    self.nickname.placeholder = @"please enter nick name";
    self.nickname.layer.borderWidth = 1;
    self.nickname.layer.borderColor = [UIColor grayColor].CGColor;
    self.nickname.alpha = 1;
    self.nickname.spellCheckingType = UITextSpellCheckingTypeNo;
    self.nickname.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.nickname];
    
    self.button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self action:@selector(registerbuttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button setFrame:CGRectMake(280, 400, 80, 40)];
    [self.button setTitle:@"注册" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.layer.borderColor = [UIColor blackColor].CGColor;
    self.button.layer.borderWidth = 1;
    [self.button setExclusiveTouch:YES];
    self.button.alpha = 1;
    [self.view addSubview:self.button];
    
    self.back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.back addTarget:self action:@selector(backCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.back setFrame:CGRectMake(180, 400, 80, 40)];
    [self.back setTitle:@"back" forState:UIControlStateNormal];
    [self.back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.back.layer.borderColor = [UIColor blackColor].CGColor;
    self.back.layer.borderWidth = 1;
    [self.back setExclusiveTouch:YES];
    self.back.alpha = 1;
    [self.view addSubview:self.back];
}
- (void)POST:(NSString*)url anddata:(NSDictionary*) data{
    self.bo = NO;
    
    [self.httpManager POST:url parameters:data headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success %@", responseObject);
        
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            }];
        
        [alertVc addAction:confirm];
        [self presentViewController:alertVc animated:YES completion:^{
                nil;
            }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.email.text = @"";
            self.username.text = @"";
            self.password.text = @"";
            }];
        [alertVc addAction:confirm];
        [self presentViewController:alertVc animated:YES completion:^{
                nil;
            }];
    }];
}
- (void)registerbuttonClicked{
    NSDictionary* data = @{@"username":self.username.text, @"email":self.email.text, @"password":self.password.text, @"name":self.nickname};
    NSString* url = @"/user/sign_up";
    [self POST:url anddata:data];
}

- (void)backCliked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
