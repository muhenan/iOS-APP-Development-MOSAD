//
//  DataModel.m
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/6.
//  Copyright © 2021 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "DataModel.h"

@implementation File

+(File *) dic2Object:(NSDictionary *)dic
{
    File *res = [[File alloc] init];
    
    NSArray *tmpArr;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    tmpArr = dic[@"children"];
    for (int i = 0; i < tmpArr.count; i ++) {
        [arr addObject:[File dic2Object:tmpArr[i]]];
    }
    res.children = [[NSArray alloc] initWithArray:arr];
    
    NSNumber *tmp;
    
    res.fullPath = dic[@"fullPath"];
    tmp = dic[@"id"];
    res.ID = [tmp integerValue];
    res.type = dic[@"type"];
    res.name = dic[@"name"];
    
    return res;
}

@end
