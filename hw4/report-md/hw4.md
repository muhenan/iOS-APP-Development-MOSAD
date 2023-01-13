[TOC]

# MOSAD 第四次作业

学号：18342076

姓名：母贺楠



因为时间有限，这里并没有实现多线程，实现的界面也比较简陋，但是实现了音频视频播放的各项功能。

本次多媒体编程，我实现的是 AVAudioPlayer进行音频播放、AVPlayer进行视频播放。因为图片的浏览在作业三已有展示所以这里只做了视频和音频的播放。

因为这次不能现场验收，所以录了一个视频放在B站，链接在如下（一定要看哦）：



运行结果如下：

![image-20210116224942964](/Users/mac/Desktop/MOSAD-Projects/hw4-things/report-md/hw4.assets/image-20210116224942964.png)



本次的报告主要来说明两个部分：

* 视频播放
* 音频播放

下面是一些主要代码的逻辑说明。



## 视频播放



### 声明变量

```objective-c
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController  *playerView;
```

视频播放的用到的 AVPlayer 和 AVPlayerViewController



### 三个按钮

视频播放这里用到了三个按钮，分别是：

* 下载
* 播放
* 停止播放

```objective-c
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 350, 100, 40);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"停止播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *buttondownload = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondownload.frame = CGRectMake(140, 350, 100, 40);
    buttondownload.backgroundColor = [UIColor blueColor];
    [buttondownload setTitle:@"下载" forState:UIControlStateNormal];
    [buttondownload addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttondownload];
    
    UIButton *buttonplay = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonplay.frame = CGRectMake(270, 350, 100, 40);
    buttonplay.backgroundColor = [UIColor greenColor];
    [buttonplay setTitle:@"播放" forState:UIControlStateNormal];
    [buttonplay addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonplay];
```

进行了三个按钮的UI设置。



### 按钮对应的点击函数

下面是三个按钮对应的触发函数：

下载：

```objective-c
- (void)download{
    NSLog(@"Button download is clicked");
    
    NSString* videoUrl = @"https://v-cdn.zjol.com.cn/280443.mp4";
    NSURL *url = [NSURL URLWithString:videoUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.player = [[AVPlayer alloc]initWithPlayerItem:item];
    //给AVPlayer一个播放的layer层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    layer.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    //设置AVPlayer的填充模式
    layer.videoGravity = AVLayerVideoGravityResize;
    
    [self.view.layer addSublayer:layer];
}
```

​	在下载的点击函数中，首先进行了AVPlayer 的一些设置，然后进行了视频的下载，并进行一些相关的设置，为接下来的播放做好准备。

播放：

```objective-c
- (void)play{
    [_player play];
}
```

​	进行视频的播放。

停止播放：

```objective-c
- (void)back{
    [_player pause];
}
```

​	暂停视频的播放。



## 音频播放



### 声明变量

```objective-c
//开始按钮
@property (nonatomic, strong) UIButton * btnPlay;
//调整音量按钮
@property (nonatomic, strong) UIButton * btnStop;
//暂停按钮
@property (nonatomic, strong) UIButton * btnPause;;
//播放进度
@property (nonatomic, strong) UIProgressView * musicProgress;
//声音大小调整
@property (nonatomic, strong) UISlider * volumSlider;
//音频播放器
@property (nonatomic, strong) AVAudioPlayer * musicplayer;
//计时器
@property (nonatomic, strong) NSTimer * timer;
//表示调节音量的条是否显示
@property int volumSliderIsShow;
```



### 三个按钮

```objective-c

    _btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _btnPlay.frame = CGRectMake(30, 500, 80, 50);
    [_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    [_btnPlay addTarget:self action:@selector(playmusic) forControlEvents:UIControlEventTouchUpInside];

    _btnStop.frame = CGRectMake(140, 500, 120, 50);
    [_btnStop setTitle:@"调整音量大小" forState:UIControlStateNormal];
    [_btnStop addTarget:self action:@selector(adjustVolumn) forControlEvents:UIControlEventTouchUpInside];
    
    _btnPause.frame = CGRectMake(300, 500, 80, 50);
    [_btnPause setTitle:@"暂停播放" forState:UIControlStateNormal];
    [_btnPause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btnPlay.backgroundColor = [UIColor yellowColor];
    _btnStop.backgroundColor = [UIColor yellowColor];
    _btnPause.backgroundColor = [UIColor yellowColor];

    
    [self.view addSubview:_btnPlay];
    [self.view addSubview:_btnStop];
    [self.view addSubview:_btnPause];
    
```

进行一些这三个按钮的UI设置。



### 三个按钮对应的点击函数

播放，调节音量，暂停。

```objective-c
//开始
-(void)playmusic{
    //开始播放
    [_musicplayer play];
}
//调节音量
-(void)adjustVolumn{
    if(_volumSliderIsShow == 0){
        _volumSliderIsShow = 1;
        _volumSlider.hidden = NO;
    }else{
        _volumSliderIsShow = 0;
        _volumSlider.hidden = YES;
    }
}
//暂停
-(void)pause{
    [_musicplayer pause];
}
```

调节音量这里，根据 _volumSliderIsShow 的情况决定是否显示 volumSlider，并进行相应的复制。



### 音乐播放的进度条

```objective-c
    //进度条
    _musicProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 620, 300, 20)];
    _musicProgress.progress = 0;
    [self.view addSubview:_musicProgress];
```



### 音量调节

```objective-c
    //音量
    _volumSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 680, 300, 20)];
    _volumSlider.maximumValue = 100;
    _volumSlider.minimumValue = 0;
    [_volumSlider addTarget:self action:@selector(changeVolum:) forControlEvents:UIControlEventValueChanged];
    _volumSlider.value = 50;
    [self.view addSubview:_volumSlider];
    _volumSlider.hidden = YES;
```

开始时把调节音量的 Slider 调到了一半，并且设置为不显示，当点击调节音量大小时才会显示。



### 设置音乐播放器对象

```objective-c
-(void)creatVideo{
    //获取本地的资源文件路径
    NSString *str = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:str];
    
    _musicplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    //准备工作，解码工作
    [_musicplayer prepareToPlay];
    
    //循环的次数
    //-1 : 无限循环
    
    _musicplayer.numberOfLoops = -1;
    
    //设置音量大小
    _musicplayer.volume = 0.5;
    
    // 定义一个定时器，更新进度条
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
}
```

虽然这里函数名写的的 Video，但是这里是设置的音乐播放器对象，音量设置为一半和调节音量的 Slider相对应。



### 音量调节的函数

```objective-c
//音量修改
-(void)changeVolum:(UISlider *)slider{
    float  str  = [[NSString stringWithFormat:@"%.1f",slider.value/100] floatValue];
    //设置音量大小
    _musicplayer.volume = str;
}
```

获取音量调节 Slider 的值然后相应的对音乐播放器的音量进行赋值。