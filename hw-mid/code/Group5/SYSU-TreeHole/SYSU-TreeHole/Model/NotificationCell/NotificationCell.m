//
//  NotificationCell.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/27.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationCell.h"
#import "DataModel.h"
@implementation NotificationCell

-(NotificationCell *) initWith:(NSString*) title andwith:(UIImage*) photo{
    if(self=[super init]){
        self.title = title;
        self.photo = photo;
    }
    return self;
}

+(NotificationCell *) initWith:(NSString*) title andwith:(UIImage*) photo{
    NotificationCell* cell = [[NotificationCell alloc] initWith:title andwith:photo];
    return cell;
}
-(void) setProperty:(NSString*)target andsource:(NSString*) source andread:(BOOL) read andtype:(NSString*) type andtime:(long) time andcontent:(NSString *)content{
    self.target = target;
    self.source = source;
    self.read = read;
    self.type = type;
    self.time = time;
    self.content = content;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.readImage.frame.size.width, 0, 414, 40)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    if([self.type isEqualToString:@"like"]){
        self.type = @"点赞了";
    }
    if([self.type isEqualToString:@"comment"]){
        self.type = @"评论了";
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@", self.target, self.type, @"你的内容"];
    [self addSubview:self.titleLabel];
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 414, 40)];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    self.contentLabel.text = self.content;
    [self addSubview:self.contentLabel];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(414-100, 40, 100, 30)];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", (a*1000 - self.time)/60/1000];
    self.timeLabel.text = [NSString stringWithFormat:@"%@%@", timeString, @"分钟前"];
    [self addSubview:self.timeLabel];
    if(self.read == NO){
        self.readImage = [[UIImageView alloc] initWithFrame:CGRectMake(350, 10, 32, 32)];
        UIImage* notice_photo = [UIImage imageNamed:@"notice.png" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
        self.readImage.image = notice_photo;
        [self addSubview:self.readImage];
    }
}

@end
