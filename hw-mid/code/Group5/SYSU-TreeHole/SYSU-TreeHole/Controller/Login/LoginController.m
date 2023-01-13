//
//  LoginController.m
//  piaoquan
//
//  Created by nz on 2020/10/28.
//

#import "DataModel.h"
#import "LoginController.h"
#import "ChangedViewController.h"
#import "RegisterViewController.h"
#import <AFNetworking.h>
#import "../../View/SquarePage.h"
#import "../../View/UserDetailPage.h"

@implementation NewTextField

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

@interface LoginController ()
@property(strong, nonatomic) UILabel* namelabel;
@property(strong, nonatomic) UILabel* passwordlabel;
@property(strong, nonatomic) NewTextField* username;
@property(strong, nonatomic) NewTextField* password;
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


@property (nonatomic, strong) SquarePage *square;
@property (nonatomic, strong) UserDetailPage *detail;

@end

@implementation LoginController

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    self.title = @"用户登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(-175, -80, 500, 500)];
    self.circleView.layer.cornerRadius = 250;
    self.circleView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.1];
    [self.view addSubview:self.circleView];
    UIImage* logoimage = [UIImage imageNamed:@"logo.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    self.logo = [[UIImageView alloc] initWithImage:logoimage];
    self.logo.frame = CGRectMake(self.view.center.x-50, 175, 100, 100);
    self.logo.layer.cornerRadius = 50;
    [self.view addSubview:self.logo];
    self.uilabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-50, 275, 100, 50)];
    self.uilabel.text = @"TreeHole";
    self.uilabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:self.uilabel];
    self.circleView2 = [[UIView alloc] initWithFrame:CGRectMake(250, 600, 300, 300)];
    self.circleView2.layer.cornerRadius = 150;
    self.circleView2.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.03];
    [self.view addSubview:self.circleView2];
//    self.bgView = [[LoginBackground alloc] initWithFrame:CGRectMake(-50, -100, 500, 1100)];
//    [self.view addSubview:self.bgView];
//    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
//    self.circleView.center = self.view.center;
//    self.circleView.alpha = 0.5;
//    self.circleView.layer.cornerRadius = 100;
//    self.circleView.backgroundColor = [UIColor clearColor];
//    self.circleView.layer.borderColor = [UIColor grayColor].CGColor;
//    self.circleView.layer.borderWidth = 3;
//
//    UIGestureRecognizer* clickLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gologin)];
//    [self.circleView addGestureRecognizer:clickLogin];
//    [self.view addSubview:self.circleView];
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
//    self.uilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
//    self.uilabel.center = self.view.center;
//    self.uilabel.text = @"登录";
//
//    self.uilabel.font = [UIFont systemFontOfSize:28];
//    [self.view addSubview:self.uilabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    self.namelabel.text = @"邮箱名：";
    self.namelabel.font = [UIFont systemFontOfSize:15];
    self.namelabel.alpha = 0;
    [self.view addSubview:self.namelabel];
    
    self.username = [[NewTextField alloc] initWithFrame:CGRectMake(110, 200, 250, 30)];
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
    
    self.password = [[NewTextField alloc] initWithFrame:CGRectMake(110, 250, 250, 30)];
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
//    self.RegisterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.RegisterButton addTarget:self action:@selector(registerButtonCliked) forControlEvents:UIControlEventTouchUpInside];
//    [self.RegisterButton setFrame:CGRectMake(150, 200, 80, 40)];
//    [self.RegisterButton setTitle:@"注册" forState:UIControlStateNormal];
//    [self.RegisterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.RegisterButton.layer.borderColor = [UIColor blackColor].CGColor;
//    self.RegisterButton.layer.borderWidth = 1;
//    [self.RegisterButton setExclusiveTouch:YES];
//    self.RegisterButton.alpha = 0;
//    [self.view addSubview:self.RegisterButton];
    // Do any additional setup after loading the view.
    
    
    
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
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:registercontroller animated:YES];
}
- (void) loginButtonClicked{
    NSDictionary* data = @{@"name":self.username.text, @"password":self.password.text};
    NSString* url = @"http://172.18.178.56/api/user/login/pass";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success %@", responseObject);
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
@end
