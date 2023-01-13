//
//  main.m
//  SanguoByMuhenan
//
//  Created by mac on 2020/10/8.
//

#import <Foundation/Foundation.h>
#import "Hero.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //随机选择两名英雄
        id heroFirst = [Hero GetARandomHero];
        id heroSecond = [Hero GetARandomHero];
        
        //展示两名英雄的初始情况
        NSLog(@"被选中的两名英雄及其初始的状态如下：");
        [heroFirst ShowState];
        [heroSecond ShowState];
        
        NSLog(@" ");
        
        //开始打斗
        
        [Hero FightingBetween:heroFirst and:heroSecond];
    }
    return 0;
}
