//
//  Hero.h
//  SanguoByMuhenan
//
//  Created by mac on 2020/10/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hero : NSObject {
    NSString *name;
    NSString *country;
    int blood_value;
    int energy_value;
    int aggressivity;
}


- (int)FirstSkill;
- (int)SecondSkill;
- (int)NormalAttack;
- (BOOL)IsSkillOk;
- (void)ShowState;
- (void)ReduceBlood:(int)values;
- (NSString* ) getName;
- (int) getBlood;

+ (void) FightingBetween:(id) heroFirst
                     and:(id) heroSecond;
+ (id) GetARandomHero;

@end

@interface Zhangfei : Hero {
    
}

@end

@interface Lvbu :Hero {
    
}

@end

@interface Dianwei :Hero {
    
}

@end

@interface Liubei :Hero {
    
}

@end

@interface Guanyu :Hero {
    
}

@end

@interface Sunquan :Hero {
    
}

@end

@interface Huatuo :Hero {
    
}

@end

@interface Caocao :Hero {
    
}

@end

@interface Sunce :Hero {
    
}

@end

@interface Zhouyu :Hero {
    
}

@end

@interface Diaochan :Hero {
    
}

@end

NS_ASSUME_NONNULL_END

