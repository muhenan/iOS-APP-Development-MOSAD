//
//  StoreViewController.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/20.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef StoreViewController_h
#define StoreViewController_h
#import <UIKit/UIKit.h>

@interface StoreViewController :UIViewController

@property(strong, nonatomic) UIViewController* sup;
@property(nonatomic) NSString* used;
@property(nonatomic) NSString* max;


- (StoreViewController*) initWithSuper:(UIViewController* ) sups andused:(NSString* ) used andmax:(NSString* ) max;


@end
@interface CircularProgressView : UIView
/// 0 ~ 100
@property (nonatomic) float progress;
@end
#endif /* StoreViewController_h */
