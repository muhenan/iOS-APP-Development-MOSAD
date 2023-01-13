[TOC]

# MOSAD 第三次作业



学号：18342076

姓名：母贺楠



本次作业主要涉及以下几个部分：

* 发出网络请求，从服务器得到数据
* 下载网络图片到缓存
  * 从缓存中找图片
  * 删除缓存中的图片
* 下载过程中显示loading图标



## 1. 文件结构

文件的结构如下：

![image-20201211191747850](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211191747850.png)

因为这里并没有非常细致的分类，所以这里的文件结构比较简单，主要文件是其中的 ViewController 和 DisplayImages，这两个文件分别控制两个页面。

* ViewController 登陆和展示信息
  * 从这个界面跳转到 DisplayImages 对应的界面
* DisplayImages 展示图片（包括加载，清空，删除缓存三个按钮）



## 2. 准备工作

### 2.1 通过 Pod 添加用于网络访问的 AFNetworking 包

详细步骤如下：

在项目所在的文件夹中创建 Podfile文件

这个文件中要填写的内容如下：

```powershell
platform :ios, '14.2'
use_frameworks!

target 'ios-hw3-muhenan' do
    pod 'AFNetworking', '~> 4.0'
end
```

然后我们在命令行执行 Pod install 这样便成功将这个包添加到了我们的项目中



## 3. 代码部分

代码部分我主要介绍 ViewController 和 DisplayImages 的代码，因为主要是这两个代码构成这个项目的主体。



### 3.1 ViewController 登陆界面/展示信息

首先我们在 .h 文件中定义一些要用到的 UI 组件

```objective-c
//展示信息
@property (nonatomic, strong) UILabel *labelname;
@property (nonatomic, strong) UILabel *labelpassword;

@property (nonatomic, strong) UILabel *labellevel;
@property (nonatomic, strong) UILabel *labelemail;
@property (nonatomic, strong) UILabel *labelphone;

@property (nonatomic, strong) UITextView *textViewName;
@property (nonatomic, strong) UITextView *textViewPassword;
@property (nonatomic, strong) UITextView *textViewEmail;
@property (nonatomic, strong) UITextView *textViewPhone;

//登陆按钮
@property (nonatomic, strong) UIButton *button;
//跳转到下一个界面的按钮
@property (nonatomic, strong) UIButton *buttonToImage;
```

* 一些 UILabel 和 UITextView 用于输入信息和展示信息
* 两个button
  * 登陆
  * 转到下个界面



接下来我们首先设置一下这些 UI 组件的位置和格式情况，最后得到如图所示的界面

![image-20201211195333908](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211195333908.png)

登陆后的界面（这时的 textview 已经是不可编辑的了）：

![image-20201211221641384](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211221641384.png)

所有 UILabel 和 UITextView 的代码如下，设置了这些 UI 控件的位置和格式，但这些控件并不是在一开始时就全部显示，有些在一开始时即显示，而有些是在登陆成功之后，取得网络访问的到的信息才会显示，具体的显示情况在button 触发的函数中定义。

```objective-c

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
```



然后是登陆按钮的实现

```objective-c
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
```



定义好这些 UI 控件后，重点在于登陆按钮对应的点击函数，在这个函数中我们将完成网络请求，并控制这个 UI 控件的显示情况。

这个点击函数的大体逻辑如下：

* 首先通过输入的用户名和密码进行 post 访问
  * 如果成功，则验证是否返回了 success
    * 如果是 success，则提示 **登陆成功!前往用户信息**
      * 进行 get 访问，得到服务器返回的信息
        * 如果访问成功，则提示 **获取用户信息成功**
          * 把这个信息填入相应的UI控件
          * 控制哪些 UI 控件应该隐藏，哪些应该显示，哪些应该设置成不可编辑
        * 如果访问失败，则提示 **获取用户信息失败**
    * 如果是 fail，则提示 **登陆失败！账号或密码错误** ，并弹出提示框
  * 如果失败，提示 **登陆失败!请求访问错误**

在这个函数的实现中，我使用了**<AFNetworking/AFNetworking.h>** 库的一些方法，下面简单展示了一下 get 访问时的时候方法：

```objective-c
AFHTTPSessionManager *userInfo = [[AFHTTPSessionManager alloc] init];
userInfo.responseSerializer = [AFJSONResponseSerializer serializer];
userInfo.requestSerializer = [AFHTTPRequestSerializer serializer];
NSString *userInfoUrl = @"http://172.18.176.202:3333/hw3/getinfo?name=MOSAD";
[userInfo GET:userInfoUrl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"获取用户信息成功");
                    // 这里写访问成功时的各种操作！
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) 									 {
                    NSLog(@"获取用户信息失败");
  									// 这里写访问失败时的各种操作！
                	}];
```

总体而言这种访问的方法我感觉比官方的 NSURLSession 的方式要更容易，代码量也更少，起初我尝试的是用 NSURLSession 的方式，也能够完成，但试过 AFNetworking 后，发现其远远好于 NSURLSession。



这个登陆button触发的点击函数代码如下：

```objective-c
-(void)btnClick:(id)button{
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
}
```

当账号密码错误登陆失败时，会有提示情况如下：

![image-20201211221814643](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211221814643.png)

成功登陆后得到了下图所示的界面：

![image-20201211221641384](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211221641384.png)

可以看到这里隐藏了老的登陆按钮，多显示出了一个查看图片按钮，这个按钮没有太多特别的地方，主要是用于跳转到下个界面。

这个按钮的实现和对应的点击函数如下：

```objective-c
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
```

点击这个按钮后，我们成功跳转到下一个界面，即展示图片到界面。



### 3.2 DisplayImages 展示图片/保存图片到缓存/删除缓存中的图片

这个页面主要是用来展示图片，这里主要有三个功能：

* 加载
  * 从 cache 中找指定的图片，如果找不到则下载图片到cache，如果找到就直接显示图片到页面上
  * 加载到过程中要显示 loading 到图标
* 清空
  * 清空页面上的图片，而不清理 cache 中的图片
* 删除缓存
  * 删除cache 中的图片，并清空页面上的图片



首先我们在 .h 文件中定义一些要用到的 UI 控件和一些变量：

```objective-c
@interface DisplayImages : UIViewController<UITableViewDataSource>

//三个相应功能的 button
@property (nonatomic, strong) UIButton *buttonLoad;
@property (nonatomic, strong) UIButton *buttonClear;
@property (nonatomic, strong) UIButton *buttonClearCache;

//存图片 url 的数组
@property (nonatomic, strong) NSMutableArray *urls;
//存图片 完整路径的数组
@property (nonatomic, strong) NSMutableArray *filePaths;

//展示图片的 tableView
@property (nonatomic, retain) UITableView* tableView;

//两个 bool 变量，类似 flag，来表示是不是加载的过程，是不是清空页面的过程
@property (nonatomic) Boolean isloading;
@property (nonatomic) Boolean isclear;

@end
```



然后我们定义一下这三个button 的位置和 tableView 的格式，得到这样的简单效果：

![image-20201211223451756](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211223451756.png)

这些控件布局的代码如下：

```objective-c
// 加载按钮
-(UIButton*)buttonLoad{
    if(_buttonLoad == nil){
        _buttonLoad = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50,30 )];
        [_buttonLoad setShowsTouchWhenHighlighted:NO];
        [_buttonLoad.layer setBorderWidth:1.0];
        [_buttonLoad.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonLoad.layer setCornerRadius:10.0];
        [_buttonLoad setTitle:@"加载" forState: UIControlStateNormal];
        [_buttonLoad setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonLoad addTarget:self action:@selector(clickLoad:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLoad;
}

//清空按钮
-(UIButton*)buttonClear{
    if(_buttonClear == nil){
        _buttonClear = [[UIButton alloc]initWithFrame:CGRectMake(150, 50, 50,30 )];
        [_buttonClear setShowsTouchWhenHighlighted:NO];
        [_buttonClear.layer setBorderWidth:1.0];
        [_buttonClear.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonClear.layer setCornerRadius:10.0];
        [_buttonClear setTitle:@"清空" forState: UIControlStateNormal];
        [_buttonClear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonClear addTarget:self action:@selector(clickClear:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonClear;
}

//删除缓存按钮
-(UIButton*)buttonClearCache{
    if(_buttonClearCache == nil){
        _buttonClearCache = [[UIButton alloc]initWithFrame:CGRectMake(250, 50, 100,30 )];
        [_buttonClearCache setShowsTouchWhenHighlighted:NO];
        [_buttonClearCache.layer setBorderWidth:1.0];
        [_buttonClearCache.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonClearCache.layer setCornerRadius:10.0];
        [_buttonClearCache setTitle:@"删除缓存" forState: UIControlStateNormal];
        [_buttonClearCache setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonClearCache addTarget:self action:@selector(clickClearCache:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonClearCache;
}

// tableView
- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
       [_tableView setScrollEnabled:YES];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _tableView;
}

#pragma mark - 重写----设置有groupTableView有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5; // 返回值是多少既有几个分区
}

#pragma mark - 重写----设置每个分区有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
```



在这个类 init 时，我们也要进行一些操作：

* 对两个数组 urls 和 filepaths 进行复制，根据我们要下载的图片的 url 进行命名即可
* 将两个布尔变量赋值为 NO



table 的 每个 cell 的显示的逻辑如下：

1. 首先判断是不是 loading 状态，如果是，就显示一张默认的加载图标；如果不是，进行下一个判断
2. 判读是不是清空状态，如果是，图片显示 nil；如果不是，继续向下
3. 去 cache 中寻找这个 cell 对应的图片，如果找到，则显示这张图片；如果没找到，则显示 nil

代码如下：

```objective-c

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView  cellForRowAtIndexPath");
    // 设置一个标示符
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    // 判断cell是否存在
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
    }
    // 分别给每个分区的单元格设置显示的内容
    if(indexPath.row == 0){
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(_isloading){
            NSLog(@"set loading");
            [cell.imageView setImage:[UIImage imageNamed:@"loading-2.png"]];
        }else if(_isclear){
            NSLog(@"set nil from clear");
            [cell.imageView setImage:nil];
        }else{
            NSLog(@"no loading and clear");
            if ([fileManager fileExistsAtPath:[_filePaths objectAtIndex:indexPath.section]]) {
                NSData *dataPhoto = [NSData dataWithContentsOfFile:[_filePaths objectAtIndex:indexPath.section]];
                [cell.imageView setImage:[UIImage imageWithData:dataPhoto]];
            }else{
                [cell.imageView setImage:nil];
            }
        }
    }
    return cell;
}
```



接下来是三个按钮对应的点击函数：



加载对应的函数，主要逻辑为：

1. 先把标志着清空的变量设为 NO，标志着加载的变量设为 YES，进行 tableView 的 reloadData，让其显示加载的图标
2. 根据文件路径去找这五张图，如果没找到则进行下载
3. 将标志着加载的变量设为 NO，再次进行 tableView 的 reloadData，让其显示对应的cache中的图片

对应的代码情况如下：

```objective-c
-(void) clickLoad:(id)sender{
    NSLog(@"load is clicked");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    _isclear = NO;
    _isloading = YES;
    [_tableView reloadData];
    
    for(int i = 0; i < 5; i++){
        if([fileManager fileExistsAtPath:[_filePaths objectAtIndex:i]]){
            NSLog(@"photo%d exists", (i+1));
        }else{
            NSLog(@"photo%d doesn't exist", (i+1));
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_urls objectAtIndex:i]]];
            [data writeToFile:[_filePaths objectAtIndex:i] atomically:YES];
            NSLog(@"photo%d has been downloaded", (i+1));
        }
    }
    _isloading = NO;
    [_tableView reloadData];
    return;
}
```

由于加载的非常快，loading图标很难看出来，以下是截到的一个显示加载图标的情况：

![image-20201211225645894](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211225645894.png)

正常加载后的情况如图所示：

![image-20201211225845710](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211225845710.png)

清空对应的函数，把标志着清空的布尔变量设为 YES，进行 tableView 的 reloadData，让其显示空

具体代码如下：

```objective-c
-(void)clickClear:(id)sender{
    NSLog(@"clear is clicked");
    _isclear = YES;
    [_tableView reloadData];
}
```



删除缓存对应的函数，通过文件路径找对应图片，如果找个则删除相应的文件，最后进行 tableView 的 reloadData，让其显示空

具体代码如下：

```objective-c
-(void)clickClearCache:(id)sender{
    NSLog(@"clearCache is clicked");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for(int i = 0; i < 5; i++){
        if([fileManager fileExistsAtPath:[_filePaths objectAtIndex:i]]){
            NSLog(@"photo%d exists", (i+1));
            [fileManager removeItemAtPath:[_filePaths objectAtIndex:i] error:nil];
            NSLog(@"photo%d has been removed", (i+1));
        }else{
            NSLog(@"photo%d doesn't exist", (i+1));
        }
    }
    
    [_tableView reloadData];
}
```



清空和删除缓存后得到同样的页面：

![image-20201211225924481](https://gitee.com/mu-he-nan/mosad_-hw3/raw/master/report/18342076MuHeNan/img/image-20201211225924481.png)



## 4. 总结

通过我主要有以下收获：

1. 更加熟悉了 UI 组件的设计
2. 能通过 NSURLSession或AFNetworking库 两种方式进行网络访问
3. 学会用 Pod 的方式安装第三方库
4. iOS沙盒机制，能进行文件读，写，查找，删除等操作



​	本次实验中，有了之前几次作业的经验，纯代码 UI 布局已经变得不再那么困难，花些时间即可完成需要的布局。

​	随后是进行网络访问，刚开始的时候我使用了 NSURLSession 的一些方式进行网络访问，可能因为参数略多代码量也越来越多（对比 AFNetworking 的方法），虽然最后终于调通但中途我出了很多错，花了不少时间，在这之后我决心试试 AFNetworking 这个第三方库，果然这个库的方法参数更易理解，代码量也少了很多，没有出现什么问题

​	最后是图片下载，文件读，写，查找，删除等操作，这里不得不说官方自带的 NSFileManager 这个类真的非常好用，通过这个类，仅用几行代码就可以完成 文件读，写，查找，删除等操作，这也让加载和删除缓存的操作可以顺利实现。