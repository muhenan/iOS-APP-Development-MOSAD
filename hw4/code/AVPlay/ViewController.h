//
//  ViewController.h
//  AVPlay
//
//  Created by SXF on 2017/3/24.
//  Copyright © 2017年 SXF. All rights reserved.
//

#import <UIKit/UIKit.h>
//倒入视频音频系统库文件
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate>
//开始
@property (nonatomic, strong) UIButton * btnPlay;
//停止
@property (nonatomic, strong) UIButton * btnStop;
//暂停
@property (nonatomic, strong) UIButton * btnPause;;
//播放进度
@property (nonatomic, strong) UIProgressView * musicProgress;
//声音大小调整
@property (nonatomic, strong) UISlider * volumSlider;

//音频播放器
@property (nonatomic, strong) AVAudioPlayer * musicplayer;

@property (nonatomic, strong) NSTimer * timer;

@end

