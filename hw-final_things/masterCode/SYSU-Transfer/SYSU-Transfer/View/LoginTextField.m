//
//  LoginController.m
//  piaoquan
//
//  Created by nz on 2020/10/28.
//

#import "DataModel.h"
#import "LoginTextField.h"
#import "LoginBackground.h"

@implementation LoginTextField

static CGFloat leftMargin = 5;

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    bounds.origin.x = bounds.origin.x + leftMargin;
    return bounds;
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    bounds.origin.x = bounds.origin.x + leftMargin;
    return bounds;
    
}
@end
