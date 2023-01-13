//
//  AwardCell.m
//  SYSU-TreeHole
//
//  Created by nz on 2020/11/17.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AwardCell.h"

@implementation awardcell
- (void) setController:(AwardViewController*)controller {
    
    self.acontrol = controller;
    
}
- (void) setProperty:(nonnull UIImage*) image1 with:(nullable UIImage*)image2 with:(nullable UIImage*) image3 canClick:(NSInteger) index andlen:(NSInteger) row {
    self.imageview1 = [[UIImageView alloc] initWithImage:image1];
    self.imageview1.frame = CGRectMake(20, 0, 120, 120);
    self.imageview1.layer.masksToBounds = YES;
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 120, 40)];
    NSInteger numbers1 = (row)*3+1;
    NSString *s1 = [NSString stringWithFormat:@"%ld",numbers1];
    NSString *string1 = @"award";
    NSString * strings1 =[[NSString alloc]initWithFormat:@"%@%@", string1, s1];
    self.label1.text = strings1;
    [self.label1 setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.label1];
    if(index == 1) {
        UIGestureRecognizer* addPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewPicture)];
        [self.imageview1 addGestureRecognizer:addPicture];
        self.imageview1.userInteractionEnabled = true;
    }
    
    [self addSubview:self.imageview1];
    
    if(image2 != nil) {
        self.imageview2 = [[UIImageView alloc] initWithImage:image2];
        self.imageview2.frame = CGRectMake(160, 0, 120, 120);
        self.imageview2.layer.masksToBounds = YES;
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 120, 120, 40)];
        NSInteger numbers2 = (row)*3+2;
        NSString *s2 = [NSString stringWithFormat:@"%ld",numbers2];
        NSString *string2 = @"award";
        NSString * strings2 =[[NSString alloc]initWithFormat:@"%@%@", string2, s2];
        self.label2.text = strings2;
        [self.label2 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.label2];
        if(index == 2) {
            UIGestureRecognizer* addPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewPicture)];
            [self.imageview2 addGestureRecognizer:addPicture];
            self.imageview2.userInteractionEnabled = true;
        }
        
        [self addSubview:self.imageview2];
    }
    if(image3 != nil) {
        self.imageview3 = [[UIImageView alloc] initWithImage:image3];
        self.imageview3.frame = CGRectMake(300, 0, 120, 120);
        self.imageview3.layer.masksToBounds = YES;
        self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(300, 120, 120, 40)];
        NSInteger numbers3 = (row)*3+3;
        NSString *s3 = [NSString stringWithFormat:@"%ld",numbers3];
        NSString *string3 = @"award";
        NSString * strings3 =[[NSString alloc]initWithFormat:@"%@%@", string3, s3];
        self.label3.text = strings3;
        [self.label3 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.label3];
        if(index == 3) {
            UIGestureRecognizer* addPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewPicture)];
            [self.imageview3 addGestureRecognizer:addPicture];
            self.imageview3.userInteractionEnabled = true;
        }
        
        [self addSubview:self.imageview3];
    }
}

@end
