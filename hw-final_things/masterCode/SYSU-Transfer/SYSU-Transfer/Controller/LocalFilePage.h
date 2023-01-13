//
//  LocalFilePage.h
//  SYSU-Transfer
//
//  Created by itlab on 2020/12/24.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef LocalFilePage_h
#define LocalFilePage_h

#import <UIKit/UIKit.h>
#import "../View/LocalFileCell.h"
#import "../FileManager.h"

@interface LocalFilePage : UIViewController

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) File *fileInfo;

@end

#endif /* LocalFilePage_h */
