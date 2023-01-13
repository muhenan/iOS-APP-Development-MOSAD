//
//  UIWave.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/23.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UIWave_h
#define UIWave_h
#import <UIKit/UIKit.h>

@interface XLWave : UIView

/**
 设置进度 0~1
 */
@property (assign,nonatomic) CGFloat progress;
/**
 前层波浪颜色
 */
@property (nonatomic ,strong) UIColor *frontWaveColor;
/**
 后层波浪颜色
 */
@property (nonatomic ,strong) UIColor *backWaveColor;
/**
 波浪背景色
 */
@property (nonatomic ,strong) UIColor *waveBackgroundColor;

/**
 开始
 */
- (void)start;

/**
 停止
 */
-(void)stop;

@end

#endif /* UIWave_h */
