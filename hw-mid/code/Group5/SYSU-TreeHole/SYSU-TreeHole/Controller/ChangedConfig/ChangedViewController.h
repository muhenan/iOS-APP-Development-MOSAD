//
//  ChangedViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef ChangedViewController_h
#define ChangedViewController_h

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "LoginController.h"
#import "LoginBackground.h"

@interface ChangedViewController : UINavigationController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic)NSString* name;
@property(nonatomic)long _font;
@property(strong, nonatomic) UITableView* main;
- (ChangedViewController*) initWithSuper:(UIViewController* ) sups ;
-(void)resetname;
- (void) reloadData;
@end

#endif /* ChangedViewController_h */
