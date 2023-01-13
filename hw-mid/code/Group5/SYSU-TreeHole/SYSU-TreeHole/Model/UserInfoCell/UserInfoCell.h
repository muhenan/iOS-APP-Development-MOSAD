//
//  UserInfoCell.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/28.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UserInfoCell_h
#define UserInfoCell_h
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface UserInfoCell:NSObject

@property (nonatomic,copy) NSString* title;

@property (nonatomic) NSString* info;
@property (nonatomic)UInt64 number;
-(UserInfoCell *) initWith:(NSString*) title andwith:(NSString*) info;

+(UserInfoCell *) initWith:(NSString*) title andwith:(NSString*) info;

-(UserInfoCell *) initWith:(NSString*) title andNumber:(UInt64) number;

+(UserInfoCell *) initWith:(NSString*) title andNumber:(UInt64) number;

@end

#endif /* UserInfoCell_h */
