//
//  ViewController.m
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/21.
//  Copyright © 2020 itlab. All rights reserved.
//

#import "ViewController.h"
#import "RootTabBarController.h"
#import "View/LoginTextField.h"
#import "View/LoginBackground.h"
#import "Controller/RegisterViewController.h"

@interface ViewController ()

@property(strong, nonatomic) UILabel* namelabel;
@property(strong, nonatomic) UILabel* passwordlabel;
@property(strong, nonatomic) LoginTextField* username;
@property(strong, nonatomic) LoginTextField* password;
@property(strong, nonatomic) UIView* circleView;
@property(strong, nonatomic) UIView* circleView2;
@property(strong, nonatomic) LoginBackground* bgView;
@property(strong, nonatomic) UILabel* uilabel;
@property(strong, nonatomic) UIButton* button;
@property(strong, nonatomic) UIImage* ConfigImage;
@property(strong, nonatomic) UIImage* ConfigSelectedImage;
@property(strong, nonatomic) UIButton* RegisterButton;
@property(strong, nonatomic) UIButton* signin;
@property(strong, nonatomic) UIButton* signup;
@property(strong, nonatomic) UIImageView* logo;
@property(strong, nonatomic) UIButton* back;

@end

@implementation ViewController

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tabBarController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    self.title = @"用户登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(-175, -80, 500, 500)];
    self.circleView.layer.cornerRadius = 250;
    self.circleView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.1];
    [self.view addSubview:self.circleView];
    UIImage* logoimage = [UIImage imageNamed:@"double_duck.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    
    self.logo.layer.cornerRadius = 5;
    self.logo = [[UIImageView alloc] initWithImage:logoimage];
    self.logo.frame = CGRectMake(self.view.center.x-50, 175, 100, 100);
    self.logo.layer.cornerRadius = 50;
    self.logo.clipsToBounds = YES;
    [self.view addSubview:self.logo];
    self.uilabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-50, 275, 100, 50)];
    self.uilabel.text = @"双鸭快传";
    self.uilabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:self.uilabel];
    self.circleView2 = [[UIView alloc] initWithFrame:CGRectMake(250, 600, 300, 300)];
    self.circleView2.layer.cornerRadius = 150;
    self.circleView2.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.03];
    [self.view addSubview:self.circleView2];
    
    self.signin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.signin setFrame:CGRectMake(self.view.center.x-150, self.view.center.y+175, 300, 50)];
    [self.signin setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.1]];
    [self.signin setTitle:@"Sign in" forState:UIControlStateNormal];
    self.signin.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.signin setTitleColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.8] forState:UIControlStateNormal];
    [self.signin addTarget:self action:@selector(gologin) forControlEvents:UIControlEventTouchUpInside];
    [self.signin.layer setMasksToBounds:YES];
    [self.signin.layer setCornerRadius:5.0];
    [self.view addSubview:self.signin];
    
    self.signup = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.signup setFrame:CGRectMake(self.view.center.x-150, self.view.center.y+100, 300, 50)];
    [self.signup setBackgroundColor:[UIColor orangeColor]];
    [self.signup setTitle:@"Sign up" forState:UIControlStateNormal];
    self.signup.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.signup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signup addTarget:self action:@selector(registerButtonCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.signup.layer setMasksToBounds:YES];
    [self.signup.layer setCornerRadius:5.0];
    [self.view addSubview:self.signup];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    self.namelabel.text = @"用户名：";
    self.namelabel.font = [UIFont systemFontOfSize:15];
    self.namelabel.alpha = 0;
    [self.view addSubview:self.namelabel];
    
    self.username = [[LoginTextField alloc] initWithFrame:CGRectMake(110, 200, 250, 30)];
    self.username.placeholder = @"please enter email";
    self.username.layer.borderWidth = 1;
    self.username.layer.borderColor = [UIColor grayColor].CGColor;
    self.username.alpha = 0;
    self.username.spellCheckingType = UITextSpellCheckingTypeNo;
    self.username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.username];
    
    self.passwordlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 200, 30)];
    self.passwordlabel.text = @"密码：";
    self.passwordlabel.font = [UIFont systemFontOfSize:15];
    self.passwordlabel.alpha = 0;
    [self.view addSubview:self.passwordlabel];
    
    self.password = [[LoginTextField alloc] initWithFrame:CGRectMake(110, 250, 250, 30)];
    self.password.placeholder = @"please enter password";
    [self.password setSecureTextEntry:YES];
    self.password.layer.borderWidth = 1;
    self.password.layer.borderColor = [UIColor grayColor].CGColor;
    self.password.alpha =0;
    self.password.spellCheckingType = UITextSpellCheckingTypeNo;
    self.password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.password];
    
    self.button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button setFrame:CGRectMake(280, 300, 80, 40)];
    [self.button setTitle:@"登录" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.layer.borderColor = [UIColor blackColor].CGColor;
    self.button.layer.borderWidth = 1;
    [self.button setExclusiveTouch:YES];
    self.button.alpha = 0;
    [self.view addSubview:self.button];
    
    self.back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.back addTarget:self action:@selector(backCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.back setFrame:CGRectMake(180, 300, 80, 40)];
    [self.back setTitle:@"back" forState:UIControlStateNormal];
    [self.back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.back.layer.borderColor = [UIColor blackColor].CGColor;
    self.back.layer.borderWidth = 1;
    [self.back setExclusiveTouch:YES];
    self.back.alpha = 0;
    [self.view addSubview:self.back];
    
    // test
    // [self test];
}

- (void) test
{
    [self.password setText:@"test"];
    [self.username setText:@"test"];
    
    [self loginButtonClicked];
}


- (void)backCliked{
    [UIView animateWithDuration:0.25 animations:^{
        self.signin.alpha = 1;
        self.uilabel.alpha = 1;
        self.signup.alpha = 1;
        self.signin.alpha = 1;
        self.logo.alpha = 1;
        self.circleView.alpha = 1;
        self.circleView2.alpha = 1;
        self.button.alpha = 0;
        self.password.alpha = 0;
        self.passwordlabel.alpha = 0;
        self.username.alpha = 0;
        self.namelabel.alpha = 0;
        self.back.alpha = 0;
        //self.RegisterButton.alpha = 1;
    } completion:nil];
}

- (void)gologin {
    [UIView animateWithDuration:0.25 animations:^{
        self.signin.alpha = 0;
        self.uilabel.alpha = 0;
        self.signup.alpha = 0;
        self.signin.alpha = 0;
        self.logo.alpha = 0;
        self.circleView.alpha = 0;
        self.circleView2.alpha = 0;
        self.button.alpha = 1;
        self.password.alpha = 1;
        self.passwordlabel.alpha = 1;
        self.username.alpha = 1;
        self.namelabel.alpha = 1;
        self.back.alpha = 1;
        //self.RegisterButton.alpha = 1;
    } completion:nil];
    
}
- (void) registerButtonCliked{
    registerviewcontroller* registercontroller = [registerviewcontroller alloc];
    NSLog(@"here");
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self presentViewController:registercontroller animated:YES completion:nil];
}
- (void) loginButtonClicked{
    NSDictionary* data = @{@"username":self.username.text, @"password":self.password.text};
    NSString *url = @"/user/sign_in";
    
    extern AFHTTPSessionManager *httpManager;
    [httpManager POST:url parameters:data headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success %@", responseObject);
        
        [self JumpToRootController];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.signin.alpha = 1;
            self.logo.alpha = 1;
            self.uilabel.alpha = 1;
            self.signup.alpha = 1;
            self.signin.alpha =1;
            self.circleView.alpha = 1;
            self.circleView2.alpha = 1;
            self.button.alpha = 0;
            self.password.alpha = 0;
            self.passwordlabel.alpha = 0;
            self.username.alpha = 0;
            self.namelabel.alpha = 0;
            self.RegisterButton.alpha = 0;
        } completion:nil];
        
        /*
        [httpManager GET:@"/share" parameters:nil headers:nil progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSArray *arr = responseObject;
                      NSLog(@"share list(%ld) = %@", arr.count, responseObject);
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      NSLog(@"get share list fail");
                  }];
         */
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.username.text = @"";
            self.password.text = @"";
        }];
        [alertVc addAction:confirm];
        [self presentViewController:alertVc animated:YES completion:^{
            nil;
        }];
    }];
    
    
}

- (void)JumpToRootController
{
    RootTabBarContorller *RTC = [[RootTabBarContorller alloc] init];
    
    [self presentViewController:RTC animated: YES completion:nil];//跳转
    // [self dismissViewControllerAnimated: YES completion: nil ];//返回
}

@end
