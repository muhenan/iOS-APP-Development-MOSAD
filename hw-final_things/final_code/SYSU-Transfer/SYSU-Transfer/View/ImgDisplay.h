
//
//  ImgDisplay.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/3.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef ImgDisplay_h
#define ImgDisplay_h

#import <UIKit/UIKit.h>
#import "../FileManager.h"

@interface ImgDisplay : UIViewController

- (ImgDisplay *) initWithPic:(UIImage *)pic withThumb:(NSString *)thumb;

@end

#endif /* ImgDisplay_h */
