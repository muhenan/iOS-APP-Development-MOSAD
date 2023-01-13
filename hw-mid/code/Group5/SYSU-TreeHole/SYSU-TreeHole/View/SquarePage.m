//
//  SquarePage.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/12/3.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SquarePage.h"

@interface SquarePage() <UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIViewController *fst;
@property (nonatomic, strong) RequestController *Request;
@property (nonatomic, strong) ContentRes *publicContents;
@property (nonatomic, strong) NSMutableArray<ContentCell *> *cells;
@property (nonatomic, strong) UITableView *tbv;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *showList;
@property NSInteger isSearch;
@property (nonatomic, strong) UISearchBar *search;

@property NSInteger rate;
@property NSInteger state;

@end

@implementation SquarePage

- (id)init{
    self = [super init];
    _num = 9;
    _pic = [[NSMutableArray alloc]init];
    _showList = [[NSMutableArray alloc] init];
    _rate = 3;
    _state = 0;
    _isSearch = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentGetPublicListSuccess:) name:@"contentGetPublicListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentGetPublicListFailed:) name:@"contentGetPublicListFailed" object:nil];
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cells = [[NSMutableArray alloc] init];
    _Request = [RequestController shareInstance];
    
    //UIViewController
    _fst = [[UIViewController alloc] init];
    _fst.view.backgroundColor = UIColor.whiteColor;
    _fst.navigationItem.title = @"广场";
    
    [self pushViewController:_fst animated:YES];
    
    //tabBar
    self.tabBarItem.title = @"广场";
    self.tabBarItem.image = [[UIImage imageNamed:@"find.png"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"find_f.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //Search
    NSInteger x = 10;
    _search = [[UISearchBar alloc] initWithFrame:CGRectMake(x, 100, _fst.view.frame.size.width - 2*x, 30)];
    
    _search.layer.borderColor = [UIColor.grayColor CGColor];
    _search.layer.borderWidth = 1;
    _search.placeholder = @" 搜索框";
    _search.showsBookmarkButton = NO;
    _search.delegate = self;
    [_search setShowsCancelButton:YES animated:YES];
    [_fst.view addSubview:_search];
    
    [_fst.view addSubview:self.tableView];
    [self getPublicContent];
}

- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        // _tableView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
        [_tableView setScrollEnabled:YES];
        [_tableView setBounces:YES];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _tableView;
}

- (void)reloadTable
{
    [_cells removeAllObjects];
    for (int i = 0; i < _publicContents.contents.count; i ++) {
        ContentCell *cell = [[[ContentCell alloc] init] initWithContent:_publicContents.contents[i] withUserInfo:_publicContents.user[i] withWide:self.view.frame.size.width];
        // NSLog(@"type = %@", _publicContents.contents[i].type);
        // ContentCell *cell = [[ContentCell alloc] init];
        // [cell test:i];
        
        [_cells addObject:cell];
    }
    
    [self.tableView reloadData];
}

-(void)searchShow:(NSString *)str
{
    [_showList removeAllObjects];
    _isSearch = 1;

    for(int i = 0; i < _publicContents.contents.count; i ++) {
        if ([_publicContents.contents[i].name isEqualToString:str] || [_publicContents.contents[i].detail isEqualToString:str]){
            [_showList addObject:[[NSNumber alloc] initWithInt:i]];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - 重写----设置有groupTableView有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 返回值是多少既有几个分区
}


#pragma mark - 重写----设置每个分区有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch == 1) {
        return _showList.count;
    }
    
    return  _cells.count/_rate;
    // return self.publicContents.user.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearch == 1) {
        return _cells[[_showList[indexPath.row] integerValue]].cell_height;
    }
    
    return _cells[indexPath.row].cell_height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearch == 1) {
        return _cells[[_showList[indexPath.row] integerValue]];
    }
    return _cells[indexPath.row];
}

//设置选中效果
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CheckRecord *checkpage = [[CheckRecord alloc]init];
    [checkpage loadWithContent:_publicContents.contents[indexPath.row] withUserInfo:_publicContents.user[indexPath.row] withWide:self.view.frame.size.width];
    
    // 加入动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"oglFlip";
    animation.duration = 0.5;
    animation.subtype = kCATransitionFromBottom;
    
    [self.view.layer addAnimation:animation forKey:nil];
    [self pushViewController:checkpage animated:NO];
}

#pragma mark - Notification Observer
- (void)getPublicContent
{
    [_Request contentGetPublicListByPage:[NSNumber numberWithInteger:1] eachPage:[NSNumber numberWithInteger:_num]];
}

- (void)contentGetPublicListSuccess:(NSNotification *)notification
{
    NSLog(@"Public get success");
    _publicContents = [DataController contentGetPublicListByPage:[notification userInfo]];
    self.rate = 3;
    [self reloadTable];
    // [self.tableView reloadData];
}

- (void)contentGetPublicListFailed:(NSNotification *)notification
{
    NSLog(@"Public get fail");
}

#pragma mark - ScrollView Delegate
// 下拉刷新的原理
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < - 100) {
        
        [UIView animateWithDuration:1.0 animations:^{
            
            //  frame发生偏移,距离顶部150的距离(可自行设定)
            self.tableView.contentInset = UIEdgeInsetsMake(300.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished) {
            
            /**
             *  发起网络请求,请求刷新数据
             */
            
            NSLog(@"refresh");
            if (self.state == 0) {
                self.state = 1;
                [self getPublicContent];
            }
        }];
    }
}

// 上拉加载的原理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    NSLog(@"offset %f",scrollView.contentOffset.y);
    NSLog(@"%f",scrollView.frame.size.height);
    NSLog(@"%f",scrollView.contentSize.height);
    
    if (scrollView.contentOffset.y > 300) {
        self.state = 0;
    }
    
    /**
     *  关键-->
     *  scrollView一开始并不存在偏移量,但是会设定contentSize的大小,所以contentSize.height永远都会比contentOffset.y高一个手机屏幕的
     *  高度;上拉加载的效果就是每次滑动到底部时,再往上拉的时候请求更多,那个时候产生的偏移量,就能让contentOffset.y + 手机屏幕尺寸高大于这
     *  个滚动视图的contentSize.height
     */
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
        
        // NSLog(@"%d %s",__LINE__,__FUNCTION__);
        [UIView commitAnimations];
        
        [UIView animateWithDuration:1.0 animations:^{
            //  frame发生的偏移量,距离底部往上提高60(可自行设定)
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
        } completion:^(BOOL finished) {
            
            /**
             *  发起网络请求,请求加载更多数据
             *  然后在数据请求回来的时候,将contentInset改为(0,0,0,0)
             */
            
            NSLog(@"get more data");
            if (self.rate > 1) self.rate --;
            
            [self.tableView reloadData];
        }];
        
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"SearchButton %@", searchBar.text);
    
    [self searchShow:searchBar.text];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _search.text = @"";
    _isSearch = 0;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

@end
