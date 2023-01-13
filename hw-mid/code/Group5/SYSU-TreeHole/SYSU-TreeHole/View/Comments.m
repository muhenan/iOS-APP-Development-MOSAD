//
//  Comments.m
//  Hw2Muhenan
//
//  Created by mac on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import "Comments.h"

#import "../Const.h"

@interface Comments()

@property (nonatomic, strong) RequestController *Request;
@property (nonatomic, strong) NSArray<NSString *> *showList;
@property (nonatomic, strong) NSMutableArray<CommentCell *> *cells;

@end

@implementation Comments

-(id)initWithID:(NSString *)ID
{
    self = [super init];

    _cells = [[NSMutableArray alloc] init];
    
    _Request = [RequestController shareInstance];
    [self commentGetList:ID];
    
    [self.view addSubview:self.buttonlogin];
    [self.view addSubview:self.tableView];
    // [self reloadTable];
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:235.0/255.0 blue:232.0/255.0 alpha:1];
    
    _leadBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    //创建一个导航栏集合,在这个集合Item中添加标题
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"大家的评论"];
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
}

- (void)commentGetList:(NSString *)contentID
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentGetListSuccess:) name:@"commentGetListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentGetListFailed:) name:@"commentGetListFailed" object:nil];
    
    [_Request commentGetListById:contentID];
    NSLog(@"request send");
}

- (void)commentGetListSuccess:(NSNotification *)notification
{
    NSLog(@"Comment get success");

    NSArray<CommentRes *> *res = [[NSArray alloc] initWithArray:[DataController commentGetListById:[notification userInfo]]];
    
    for (int i = 0; i < res.count; i ++) {
        NSString *comment = [[NSString alloc] initWithFormat:@"%@: %@", res[i].user.name, res[i].comment.content];
        NSMutableArray<NSString *> *rs = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < res[i].replies.count; j ++) {
            NSString *reply = [[NSString alloc] initWithFormat:@"%@: @%@ %@", res[i].replies[j].user.name, res[i].user.name, res[i].replies[j].reply.content];
            
            // NSLog(@"reply string = %@", reply);
            [rs addObject:reply];
        }
        
        CommentCell *cell = [[[CommentCell alloc] init] loadCellWithComment:comment WithReplies:rs WithWide:self.tableView.frame.size.width];
        
        [self.cells addObject:cell];
    }
    
    [_tableView reloadData];
}

- (void)commentGetListFailed:(NSNotification *)notification
{
    NSLog(@"Comment get fail");
}

-(UIButton *)buttonlogin{
    if (_buttonlogin == nil) {
        _buttonlogin = [[UIButton alloc]initWithFrame:CGRectMake(25, 45, 40,40 )];
        [_buttonlogin setShowsTouchWhenHighlighted:NO];
        
        [_buttonlogin.layer setBorderWidth:1.0];
        [_buttonlogin.layer setBorderColor:[UIColor grayColor].CGColor];
        [_buttonlogin.layer setCornerRadius:20.0];
         
        [_buttonlogin addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * aStr = @"返回";
         NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
         [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(0,2)];
         [_buttonlogin setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _buttonlogin;
}

-(void)btnClick:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"aasd");
}

- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setScrollEnabled:YES];
        // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _tableView;
}

- (void)reloadTable
{
    NSString *comment = @"qin: hhh";
    NSString *reply = @"Xu: @qin 66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666";
    NSMutableArray *rs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i ++) {
        CommentCell *cell = [[[CommentCell alloc] init] loadCellWithComment:comment WithReplies:rs WithWide:_tableView.frame.size.width];
        
        [_cells addObject:cell];
        [rs addObject:[[NSString alloc] initWithString:reply]];
    }
    
    [_tableView reloadData];
}

#pragma mark - 重写----设置有groupTableView有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 返回值是多少既有几个分区
}


#pragma mark - 重写----设置每个分区有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"cell count = %ld", self.cells.count);
    return self.cells.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cells[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.row];
}

// 回复评论
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // 生成评论对象，发送
    NSLog(@"add comment to comment");
    //创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"添加评论" message:@"确定添加评论吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    //创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入评论内容";
    }];
    
    //创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    
    //创建 确认按钮(事件) 并添加到弹窗界面
    // __block UITextField *textTF = [[[UITextField alloc] init] autorelease];
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        // textTF = [addAlertVC.view viewWithTag:100];
        // _label.text = textTF.text;//接收输入框内容
        
        NSString *name = @"User";
        NSString *comment = [[NSString alloc] initWithFormat:@"回复@%@：%@", name, addAlertVC.textFields.firstObject.text];
        
        NSLog(@"%@", comment);
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

@end
