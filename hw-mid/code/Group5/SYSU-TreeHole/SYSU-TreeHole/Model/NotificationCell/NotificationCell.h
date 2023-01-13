//
//  NotificationCell.h
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/27.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef NotificationCell_h
#define NotificationCell_h
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@interface NotificationCell:UITableViewCell

@property (nonatomic,copy) NSString* title;

@property (nonatomic) UIImage* photo;
@property (nonatomic)long time;
@property (nonatomic)NSString* source;
@property (nonatomic)NSString* target;
@property (nonatomic)BOOL read;
@property (nonatomic)NSString* content;
@property (nonatomic)NSString* type;
@property (nonatomic)UILabel* titleLabel;
@property (nonatomic)UILabel* contentLabel;
@property (nonatomic)UILabel* timeLabel;
@property (nonatomic)UIImageView* readImage;


-(NotificationCell *) initWith:(NSString*) title andwith:(UIImage*) photo;

+(NotificationCell *) initWith:(NSString*) title andwith:(UIImage*) photo;

-(void) setProperty:(NSString*)target andsource:(NSString*) source andread:(BOOL) read andtype:(NSString*) type andtime:(long) time andcontent:(NSString*) content;
@end

#endif /* NotificationCell_h */
