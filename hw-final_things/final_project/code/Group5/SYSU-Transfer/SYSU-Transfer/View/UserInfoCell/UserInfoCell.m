//
//  UserInfoCell.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/28.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoCell.h"

@implementation UserInfoCell

-(UserInfoCell *) initWith:(NSString*) title andwith:(NSString*) info{
    if(self=[super init]){
        self.title = title;
        self.info = info;
    }
    return self;
}

+(UserInfoCell *) initWith:(NSString*) title andwith:(NSString*) info{
    UserInfoCell* userinfocell = [[UserInfoCell alloc] initWith:title andwith:info];
    return userinfocell;
}
-(UserInfoCell *) initWith:(NSString*) title andNumber:(UInt64) number{
    if(self=[super init]){
        self.title = title;
        self.number = number;
    }
    return self;
}

+(UserInfoCell *) initWith:(NSString*) title andNumber:(UInt64) number{
    UserInfoCell* userinfocell = [[UserInfoCell alloc] initWith:title andNumber:number];
    return userinfocell;
}

@end
