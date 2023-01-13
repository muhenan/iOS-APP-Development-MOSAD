
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController  *playerView;
@property int volumSliderIsShow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
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
    
    
    //初始化
    self.playerView = [[AVPlayerViewController alloc]init];
    
    _volumSliderIsShow = 0;
    
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
    
    
    //进度条
    _musicProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 620, 300, 20)];
    _musicProgress.progress = 0;
    [self.view addSubview:_musicProgress];
    
    
    //音量
    _volumSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 680, 300, 20)];
    _volumSlider.maximumValue = 100;
    _volumSlider.minimumValue = 0;
    [_volumSlider addTarget:self action:@selector(changeVolum:) forControlEvents:UIControlEventValueChanged];
    _volumSlider.value = 50;
    [self.view addSubview:_volumSlider];
    _volumSlider.hidden = YES;
    
    
    //创建播放器对象
    [self creatVideo];
}


- (void)back{
    NSLog(@"Button stop is clicked");
    [_player pause];
}

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

- (void)play{
    NSLog(@"Button play is clicked");
    [_player play];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showViewController:self.playerView sender:nil];
}



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

-(void)update{
    _musicProgress.progress = _musicplayer.currentTime/_musicplayer.duration;
}

//开始
-(void)playmusic{
    //开始播放
    [_musicplayer play];
}
//停止
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
//音量修改
-(void)changeVolum:(UISlider *)slider{
    float  str  = [[NSString stringWithFormat:@"%.1f",slider.value/100] floatValue];
    //设置音量大小
    _musicplayer.volume = str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
