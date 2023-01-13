//
//  StoreViewController.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/20.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreViewController.h"
#import "UIWaveProgress.h"
@interface StoreViewController(){
    XLWaveProgress *_waveProgress;
}
@end
@implementation StoreViewController

- (StoreViewController*) initWithSuper:(UIViewController* ) sups andused:(NSString* )used andmax:(NSString* )max{
    
    self = [self init];
    self.sup = sups;
    self.max = max;
    self.used = used;
    return self;
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"存储空间";
    UILabel* test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    test.backgroundColor = [UIColor blackColor];
    [self.view addSubview:test];
  
    UIView *waveContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    waveContainer.backgroundColor = [UIColor colorWithRed:190/255.0f green:232/255.0f blue:231/255.0f alpha:0.8];
    waveContainer.layer.cornerRadius = waveContainer.bounds.size.width/2.0f;
    waveContainer.layer.masksToBounds = true;
    waveContainer.center =CGPointMake(self.view.center.x, self.view.center.y-100);
    [self.view addSubview:waveContainer];
        
        
        //初始化波浪，需要设置字体大小、字体颜色、波浪背景颜色、前层波浪颜色、后层博浪颜色
        _waveProgress = [[XLWaveProgress alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
        _waveProgress.center = CGPointMake(waveContainer.bounds.size.width/2.0f, waveContainer.bounds.size.height/2.0f);
    double used = [self.used floatValue];
    double max = [self.max floatValue];
        double s = used /max;
        _waveProgress.progress = s;
        //波浪背景颜色，深绿色
        _waveProgress.waveBackgroundColor = [UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1];
        //前层波浪颜色
        _waveProgress.backWaveColor = [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1];
        //后层波浪颜色
        _waveProgress.frontWaveColor = [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1];
        //字体
        _waveProgress.textFont = [UIFont boldSystemFontOfSize:50];
        //文字颜色
        _waveProgress.textColor = [UIColor whiteColor];
        [waveContainer addSubview:_waveProgress];
        //开始波浪
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 1000, 40)];
    NSString* kb = @"KB";
    NSString* text = [NSString stringWithFormat:@"%@%@%@%@%@", self.used, kb, @"/", self.max, kb];
    label1.text = text;
    [label1 setFont:[UIFont systemFontOfSize:5]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label1];
        [_waveProgress start];
//        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(waveContainer.frame) + 50, self.view.bounds.size.width - 2*50, 30)];
//        [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
//        [slider setMaximumValue:1];
//        [slider setMinimumValue:0];
//        [slider setMinimumTrackTintColor:[UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]];
//        [self.view addSubview:slider];
    
}
//- (void)sliderMethod:(UISlider*)slider {
//    _waveProgress.progress = slider.value;
//}
@end
