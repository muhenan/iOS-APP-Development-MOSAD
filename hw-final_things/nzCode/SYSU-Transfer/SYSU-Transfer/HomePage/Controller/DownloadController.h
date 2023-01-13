//
//  DownloadController.h
//  HomePage
//
//  Created by nz on 2020/12/26.
//

#ifndef DownloadController_h
#define DownloadController_h
#import <UIKit/UIKit.h>
#import "FileCellvh.h"
#import "AFNetworking.h"
@interface DownloadController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView* fileTable;
@property(nonatomic)NSMutableArray<FileCellvh*>* cells;
@property(nonatomic)UILabel* filelistname;
@property(nonatomic)UIButton* downloadButton;
@property(nonatomic)NSURL* uurl;
@end

#endif /* DownloadController_h */
