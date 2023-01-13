//
//  MovePage.h
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/6.
//  Copyright © 2021 itlab. All rights reserved.
//

#ifndef MovePage_h
#define MovePage_h

#import <UIKit/UIKit.h>
#import "../View/FileCell.h"
#import "../Model/DataModel.h"
#import <AFNetworking/AFNetworking.h>

@interface MovePage : UIViewController

@property (nonatomic, strong)NSMutableArray<FileCell *> *selectedCells;
@property (nonatomic, strong)NSString *path;
@property (nonatomic, strong)File *fileInfo;

- (instancetype)initWithPath:(NSString *)path WithCell:(NSMutableArray<FileCell *> *)cells;

@end

#endif /* MovePage_h */
