//
//  AwardViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef AwardViewController_h
#define AwardViewController_h
#import <UIKit/UIKit.h>
@interface AwardViewController :UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UIViewController* sup;

- (AwardViewController*) initWithSuper:(UIViewController* ) sups;

@end

#endif /* AwardViewController_h */
