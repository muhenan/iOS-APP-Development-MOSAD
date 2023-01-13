//
//  UploadController.h
//  HomePage
//
//  Created by nz on 2020/12/25.
//

#ifndef UploadController_h
#define UploadController_h
#import <UIKit/UIKit.h>
#import "FileCellvh.h"
#import "AFNetworking.h"

@interface UploadController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView* fileTable;
@property(nonatomic)NSMutableArray<FileCellvh*>* cells;
@property(nonatomic)UIButton* addFile;
@property(nonatomic)UILabel* filelistname;
@property(nonatomic)UIButton* uploadButton;
@end

#endif /* UploadController_h */
