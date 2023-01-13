//
//  UIWaveProgress.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/23.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UIWaveProgress_h
#define UIWaveProgress_h
#import <UIKit/UIKit.h>

@interface XLWaveProgress : UIView
/**
 进度 0~1
 */
@property (nonatomic ,assign) CGFloat progress;
/**
 文字颜色
 */
@property (nonatomic ,strong) UIColor *textColor;
/**
 文字字体
 */
@property (nonatomic ,strong) UIFont *textFont;
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
- (void)stop;

@end


#endif /* UIWaveProgress_h */
