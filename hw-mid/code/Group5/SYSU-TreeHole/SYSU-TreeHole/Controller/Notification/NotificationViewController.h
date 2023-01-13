//
//  NotificationViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef NotificationViewController_h
#define NotificationViewController_h
#import <UIKit/UIKit.h>
#import "ChangedViewController.h"
@interface NotificationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)NSString* name;
@property (strong, nonatomic)UITableView* detail;
@property (nonatomic)NSMutableArray* menuarray;
@property (nonatomic)ChangedViewController* sup;

- (NotificationViewController*) initWithUserName:(NSString* ) username andsup:(ChangedViewController*) sup;

@end

#endif /* NotificationViewController_h */
