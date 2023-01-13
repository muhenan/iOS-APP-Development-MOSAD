//
//  ConfigCell.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigCell.h"

@implementation configcell

-(configcell*) initWith:(NSString*) title andwith:(UIImage*) photo{
    if(self=[super init]){
        self.title = title;
        self.photo = photo;
    }
    return self;
}

+(configcell*) initWith:(NSString*) title andwith:(UIImage*) photo{
    configcell* cell = [[configcell alloc] initWith:title andwith:photo];
    return cell;
}
@end
