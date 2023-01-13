//
//  Hero.m
//  SanguoByMuhenan
//
//  Created by mac on 2020/10/8.
//


#import <Foundation/Foundation.h>
#import "Hero.h"

@implementation Hero


-(int)FirstSkill{
    return 10;
}

-(int)SecondSkill{
    NSLog(@"减少自己 20 的能力，加 20 的血量");
    energy_value -= 20;
    blood_value += 20;
    return 0;
}

-(BOOL)IsSkillOk{
    if(energy_value >= 20) return true;
    else return false;
}

-(int)NormalAttack{
    NSLog(@"以自己当前的攻击力，攻击对方");
    return aggressivity;
}

-(void)ShowState{
    NSLog(@"%@ %@ 血量：%d，能量：%d，攻击力：%d" ,name ,country, blood_value, energy_value, aggressivity);
    //NSLog(@"血量：%d，能量：%d，攻击力：%d", blood_value, energy_value, aggressivity);
}

-(void)ReduceBlood:(int)values{
    blood_value -= values;
}

-(NSString*)getName{
    return name;
}

-(int)getBlood{
    return blood_value;
}

+(void)FightingBetween:(id)heroFirst and:(id)heroSecond{
    int rounds = 1;
    int turn = 1;
    while(rounds <= 10){
        
        NSLog(@"第 %d 回合开始",rounds);
        
        [heroFirst ShowState];
        [heroSecond ShowState];
        
        if(turn%2 == 1){
            int SkillOrNormal = (int)(arc4random() % 3);
            if(SkillOrNormal != 0){
                if([heroFirst IsSkillOk]){
                    if(SkillOrNormal == 1){
                        NSString* tname = [heroFirst getName];
                        NSLog(@"%@ 释放一技能",tname );
                        int val = [heroFirst FirstSkill];
                        [heroSecond ReduceBlood:val];
                    }else{
                        NSString* tname = [heroFirst getName];
                        NSLog(@"%@ 释放二技能",tname );
                        int val = [heroFirst SecondSkill];
                        [heroSecond ReduceBlood:val];
                    }
                }else{
                    NSString* tname = [heroFirst getName];
                    NSLog(@"%@ 释放普通攻击",tname );
                    int val = [heroFirst NormalAttack];
                    [heroSecond ReduceBlood:val];
                }
            }else{
                NSString* tname = [heroFirst getName];
                NSLog(@"%@ 释放普通攻击",tname );
                int val = [heroFirst NormalAttack];
                [heroSecond ReduceBlood:val];
            }
        }else{
            
                int SkillOrNormal = (int)(arc4random() % 3);
                if(SkillOrNormal != 0){
                    if([heroSecond IsSkillOk]){
                        if(SkillOrNormal == 1){
                            NSString* tname = [heroSecond getName];
                            NSLog(@"%@ 释放一技能",tname );
                            int val = [heroSecond FirstSkill];
                            [heroFirst ReduceBlood:val];
                        }else{
                            NSString* tname = [heroSecond getName];
                            NSLog(@"%@ 释放二技能",tname );
                            int val = [heroSecond SecondSkill];
                            [heroFirst ReduceBlood:val];
                        }
                    }else{
                        NSString* tname = [heroSecond getName];
                        NSLog(@"%@ 释放普通攻击",tname );
                        int val = [heroSecond NormalAttack];
                        [heroFirst ReduceBlood:val];
                    }
                }else{
                    NSString* tname = [heroSecond getName];
                    NSLog(@"%@ 释放普通攻击",tname );
                    int val = [heroSecond NormalAttack];
                    [heroFirst ReduceBlood:val];
                }
        }
        
        [heroFirst ShowState];
        [heroSecond ShowState];
        
        NSLog(@"第 %d 回合结束",rounds);
        NSLog(@" ");
        
        if([heroFirst getBlood] <= 0 || [heroSecond getBlood] <= 0){
            if([heroFirst getBlood] <= 0 && [heroSecond getBlood] <= 0)
                NSLog(@"双方打成平手");
            else if([heroFirst getBlood] <= 0){
                NSString * tname = [heroSecond getName];
                NSLog(@"%@ 获得胜利",tname);
            }
            else{
                NSString * tname = [heroFirst getName];
                NSLog(@"%@ 获得胜利",tname);
            }
            return ;
        }
        
        turn++;
        rounds++;
    }
    
    if([heroFirst getBlood] == [heroSecond getBlood])
        NSLog(@"双方打成平手");
    else if([heroFirst getBlood] < [heroSecond getBlood]){
        NSString * tname = [heroSecond getName];
        NSLog(@"%@ 获得胜利",tname);
    }else{
        NSString * tname = [heroFirst getName];
        NSLog(@"%@ 获得胜利",tname);
    }
    
    return ;
}

+ (id) GetARandomHero{
    int temp = 0;
    temp = (int)(arc4random() % 11);
    if(temp == 0) return [[Lvbu alloc] init];
    else if(temp == 1) return [[Zhangfei alloc] init];
    else if(temp == 2) return [[Dianwei alloc] init];
    else if(temp == 3) return [[Liubei alloc] init];
    else if(temp == 4) return [[Guanyu alloc] init];
    else if(temp == 5) return [[Sunquan alloc] init];
    else if(temp == 6) return [[Huatuo alloc] init];
    else if(temp == 7) return [[Caocao alloc] init];
    else if(temp == 8) return [[Sunce alloc] init];
    else if(temp == 9) return [[Zhouyu alloc] init];
    else return [[Diaochan alloc] init];
}

@end




//实现各个英雄


@implementation Lvbu

-(id)init{
    self = [super init];
    if(self){
        name = @"吕布";
        country = @"群";
        blood_value = 50;
        energy_value = 50;
        aggressivity = 20;
    }
    return self;
}



-(int)FirstSkill{
    NSLog(@"消耗 20 能量，以 2 倍的攻击力攻击对方");
    energy_value -= 20;
    return aggressivity * 2;
}

@end



@implementation Zhangfei

-(id)init{
    self = [super init];
    if(self){
        name = @"张飞";
        country = @"蜀";
        blood_value = 70;
        energy_value = 40;
        aggressivity = 15;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，血量加 5，攻击力加 10，");
    energy_value -= 20;
    blood_value += 5;
    aggressivity += 10;
    return 0;
}

@end

@implementation Dianwei

-(id)init{
    self = [super init];
    if(self){
        name = @"典韦";
        country = @"魏";
        blood_value = 70;
        energy_value = 40;
        aggressivity = 15;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，血量加 5，伴随一次普通攻击");
    energy_value -= 20;
    blood_value += 5;
    return aggressivity;
}

@end

@implementation Liubei

-(id)init{
    self = [super init];
    if(self){
        name = @"刘备";
        country = @"蜀";
        blood_value = 40;
        energy_value = 40;
        aggressivity = 10;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，加血15，以5的攻击力攻击一次");
    energy_value -= 20;
    blood_value += 15;
    return 5;
}

@end

@implementation Guanyu

-(id)init{
    self = [super init];
    if(self){
        name = @"关羽";
        country = @"蜀";
        blood_value = 50;
        energy_value = 60;
        aggressivity = 20;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，血量减 20，以三倍的攻击力攻击");
    energy_value -= 20;
    blood_value -= 20;
    return 3*aggressivity;
}

@end

@implementation Sunquan

-(id)init{
    self = [super init];
    if(self){
        name = @"孙权";
        country = @"吴";
        blood_value = 40;
        energy_value = 60;
        aggressivity = 10;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，攻击力加倍");
    energy_value -= 20;
    aggressivity = aggressivity*2;
    return 0;
}

@end

@implementation Huatuo

-(id)init{
    self = [super init];
    if(self){
        name = @"华佗";
        country = @"群";
        blood_value = 30;
        energy_value = 60;
        aggressivity = 5;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"加血40，对方也加血5");
    energy_value -= 20;
    blood_value += 40;
    return -5;
}

@end


@implementation Caocao

-(id)init{
    self = [super init];
    if(self){
        name = @"曹操";
        country = @"魏";
        blood_value = 60;
        energy_value = 40;
        aggressivity = 15;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，血量加 5，攻击力加 5，以 5 的攻击力攻击一次");
    energy_value -= 20;
    blood_value += 5;
    aggressivity += 5;
    return 5;
}

@end


@implementation Sunce

-(id)init{
    self = [super init];
    if(self){
        name = @"孙策";
        country = @"吴";
        blood_value = 50;
        energy_value = 50;
        aggressivity = 20;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，攻击力加 10，并伴随一次普通攻击");
    energy_value -= 20;
    aggressivity += 10;
    return aggressivity;
}

@end

@implementation Zhouyu

-(id)init{
    self = [super init];
    if(self){
        name = @"周瑜";
        country = @"吴";
        blood_value = 40;
        energy_value = 70;
        aggressivity = 15;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，血量减 5，攻击力加 10，伴随一次加攻击力后的普通攻击");
    energy_value -= 20;
    blood_value -= 5;
    aggressivity += 10;
    return aggressivity;
}

@end


@implementation Diaochan

-(id)init{
    self = [super init];
    if(self){
        name = @"貂蝉";
        country = @"群";
        blood_value = 30;
        energy_value = 60;
        aggressivity = 5;
    }
    return self;
}


-(int)FirstSkill{
    NSLog(@"消耗 20 能量，血量加 10，对方血量减 10");
    energy_value -= 20;
    blood_value += 10;
    return 10;
}

@end
