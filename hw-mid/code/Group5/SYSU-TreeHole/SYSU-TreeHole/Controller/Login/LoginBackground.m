//
//  LoginBackground.m
//  piaoquan
//
//  Created by nz on 2020/10/28.
//

#import <Foundation/Foundation.h>
#import "LoginBackground.h"

@implementation LoginBackground


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1.0, 1.0, 1.0 ,0.2,
        0.5, 1.0, 0.5, 0.2,
        0.0, 0.0, 1.0, 0.2,
        0.0, 0.0, 0.0, 0.1,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, 2);

    CGPoint start = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint end = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat startRadius = 0.0f;
    CGFloat endRadius = 500;
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
    CGGradientRelease(gradient);
    gradient=NULL;
    CGColorSpaceRelease(rgb);
    
}

@end
