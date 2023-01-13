//
//  CloudFilePage.h
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef CloudFilePage_h
#define CloudFilePage_h

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "../Model/DataModel.h"
#import "../FileManager.h"

@interface CloudFilePage : UIViewController

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) File *fileInfo;

@end

#endif /* CloudFilePage_h */
