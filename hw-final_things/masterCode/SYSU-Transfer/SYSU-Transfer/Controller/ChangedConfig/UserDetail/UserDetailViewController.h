//
//  UserDetailViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UserDetailViewController_h
#define UserDetailViewController_h
#import <UIKit/UIKit.h>
#import "ChangedViewController.h"
@interface UserDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)NSString* name;
@property (nonatomic)NSString* email;
@property (nonatomic)NSString* used;
@property (nonatomic)NSString* max;
@property (strong, nonatomic)UITableView* detail;
@property(nonatomic)NSMutableArray* menuarray;
@property(strong, nonatomic)ChangedViewController* sup;

- (UserDetailViewController*) initWithUserName:(NSString* ) username andsup:(UIViewController*) sup andemail:(NSString*) email andused:(NSString*) used andmax:(NSString*) max; 

@end

#endif /* UserDetailViewController_h */
