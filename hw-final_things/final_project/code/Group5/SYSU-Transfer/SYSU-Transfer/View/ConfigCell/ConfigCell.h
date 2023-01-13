//
//  ConfigCell.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef ConfigCell_h
#define ConfigCell_h
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@interface configcell:NSObject

@property (nonatomic,copy) NSString* title;

@property (nonatomic) UIImage* photo;

-(configcell *) initWith:(NSString*) title andwith:(UIImage*) photo;

+(configcell *) initWith:(NSString*) title andwith:(UIImage*) photo;

@end
#endif /* ConfigCell_h */
