# 中山大学数据科学与计算机学院本科生实验报告
## （2020年秋季学期）
| 课程名称 | IOS现代操作系统应用开发 | 任课老师 | 郑贵锋 |
| :------------: | :-------------: | :------------: | :-------------: |
| 年级 | 2018级 | 专业（方向） | 软件工程专业 |
| 学号 | 18343157 | 姓名 | 张云青 |
| 电话 | 13246848921 | Email |839259612@qq.com|
| 开始日期 | 2020.12 | 完成日期 | 2020.12.30|

---

## 一、实验题目
## 期末项目——英语单词学习软件YuYo

---

## 二、实现内容
### 本人负责的应用的实现部分：
    1.学习界面的设计实现
    2.详情页面的设计实现
    3.request模块即serverController的编写
    4.参与单例模式的编写
    5.参与应用功能和接口测试
    6.小组展示ppt的制作
    7.小组实验报告的撰写

---

## 三、实验结果
### (1)实验截图
#### 我负责设计编写的页面效果如下：

|            学习界面             |            详情页面             |
| :-----------------------------: | :-----------------------------: |
|![在这里插入图片描述](https://img-blog.csdnimg.cn/20200115230434798.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1poYW5neXVucWluZ0dD,size_16,color_FFFFFF,t_70)|![在这里插入图片描述](https://img-blog.csdnimg.cn/20200115230456717.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1poYW5neXVucWluZ0dD,size_16,color_FFFFFF,t_70)|
  
### (2)实验步骤以及关键代码
1. 学习页面比较简单，只有两个label和四张图片，图片是由多线程根据后端API进行下载的，关键代码如下：
```clike
- (void) callChildProcess:(int)num{
    // NSOperationQueue 实现: 创建自定义队列，添加到自定义队列中的操作，就会自动放到子线程中执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:num] forKey:@"index"];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImg:) object:dict];
    [queue addOperation:op];
}

- (void)downloadImg:(NSDictionary *)dict{
    int index = [dict[@"index"] intValue];
    NSURL *imageURL = [NSURL URLWithString:self.imgUrlArray[index]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    //写入文件
    NSString *imgPath = [NSString stringWithFormat:@"%@/image%@-%d.jpg",self.cache,_words[_index][@"word"],index];
    [imageData writeToFile:imgPath atomically:YES];
    [self.imageArray replaceObjectAtIndex:index withObject:imgPath];
    [self performSelectorOnMainThread:@selector(whenFinish:) withObject:(imgPath) waitUntilDone:(YES)];
}
```
放入label的单词是通过获取单例调用单例中的方法得到的，具体实现放在后面再说。

2. 详情页面与学习页面不同的地方在于详情页面的cell不仅包括图片也包括了图片对应的例句，这样可以实现图片与例句的一一对应。例句的cell在定义cell内容的时候调用set函数把collectionview的label赋值。set函数如下：
```clike
-(void)set:(NSString*)sentence
{
    _title.frame = CGRectMake(10,10,self.frame.size.width-50,50);
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.textAlignment=NSTextAlignmentLeft;
    _title.font=[UIFont systemFontOfSize:20];
    _image = [[UIImageView alloc] init];
    _image.frame = CGRectMake(10,70,150,150);
    _title.text = sentence;
    [self.contentView addSubview: _title];
    [self.contentView addSubview:_image];
}
```
另外在进入详情页面时会播放一遍单词音频，这部分是使用了负责音频学习模块的同学的代码，代码如下:
```
-(void)mp3{
    self.mp3URL=[[NSString alloc]initWithFormat:@"http://47.93.212.155/yuyo%@",_word[@"speech"]];
    NSURL *url = [NSURL URLWithString:self.mp3URL];
    MPMoviePlayerController *MPPlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    [self.view addSubview:MPPlayer.view];
    self.Player = MPPlayer;
    [self.Player prepareToPlay];
}
```
这些代码都是整理成函数后放在viewWillAppear中，这样无论在页面跳转和返回时都可以调用更新页面，这样页面跳转就可以不用反复push，而是可以更新完数据后pop。

3. 请求类的实现大致只有两个函数，Get和Post，分别对应两个请求。serverController中有baseurl属性，是API的前缀URL，要发送指令只需要对baseurl进行扩展即可。Get方法接受string类型参数，返回NSDictionary类型的数据，在单例模式中处理。Post接受string类型的指令输入和NSDictionary类型的数据输入，返回同样是NSDictionary类型的数据。另外serverController类中还有ProgressPost方法，这是因为反馈进度的API接受的是数组类型的数据，具体实现与Post函数大同小异。两种请求均使用NSURLSession，使用NSURLSessionDataTask的同步方法进行网络数据获取。数据使用NSJSONSerialization的JSONObjectWithData进行转化。代码如下：

Post函数：
```
-(NSDictionary*)Post:(NSDictionary*)data with: (NSString*)command {
    NSDictionary* ret_dic;
    // 构建并配置 Session
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    // 构建并配置 UrlRequest 网络请求
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,command]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方法为 POST
    [urlRequest setHTTPMethod:@"POST"];
    // 设置请求 Header 头部
    NSDictionary *headDict = [[NSDictionary alloc] initWithObjects:@[@"application/json"] forKeys:@[@"Content-Type"]];
    [urlRequest setAllHTTPHeaderFields:headDict];
    // 设置请求 Body 主体
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    [urlRequest setHTTPBody:bodyData];
    // 构建 NSURLSessionDataTask
    NSData *receive=[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    ret_dic = [NSJSONSerialization JSONObjectWithData:receive options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",ret_dic[@"success"]);
    return ret_dic;
}
```
Get函数
```
-(NSDictionary*)Get:(NSString*) command
{
    NSString*url = self->baseUrl;
    NSString*text;
    NSDictionary*dic;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat: @"%@%@", url, command]];
    NSLog([NSString stringWithFormat: @"%@%@", url, command]);
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *receive=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//二进制信息
    text = [[NSString alloc]initWithData:receive encoding:NSUTF8StringEncoding];//将二进制信息转换为字符串
    dic = [NSJSONSerialization JSONObjectWithData:receive options:NSJSONReadingMutableLeaves error:nil];//将二进制信息储存到字典中，方便取出信息
    return dic;
}
```
4. 单例模式负责处理serverController中返回的数据，单例类通过封锁init、new、alloc方法实现单例。根据需求的不同，单例类中包括了log_in、sign_up、get_progress、learn、get_word_detail、send_progress函数，这些函数先根据返回值的success字段判断数据是否正常获取，再将正确获取的数据存入自己的属性中。这里只举几个方法的实现，其他方法都大同小异。
log_in方法：
```
-(bool) log_in:(NSDictionary *)user_msg
{
    serverController* test = [[serverController alloc]init];
    NSDictionary*ret_dic = [test Post:user_msg with:@"login"];
    if([ret_dic[@"success"]  isEqual: @0])
    {
        self.err_msg = ret_dic[@"message"];
        NSLog(@"Error:%@",ret_dic[@"message"]);
        return false;
    }else{
        NSLog(@"LOGIN SUCCESS!");
        return true;
    }
}
```
learn方法:
```
}
-(bool)learn
{
    if([self get_progress])//getprogress success
    {
        serverController* test = [[serverController alloc]init];
        self.words_dic = [test Get:@"learn"];
        if([_words_dic[@"success"] isEqual:@0])//get word false
        {
            self.err_msg = _words_dic[@"message"];
            return false;
        }else{
            NSLog(@"GET WORDS SUCCESS!");
            //            self.detail_from_learn = true;
            return true;
        }
    }else//get progress false
    {
        return false;
    }
}
```
send_progress方法：
```
-(bool)send_progress:(NSMutableArray *)progress
{
    serverController* test = [[serverController alloc]init];
    NSDictionary* ret_dic = [test ProgressPost:progress with:@"learn/progress"];
    if([ret_dic[@"success"]  isEqual: @"false"])
    {
        self.err_msg = ret_dic[@"message"];
        NSLog(@"Error:%@",ret_dic[@"message"]);
        return false;
    }else{
        NSLog(@"POST PROGRESS SUCCESS!");
        return true;
    }
}
```
### (3)实验遇到的困难以及解决思路
1. 在学习界面下载图片时，每次的图片应该不一样，但是在实验中除了第一次下载，后面下载的图片都与第一次图片相同，但是正确答案的位置是不断改变的。这个问题困扰了我很久，后来经过反复测试猜想可能是缓存问题。结果上网查了后发现UIImageView有自己的缓存，用imageName方法获得的图片，会先在UIImageView的缓存中找同名的图片，找不到才再其他位置找。而我给图片的命名都是一样的，所以导致每次都是第一次的图片。后来认为最简单的方法就是给每张图片不同的命名，这个方法比较简单。
2. 一开始不知道从json格式转成dictionary格式时布尔型数据的数据类型，导致判断无法成功，后来反复试验才发现要用isEqual函数与@0判断才能得到正确的结果。
3. 一开始没有想到用单例的时候页面跳转比较麻烦，而且有很多传值的问题。后来用了单例之后问题解决。
---

## 四、实验思考及感想
这次大实验是对这一个学期知识的回顾与应用。通过团队完成实验的过程，我对课程上学习的知识认识更加深刻，以前不懂的地方在应用中也逐渐熟练。根据应用需求我也在网上查找了很多课程中没有的资料，这加深了我对这门课的理解。另外我还学会了应用与设计模式结合，以及团队合作的重要性。很多问题都是团队一起思考才得到解决的，而且当我们负责的部分合并后能出现我们意料之中的效果的感觉真的很棒。


