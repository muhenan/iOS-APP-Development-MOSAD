//
//  Mypage.m
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import "Mypage.h"
#import "../Const/Const.h"

@implementation Mypage

- (id) init{
    self = [super init];
    
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //背景渐变
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor colorWithRed:255 / 255.0 green:255/ 255.0 blue:0 / 255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:127 / 255.0 green:255 / 255.0 blue:0 / 255.0 alpha:1.0].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
    _leadBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"我的"];
    //把导航栏集合添加到导航栏中，设置动画关闭
    [_leadBar pushNavigationItem:navItem animated:NO];
    //将标题栏中的内容全部添加到主视图当中
    
    
    _emptyBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *avItem = [[UINavigationItem alloc] initWithTitle:@""];
    //把导航栏集合添加到导航栏中，设置动画关闭
    [_emptyBar pushNavigationItem:avItem animated:NO];
    
    [_emptyBar setShadowImage:[UIImage new]];
    //将标题栏中的内容全部添加到主视图当中
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emptyBar];
    [self.view addSubview:_leadBar];
    
    [self.view addSubview:self.button];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


-(UIButton *)button{
    if (_button == nil) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200,200 )];
        [_button setShowsTouchWhenHighlighted:NO];
        [_button.layer setBorderWidth:1.0];
        [_button.layer setBorderColor:[UIColor blackColor].CGColor];
        [_button.layer setCornerRadius:10.0];
        [_button setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:240 / 255.0 blue:245 / 255.0 alpha:0.7]];
        NSString * aStr = @"登陆";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(0,2)];
        [_button setAttributedTitle:str forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)btnClick:(id)sender{
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect"; //声波效果
    animation.duration = 1;
    animation.subtype = kCATransitionFromBottom;
    
    [self.view.layer addAnimation:animation forKey:nil];
    
    
    _button.hidden = YES;
    [self.view addSubview:self.buttonlogin];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.label];
}


-(UIButton *)buttonlogin{
    if (_buttonlogin == nil) {
        _buttonlogin = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-90, self.view.frame.size.height/2-220, 180,180 )];
        [_buttonlogin setShowsTouchWhenHighlighted:NO];
        [_buttonlogin.layer setBorderWidth:1.0];
        [_buttonlogin.layer setBorderColor:[UIColor blackColor].CGColor];
        [_buttonlogin.layer setCornerRadius:0.0];
        [_buttonlogin setBackgroundImage:[UIImage imageWithContentsOfFile:IMAGE_PATH_TOU] forState:UIControlStateNormal];
    }
    return _buttonlogin;
}

- (UILabel *) label{
    if(_label == nil){
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 350, 200, 120)];
        _label.text = @"  用户名:\n  邮箱:\n  电话:";
        _label.font =  [UIFont systemFontOfSize:20];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 3;
        [_label.layer setBorderColor:[UIColor blackColor].CGColor];
        [_label.layer setBorderWidth:2.0];
        _label.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString * attriString =  [[NSMutableAttributedString alloc] initWithString:_label.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];//设置距离
        [attriString addAttribute:NSParagraphStyleAttributeName
                            value:paragraphStyle
                            range:NSMakeRange(0, [_label.text length])];
        _label.attributedText = attriString;
    }
    return _label;
}


- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4-50, 450, self.view.frame.size.width/2+100, 300) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //UIView *tableViewBGView = [[UIView alloc]initWithFrame: self.view.frame];
        //tableViewBGView.backgroundColor = [UIColor brownColor];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setScrollEnabled:YES];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _tableView;
}



#pragma mark - 重写----设置有groupTableView有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 返回值是多少既有几个分区
}


#pragma mark - 重写----设置每个分区有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 分别设置每个分组上面显示的单元格个数
    switch (section) {
        case 0:
            return 4;
            break;
        default:
            break;
    }
    return 1;
}

 - (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     return @"关于";
 }
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置一个标示符
    static NSString *cell_id = @"cell_id";
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    // 判断cell是否存在
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    // 分别给每个分区的单元格设置显示的内容
    if(indexPath.row == 0){
        cell.textLabel.text = [NSString stringWithFormat:@"版本："];
    }else if (indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"隐私和cookie："];
    }else if (indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存："];
    }else if (indexPath.row == 3){
        cell.textLabel.text = [NSString stringWithFormat:@"同步："];
    }
    return cell;
}
//边框
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        CGFloat cornerRadius = 10.f;
        
        cell.backgroundColor = UIColor.clearColor;//！！！！！
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        //颜色修改
        
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.0f].CGColor;
        
        layer.strokeColor=[UIColor blackColor].CGColor;
        
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
    }
    
    
}
@end
