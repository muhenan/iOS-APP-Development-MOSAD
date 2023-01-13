//
//  ViewController.m
//  ios-hw3-muhenan
//
//  Created by mac on 2020/12/8.
//

#import "ViewController.h"
#import "DisplayImages.h"
#import <AFNetworking/AFNetworking.h>


@interface ViewController ()

@end

@implementation ViewController

- (id)init{
    self = [super init];
    return  self;
}

- (void)loadView
{
    [super loadView];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.labelname];
    [self.view addSubview:self.labelpassword];
    [self.view addSubview:self.textViewName];
    [self.view addSubview:self.textViewPassword];
    
    [self.view addSubview:self.button];
}


-(UILabel *) labelname{
    if(_labelname == nil){
        _labelname = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
        _labelname.text = [[NSString alloc] initWithFormat:@"用户名："];
        _labelname.textAlignment = NSTextAlignmentRight;
        _labelname.adjustsFontSizeToFitWidth = YES;
        _labelname.layer.borderColor = [UIColor blackColor].CGColor;
        //_labelname.layer.borderWidth = 1.5;
    }
    return _labelname;
}

-(UILabel *) labelpassword{
    if(_labelpassword == nil){
        _labelpassword = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 30)];
        _labelpassword.text = [[NSString alloc] initWithFormat:@"密码："];
        _labelpassword.textAlignment = NSTextAlignmentRight;
        _labelpassword.adjustsFontSizeToFitWidth = YES;
        _labelpassword.layer.borderColor = [UIColor blackColor].CGColor;
        //_labelpassword.layer.borderWidth = 1.5;
    }
    return _labelpassword;
}

-(UILabel *) labellevel{
    if(_labellevel == nil){
        _labellevel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 30)];
        _labellevel.text = [[NSString alloc] initWithFormat:@"等级："];
        _labellevel.textAlignment = NSTextAlignmentRight;
        _labellevel.adjustsFontSizeToFitWidth = YES;
        _labellevel.layer.borderColor = [UIColor blackColor].CGColor;
        //_labellevel.layer.borderWidth = 1.5;
    }
    return _labellevel;
}

-(UILabel *) labelemail{
    if(_labelemail == nil){
        _labelemail = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 100, 30)];
        _labelemail.text = [[NSString alloc] initWithFormat:@"电子邮箱："];
        _labelemail.textAlignment = NSTextAlignmentRight;
        _labelemail.adjustsFontSizeToFitWidth = YES;
        _labelemail.layer.borderColor = [UIColor blackColor].CGColor;
        //_labelemail.layer.borderWidth = 1.5;
    }
    return _labelemail;
}

-(UILabel *) labelphone{
    if(_labelphone == nil){
        _labelphone = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 100, 30)];
        _labelphone.text = [[NSString alloc] initWithFormat:@"电话："];
        _labelphone.textAlignment = NSTextAlignmentRight;
        _labelphone.adjustsFontSizeToFitWidth = YES;
        _labelphone.layer.borderColor = [UIColor blackColor].CGColor;
        //_labelphone.layer.borderWidth = 1.5;
    }
    return _labelphone;
}

-(UITextView *) textViewName{
    if (_textViewName == nil) {
        _textViewName = [[UITextView alloc]initWithFrame:CGRectMake(150, 100, 200, 30)];
        _textViewName.layer.borderColor = [UIColor blackColor].CGColor;
        _textViewName.layer.borderWidth = 1.5;
        _textViewName.text = @"";
        [_textViewName setKeyboardType:UIKeyboardTypeDefault];
        [_textViewName setReturnKeyType:UIReturnKeyDone];
    }
    return _textViewName;
}

-(UITextView *) textViewPassword{
    if (_textViewPassword == nil) {
        _textViewPassword = [[UITextView alloc]initWithFrame:CGRectMake(150, 150, 200, 30)];
        _textViewPassword.layer.borderColor = [UIColor blackColor].CGColor;
        _textViewPassword.layer.borderWidth = 1.5;
        _textViewPassword.text = @"";
        [_textViewPassword setKeyboardType:UIKeyboardTypeDefault];
        [_textViewPassword setReturnKeyType:UIReturnKeyDone];
    }
    return _textViewPassword;
}

-(UITextView *) textViewEmail{
    if (_textViewEmail == nil) {
        _textViewEmail = [[UITextView alloc]initWithFrame:CGRectMake(150, 200, 200, 30)];
        _textViewEmail.layer.borderColor = [UIColor blackColor].CGColor;
        _textViewEmail.layer.borderWidth = 1.5;
        _textViewEmail.text = @"";
        [_textViewEmail setKeyboardType:UIKeyboardTypeDefault];
        [_textViewEmail setReturnKeyType:UIReturnKeyDone];
    }
    return _textViewEmail;
}

-(UITextView *) textViewPhone{
    if (_textViewPhone == nil) {
        _textViewPhone = [[UITextView alloc]initWithFrame:CGRectMake(150, 250, 200, 30)];
        _textViewPhone.layer.borderColor = [UIColor blackColor].CGColor;
        _textViewPhone.layer.borderWidth = 1.5;
        _textViewPhone.text = @"";
        [_textViewPhone setKeyboardType:UIKeyboardTypeDefault];
        [_textViewPhone setReturnKeyType:UIReturnKeyDone];
    }
    return _textViewPhone;
}

-(UIButton *)button{
    if (_button == nil) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100,100 )];
        [_button setShowsTouchWhenHighlighted:NO];
        [_button.layer setBorderWidth:1.0];
        [_button.layer setBorderColor:[UIColor blackColor].CGColor];
        [_button.layer setCornerRadius:10.0];
        [_button setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:240 / 255.0 blue:245 / 255.0 alpha:0.7]];
        NSString * aStr = @"登陆";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(0,2)];
        [_button setAttributedTitle:str forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)btnClick:(id)button{
    
    NSLog(@"Button is clicked");
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
//        self.textViewName.text, @"name", self.textViewPassword.text, @"pwd", nil];
//
//    NSError *parseError = nil;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
//
//    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
    
    
    //post
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
//
//    NSURL * url = [NSURL URLWithString:@"http://172.18.176.202:3333/hw3/signup"];
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//
//    [urlRequest setHTTPMethod:@"POST"];
//    
//    NSDictionary *dic = @{@"name":@"MOSAD",@"pwd":@"2020"};
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@",jsonString);
//
//    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
//         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"Response:%@ , error is %@\n", response, error);
//        if(error == nil) {
//            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//            NSLog(@"Data = %@",text);
//        }
//    }];
//    [dataTask resume];
    
    
    
//    //post wang yue qi
//    NSString *URL = @"http://172.18.176.202:3333/hw3/signup";
//    NSDictionary *body = @{
//        @"name":@"MOSAD",
//        @"pwd":@"2020"
//    };
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//    [manager POST:URL parameters:body headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//                } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject){
//        NSLog(@"msg is %@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject){
//        NSLog(@"fail");
//
//    }];
//
    // post zhou jing you
    AFHTTPSessionManager *signin = [[AFHTTPSessionManager alloc] init];
        signin.responseSerializer = [AFJSONResponseSerializer serializer];
        signin.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString *signinUrl = @"http://172.18.176.202:3333/hw3/signup";
         NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.textViewName.text forKey:@"name"];
        [params setObject:self.textViewPassword.text forKey:@"pwd"];

        [signin POST:signinUrl parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
                NSLog(@"登陆成功!前往用户信息");
                AFHTTPSessionManager *userInfo = [[AFHTTPSessionManager alloc] init];
                userInfo.responseSerializer = [AFJSONResponseSerializer serializer];
                userInfo.requestSerializer = [AFHTTPRequestSerializer serializer];
                NSString *userInfoUrl = @"http://172.18.176.202:3333/hw3/getinfo?name=MOSAD";
                [userInfo GET:userInfoUrl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"获取用户信息成功");
                    //用户信息一旦获取成功，就说明已经登陆了
                    
                    self.button.hidden = YES;
                    [self.view addSubview:self.buttonToImage];
                    
                    self.labelpassword.hidden = YES;
                
                    [self.view addSubview:self.labellevel];
                    [self.view addSubview:self.labelemail];
                    [self.view addSubview:self.labelphone];
                    
                    self.textViewName.text = [responseObject valueForKey:@"name"];
                    self.textViewName.editable = NO;
                    
                    self.textViewPassword.text = [responseObject valueForKey:@"level"];
                    self.textViewPassword.editable = NO;
                    
                    self.textViewEmail.text = [responseObject valueForKey:@"email"];
                    self.textViewEmail.editable = NO;
                    
                    self.textViewPhone.text = [responseObject valueForKey:@"phone"];
                    self.textViewPhone.editable = NO;
                
                    [self.view addSubview:self.textViewEmail];
                    [self.view addSubview:self.textViewPhone];
                    
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"获取用户信息失败");
                }];
            } else {
                NSLog(@"登陆失败！账号或密码错误");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"账号或密码错误" preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"OK Action");
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"Cancel Action");
                }];

                [alert addAction: okAction];
                [alert addAction: cancelAction];

                [self presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"登陆失败!请求访问错误");
        }];
    
    //Get
    
    //static NSString * str;
    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
//    delegate: self delegateQueue: [NSOperationQueue mainQueue]];
//    NSURL * url = [NSURL URLWithString:@"http://172.18.176.202:3333/hw3/getinfo?name=MOSAD"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request
//        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if(error == nil){
//                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//                NSString *jsonData = [text dataUsingEncoding:NSUTF8StringEncoding];
//                NSError *error = nil;
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//                //str = [[NSString init] initWithString:text];
//                NSLog(@"Data = %@",text);
//
//                self->_textViewName.text = [dic objectForKey:@"name"];
//                self->_textViewName.editable = NO;
//            }else{
//                NSLog(@"error!");
//            }
//        }
//    ];
//    [dataTask resume];
    
    //NSLog(@"yes is %@",str);
    
    NSLog(@"%@", self.textViewName.text);
    NSLog(@"%@", self.textViewPassword.text);
    
//     //JSON to Dictionary
//    NSString *jsonData = [text dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error = nil;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments
//    error:&error];
    
    //NSLog(@"hello");
    
}


-(UIButton *)buttonToImage{
    if (_buttonToImage == nil) {
        _buttonToImage = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height/2-50, 150,100 )];
        [_buttonToImage setShowsTouchWhenHighlighted:NO];
        [_buttonToImage.layer setBorderWidth:1.0];
        [_buttonToImage.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonToImage.layer setCornerRadius:10.0];
        [_buttonToImage setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:240 / 255.0 blue:245 / 255.0 alpha:0.7]];
        NSString * aStr = @"查看图片";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(0,4)];
        [_buttonToImage setAttributedTitle:str forState:UIControlStateNormal];
        [_buttonToImage addTarget:self action:@selector(btnToImageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonToImage;
}

-(void)btnToImageClick:(id)sender{
    //跳转到图片的界面
    DisplayImages * displayImages = [[DisplayImages alloc] init];
    [self addChildViewController:displayImages];
    [self.view addSubview:displayImages.view];
}


@end
