//
//  CommentCell.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/9.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentCell.h"

@interface CommentCell()

@property (nonatomic, strong) UILabel *comment;
@property (nonatomic, strong) NSMutableArray<UILabel *> *replyes;

@end

@implementation CommentCell

- (instancetype)loadCellWithComment:(NSString *)comment WithReplies:(NSMutableArray<NSString *> *)replies WithWide:(CGFloat)wide;
{
    self.replyes = [[NSMutableArray alloc] init];
    
    int x = 5;
    int y = 10;
    
    UILabel *c = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wide-2*x, 30)];
    c.numberOfLines = 0;
    c.text = comment;
    c.font = [UIFont boldSystemFontOfSize:20];
    [c sizeToFit];
    self.comment = c;
    [self addSubview:c];
    
    x = 20;
    y = y + c.frame.size.height + 5;
    UILabel *r;
    for (int i = 0; i < replies.count; i ++) {
        r = [[UILabel alloc] initWithFrame:CGRectMake(x, y, wide-2*x, 30)];
        r.numberOfLines = 0;
        r.text = replies[i];
        [r sizeToFit];
        
        [self.replyes addObject:r];
        [self addSubview:r];
        y = y + r.frame.size.height + 10;
    }
    
    self.height = y;
    self.backgroundColor = UIColor.clearColor;
    
    x = 3;
    UILabel *back = [[UILabel alloc] initWithFrame:CGRectMake(x, 5, wide-2*x, self.height)];
    // back.layer.borderColor = UIColor.blackColor.CGColor;
    // back.layer.cornerRadius = 2;
    // back.layer.borderWidth = 0.1;
    back.backgroundColor = UIColor.clearColor;
    [self addSubview:back];
    
    return self;
}

@end
