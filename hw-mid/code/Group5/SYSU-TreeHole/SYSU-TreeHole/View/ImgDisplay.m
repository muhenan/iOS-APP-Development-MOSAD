//
//  ImgDisplay.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/3.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImgDisplay.h"

@interface ImgDisplay()

@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) UIImage *pic;

@end

@implementation ImgDisplay

- (ImgDisplay *) initWithPic:(UIImage *)pic withThumb:(NSString *)thumb
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    _thumb = thumb;
    _pic = pic;
    
    // pic = [UIImage imageNamed:@"add2.png"];
    
    CGFloat wide = self.view.frame.size.width-20;
    CGFloat high = wide;
    
    UIImageView *img = [[UIImageView alloc] initWithImage:pic];
    img.frame = CGRectMake(10, self.view.frame.size.height/2 - high/2 - 70, wide, wide);
    img.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:img];
    
    // add save button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    return self;
}

-(void) save
{
    NSLog(@"save %@", _thumb);
    
    if ([_thumb hasSuffix:@"png"]) {
        NSData *data = UIImagePNGRepresentation(_pic);
        [FileManager WriteFile:data ByName:_thumb];
        
        NSLog(@"save success");
    } else {
        NSLog(@"svae error");
    }
}

@end
