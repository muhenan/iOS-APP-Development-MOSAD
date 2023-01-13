//
//  ViewController.m
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//



#import "ViewController.h"
#import "Page/Mypage.h"



@implementation ViewController

- (id)init{
    self = [super init];
    _num = 6;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    _time = [[NSMutableArray alloc]init];
    [_time  addObject:[dateFormatter dateFromString:@"2020.6.11"]];
    [_time addObject:[dateFormatter dateFromString:@"2020.7.23"]];
    [_time addObject:[dateFormatter dateFromString:@"2020.7.24"]];
    [_time addObject:[dateFormatter dateFromString:@"2020.8.13"]];
    [_time addObject:[dateFormatter dateFromString:@"2020.8.22"]];
    [_time addObject:[dateFormatter dateFromString:@"2020.9.30"]];
    _place = [[NSMutableArray alloc]init];
    [_place addObject:@"北京"];
    [_place addObject:@"天津"];
    [_place addObject:@"吉林"];
    [_place addObject:@"厦门"];
    [_place addObject:@"云南"];
    [_place addObject:@"江西"];
    _placename = [[NSMutableArray alloc]init];
    [_placename addObject:@"颐和园"];
    [_placename addObject:@"天津故里"];
    [_placename addObject:@"长白山"];
    [_placename addObject:@"鼓浪屿"];
    [_placename addObject:@"香格里拉"];
    [_placename addObject:@"庐山"];
    _heartget = [[NSMutableArray alloc]init];
    [_heartget addObject:@"颐和园位于中国北京市西北海淀区，占地290公顷（合4400亩），是一座巨大的皇家园林和清朝的行宫。修建于清朝乾隆年间、重建于光绪年间，曾属于清朝北京西郊三山五园之一。颐和园素以人工建筑与自然山水巧妙结合的造园手法著称于世，是中国园林顶峰时期的代表，1998年被评为世界文化遗产。"];
    [_heartget addObject:@"津门故里，系天津味儿最浓的古文化街，也是天津文化的发祥地。全街以明代永乐帝下诏敕建的天后宫为中心，著名的杨柳青年画、泥人张、狗不理包子和十八街麻花等，都开在这条街上。这些津门独特的市井商埠文化，对天津人的文化品性产生了深远的影响。"];
    [_heartget addObject:@"长白山横亘在吉林省东南部中朝两国的国境线上，犹如一条鳞光闪烁的巨龙，巍峨磅礴，横卧天际。是我国与五岳齐名、名光秀丽、景色迷人的关东第一山，因其主峰白头山多白色浮石与积雪而得名，素有千年积雪为年松，直上人间第一峰的美誉。长白山既神奇又壮美，有许多美妙动人的诸如神女浴躬池的传说故事，其垂直自然景观更为绚丽多姿，真乃一日可历四季景。如今，冬游长白山已不再是神话，一年四季都吸引海内外无数游人前来揽胜。"];
    [_heartget addObject:@"鼓浪屿位于厦门岛西南隅，与厦门市隔海相望，与厦门岛只隔一条宽600米的鹭江，轮渡5分钟可达。面积5平方公里，2万多人，为厦门市辖区。鼓浪屿原名圆沙洲、圆洲仔，因海西南有海蚀洞受浪潮冲击，声如擂鼓，明朝雅化为今名。由于历史原因，中外风格各异的建筑物在此地被完好地汇集、保留，有“万国建筑博览”之称。小岛还是音乐的沃土，人才辈出，钢琴拥有密度居全国之冠，又得美名“钢琴之岛”、“音乐之乡”。岛上气候宜人四季如春，无车马喧嚣，有鸟语花香，素有“海上花园”之誉。主要观光景点有日光岩、菽庄花园、皓月园，毓园、环岛路、鼓浪石、博物馆、郑成功纪念馆、海底世界和天然海滨浴场等，融历史、人文和自然景观于一体，为国家级风景名胜区，福建“十佳”风景区之首，全国35个著名景点之一。"];
    [_heartget addObject:@"独克宗花巷位于香格里拉独克宗古城北门，依托当地自然资源和人文历史底蕴，以传承和创新当地藏民族独特的民俗风情为载体，整合藏区非遗体验、酒店等，提供藏文化体验之旅。成功打造出了香格里拉旅游新地标。为深耕当地文化，独克宗花巷在项目筹建时就把其定位为香格里拉文化的聚集地和世人了解香格里拉的文化窗口，挨家挨户寻找非物质文化遗产的传承人，把最传统的手工艺品和非遗文化带到游客面前。"];
    [_heartget addObject:@"庐山（Mount. Lu）地处江西省北部的鄱阳湖盆地，九江市庐山区境内，滨临鄱阳湖畔，雄峙长江南岸。庐山山体呈椭圆形，长约25公里，宽约10公里，绵延的90余座山峰，犹如九叠屏风，屏蔽着江西的北大门。庐山以雄、奇、险、秀闻名于世，素有“匡庐奇秀甲天下”之美誉。巍峨挺拔的青峰秀峦、喷雪鸣雷的银泉飞瀑、瞬息万变的云海奇观、俊奇巧秀的园林建筑，一展庐山的无穷魅力。庐山尤以盛夏如春的凉爽气候为中外游客所向往，是国内久负盛名的风景名胜区和避暑游览胜地。"];
    _pic = [[NSMutableArray alloc]init];
    //1
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    //2
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    //3
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    //4
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];
    //5
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    //6
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEW]];
    [_pic addObject:[UIImage imageWithContentsOfFile:IMAGE_PATH_VIEWGRAY]];


     return self;
}

- (void)loadView
{
    [super loadView];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)viewDidLoad {
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
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"发现界面"];
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
    [self.view addSubview:_emptyBar];
    [self.view addSubview:_leadBar];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}

    


- (UISearchBar *) searchBar{
    if(_searchBar == nil){
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 88,  self.view.frame.size.width , 30)];
        _searchBar.placeholder = @"Search here";
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.layer.borderWidth = 1;
        _searchBar.layer.backgroundColor = [UIColor grayColor].CGColor;
        _searchBar.layer.borderColor = [UIColor grayColor].CGColor;
        _searchBar.delegate = self;
        _searchBar.keyboardType = UIKeyboardAppearanceDefault;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        //self.tableView.tableHeaderView = _searchBar;
    }
    return _searchBar;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"搜索成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *comfirmAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:comfirmAc];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 118, self.view.frame.size.width, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
       [_tableView setScrollEnabled:YES];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _tableView;
}

#pragma mark - 重写----设置有groupTableView有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.num; // 返回值是多少既有几个分区
}


#pragma mark - 重写----设置每个分区有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置一个标示符
    static NSString *cell_id = @"cell_id";
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    // 判断cell是否存在
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
    }
    // 分别给每个分区的单元格设置显示的内容
    if(indexPath.row == 0){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,@"时间： ",[dateFormatter stringFromDate:[_time objectAtIndex:indexPath.section]] ] ;
    }else if (indexPath.row == 1){
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,@"地点 ： ",[_place objectAtIndex:indexPath.section] ] ;
    }else if (indexPath.row == 2){
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,@"旅游心得 ： ",[_heartget objectAtIndex:indexPath.section] ] ;
    }
    return cell;
}

 //设置选中效果
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CheckRecord *checkpage = [[CheckRecord alloc]init];
    //[self.navigationController pushViewController:nav animated:YES];
    checkpage.num = _num;
    checkpage.time = _time[indexPath.section];
    checkpage.place = _place[indexPath.section];
    checkpage.placename = _placename[indexPath.section];
    checkpage.heartget = _heartget[indexPath.section];
    checkpage.pic1 = _pic[indexPath.section*6];
    checkpage.pic2 = _pic[indexPath.section*6+1];
    checkpage.pic3 = _pic[indexPath.section*6+2];
    checkpage.pic4 = _pic[indexPath.section*6+3];
    checkpage.pic5 = _pic[indexPath.section*6+4];
    checkpage.pic6 = _pic[indexPath.section*6+5];
    [self addChildViewController:checkpage];
    //加入动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"oglFlip";
    animation.duration = 0.5;
    animation.subtype = kCATransitionFromBottom;
    
    [self.view.layer addAnimation:animation forKey:nil];
    [self.view addSubview:checkpage.view];
}

#pragma mark - Table view data source

// 重新绘制cell边框

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 1.f;
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
            //lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
        }
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        //testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
    }
    //加入动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)];
    scaleAnimation.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.duration = 0.5;
    [cell.layer addAnimation:scaleAnimation forKey:@"transform"];
    // }
    
}


- (void)send:(NSArray *)arr {
    if(arr != nil){
        self.num ++;
        int i;
        //[_time addObject:arr[0]];
        for (i = 0; i < _time.count; i++) {
            NSComparisonResult result = [_time[i] compare:arr[0]];
            if (result == -1) {
                break;
            }
        }
        [_time insertObject:arr[0] atIndex:i];
        [_place insertObject:arr[1] atIndex:i];
        [_placename insertObject:arr[2] atIndex:i];
        [_heartget insertObject:arr[3] atIndex:i];
        [_pic insertObject:arr[4] atIndex:i*6];
        [_pic insertObject:arr[5] atIndex:i*6+1];
        [_pic insertObject:arr[6] atIndex:i*6+2];
        [_pic insertObject:arr[7] atIndex:i*6+3];
        [_pic insertObject:arr[8] atIndex:i*6+4];
        [_pic insertObject:arr[9] atIndex:i*6+5];

        [self.tableView reloadData];
    }
}



@end

