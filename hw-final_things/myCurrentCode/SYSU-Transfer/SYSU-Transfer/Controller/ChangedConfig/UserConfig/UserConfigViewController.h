//
//  UserConfigViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef UserConfigViewController_h
#define UserConfigViewController_h
#import <UIKit/UIKit.h>
#import "ChangedViewController.h"
@interface UserConfigViewController :UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) ChangedViewController* sup;


- (UserConfigViewController*) initWithSuper:(ChangedViewController* ) sups andvalue:(long) value;


@end
#endif /* UserConfigViewController_h */
