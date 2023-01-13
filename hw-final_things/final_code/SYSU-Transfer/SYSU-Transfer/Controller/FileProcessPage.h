//
//  FileProcessPage.h
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/5.
//  Copyright © 2021 itlab. All rights reserved.
//

#ifndef FileProcessPage_h
#define FileProcessPage_h

#import <UIKit/UIKit.h>
#import "../View/FileCell.h"
#import "CloudFilePage.h"
#import "MovePage.h"

@interface FileProcessPage : UIViewController

@property (nonatomic, strong)NSMutableArray<FileCell *> *cells;
@property (nonatomic, strong)CloudFilePage* parent;

- (instancetype)initWithCells:(NSMutableArray *)cells;

@end

#endif /* FileProcessPage_h */
