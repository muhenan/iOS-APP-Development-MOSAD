//
//  CheckRecord.m
//  Hw2Muhenan
//
//  Created by mac on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import "CheckRecord.h"

@interface CheckRecord() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *shell;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *likeNumLabel;
@property (nonatomic, strong) UILabel *commentNumLabel;
@property (nonatomic, strong) UIButton *likeBtn;

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) NSMutableArray<UIButton *> *imgBtns;

// location
@property CGFloat headSize;
@property CGFloat top;
@property CGFloat mid;
@property CGFloat end;
@property CGFloat wide;
@property CGFloat high;

// data
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ctitle;
@property (nonatomic, strong) NSString *detail;
@property NSInteger like;
@property NSInteger comment;
@property (nonatomic, strong) UIImage *head;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imgs;
@property (nonatomic, strong) NSMutableArray<NSString *> *thumbs;

// comment table
@property (nonatomic, strong) RequestController *Request;
@property (nonatomic, strong) NSMutableArray<CommentCell *> *cells;
@property (nonatomic, strong) NSArray<CommentRes *> *Comments;

@end

@implementation CheckRecord
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _Request = [RequestController shareInstance];
    
    
    self.imgs = [[NSMutableArray alloc] init];
    self.imgBtns = [[NSMutableArray alloc] init];
    self.cells = [[NSMutableArray alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;

    // init
    _wide = self.view.frame.size.width;
    _headSize = _wide/10;
    _top = 100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentAddSuccess:) name:@"commentAddSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentAddFailed:) name:@"commentAddFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentGetListSuccess:) name:@"commentGetListSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentGetListFailed:) name:@"commentGetListFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeAddSuccess:) name:@"likeAddSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeAddFailed:) name:@"likeAddFailed" object:nil];
}

- (instancetype)loadWithContent:(Content *)content
                   withUserInfo:(Info *)info
                       withWide:(CGFloat)wide
{
    self.imgs = [[NSMutableArray alloc] init];
    self.thumbs = [[NSMutableArray alloc] init];
    self.imgBtns = [[NSMutableArray alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    _content = content;
    _info = info;
    [self dataGenerate];
    
    // init
    _wide = wide;
    _headSize = _wide/10;
    _top = 100;
    
    // laod element
    [self loadHeadImg];
    [self loadName];
    [self loadTitle];
    [self loadDetail];
    [self loadImgs];
    [self loadLike];
    [self loadComment];
    [self loadTableView];
    // [self reloadTable];
    
    [self commentGetList:_content.ID];
    
    _cell_height = _end-_top + _likeNumLabel.frame.size.height + 5;
    
    NSLog(@"load init");
    
    return self;
}

- (void) dataGenerate
{
    _name = _info.name;
    _ctitle = _content.name;
    _head = [UIImage imageNamed:@"timg.jpeg"];
    _detail = _content.detail;
    _like = _content.likeNum;
    _comment = _content.commentNum;
    
    if ([_content.type isEqualToString:@"Album"])
    {
        NSArray* arr = _content.album.Images;
        
        for (int i = 0; i < arr.count; i ++) {
            Image *a = arr[i];
            NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"http://172.18.178.56/api/thumb/%@", a.thumb]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            
            [_imgs addObject:img];
            [_thumbs addObject:a.thumb];
        }
    } else {
        // [_imgs addObject:[UIImage imageNamed:@"timg.jpeg"]];
    }
}

- (void)addChange
{
    // add save button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
}

- (void)change
{
    //创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"编辑内容" message:@"删除内容请直接点击确定" preferredStyle:UIAlertControllerStyleAlert];
    
    //创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新的标题";
    }];
    
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新的内容";
    }];
    
    //创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    
    //创建 确认按钮(事件) 并添加到弹窗界面
    // __block UITextField *textTF = [[[UITextField alloc] init] autorelease];
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        NSString *title = [[NSString alloc] initWithFormat:@"%@", addAlertVC.textFields.firstObject.text];
        NSString *detail = [[NSString alloc] initWithFormat:@"%@", addAlertVC.textFields.firstObject.text];
        
        if ([detail isEqualToString:@""] && [title isEqualToString:@""]) {
            NSLog(@"delete");
            [self.Request contentDeleteById:self.content.ID];
        } else {
            NSArray *arr = [[NSArray alloc] init];
            [self.Request contentUpdateById:self.content.ID title:title detail:detail tags:arr isPublic:YES];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

- (void)dataInit
{
    int n = 9;
    for (int i = 0; i < n; i ++) {
        UIImage *img = [UIImage imageNamed:@"timg.jpeg"];
        [self.imgs addObject:img];
    }
    
}

- (void)loadHeadImg
{
    if (_headImg == nil) {
        UIImage *img = [UIImage imageNamed:@"timg.jpeg"];
        _headImg = [[UIImageView alloc] initWithImage:img];
        _headImg.frame = CGRectMake(10, _top, _headSize, _headSize);
        // _headImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:_headImg];
    }
}

- (void)loadName
{
    if (_nameLabel == nil) {
        CGFloat size = _headSize * 0.5;
        CGFloat x = _headSize + 20;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _top-2, _wide - _headSize - 30, size+5)];
        
        _nameLabel.text = _name;
        NSLog(@"name size = %lf", size);
        _nameLabel.font = [UIFont boldSystemFontOfSize:size];
        
        [self.view addSubview:_nameLabel];
    }
}

- (void)loadTitle
{
    if (_titleLabel == nil) {
        CGFloat size = _headSize * 0.4;
        CGFloat x = _headSize + 20;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _top+0.6*_headSize-2, _wide - _headSize - 30, size+5)];
        
        _titleLabel.text = _ctitle;
        NSLog(@"size = %lf", size);
        _titleLabel.font = [UIFont fontWithName:@"Arial" size:size];
        
        [self.view addSubview:_titleLabel];
    }
}

- (void)loadDetail
{
    if (_detailLabel == nil) {
        CGFloat x = 10;
        CGFloat y = _top + _headSize + 5;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, _wide-20, 70)];
        _detailLabel.numberOfLines = 3;
        _detailLabel.font = [UIFont fontWithName:@"Arial" size:18];
        
        _detailLabel.text = _detail;
        [self.view addSubview:_detailLabel];
        
        _mid = y + _detailLabel.frame.size.height;
    }
}

- (void)loadImgs
{
    NSInteger n = _imgs.count;
    CGFloat size = _wide/4;
    CGFloat barrer = 10;
    
    if (n == 0) {
        _end = _mid;
    } else if (n == 1) {
        NSLog(@"n == 1");
        
        size = 3*size + 2*barrer;
        UIButton *img1 = [[UIButton alloc] initWithFrame:CGRectMake(barrer, _mid+barrer, size, size)];
        img1.tag = 100;
        
        [img1 setBackgroundImage:_imgs[0] forState:UIControlStateNormal];
        [self.imgBtns addObject:img1];
        
        _end = _mid + 2*barrer + size;
    } else if (n == 2) {
        size = (3*size + barrer)/2;
        
        for (int i = 0; i < n; i ++) {
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + i*(size+barrer), _mid+barrer, size, size)];
            img.tag = 100 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        _end = _mid + 2*barrer + size;
    } else if (n == 3) {
        for (int i = 0; i < n; i ++) {
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + i*(size+barrer), _mid+barrer, size, size)];
            img.tag = 100 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        _end = _mid + 2*barrer + size;
    } else if (n == 4) {
        size = (3*size + barrer)/2;
        
        for (int i = 0; i < n; i ++) {
            int x = i%2;
            int y = i/2;
            
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + x*(size+barrer), _mid + barrer + y * (size+barrer), size, size)];
            img.tag = 100 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        _end = _mid + 3*barrer + 2*size;
    } else if (n >= 5 && n <= 9) {
        for (int i = 0; i < n; i ++) {
            int x = i%3;
            int y = i/3;
            
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + x*(size+barrer), _mid + barrer + y * (size+barrer), size, size)];
            img.tag = 100 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        NSInteger a = n/3;
        _end = _mid + barrer + a * (size + barrer);
    } else if (n >= 9) {
        for (int i = 0; i < 9; i ++) {
            int x = i%3;
            int y = i/3;
            
            UIButton* img = [[UIButton alloc] initWithFrame:CGRectMake(barrer + x*(size+barrer), _mid + barrer + y * (size+barrer), size, size)];
            img.tag = 100 + i;
            
            [img setBackgroundImage:_imgs[i] forState:UIControlStateNormal];
            [self.imgBtns addObject:img];
        }
        
        NSInteger a = n/3;
        _end = _mid + barrer + a * (size + barrer);
    }
    
    for (int i = 0; i < _imgBtns.count; i ++) {
        [self.view addSubview:_imgBtns[i]];
        [_imgBtns[i] addTarget:self action:@selector(imgSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)imgSelect:(UIButton *)img
{
    NSLog(@"img tag = %ld", [img tag]);
    NSInteger a = [img tag] - 100;
    ImgDisplay *ids = [[ImgDisplay alloc] initWithPic:_imgs[a] withThumb:_thumbs[a]];
    
    [self.navigationController pushViewController:ids animated:YES];
}

- (void)loadLike
{
    if (_likeNumLabel == nil) {
        _likeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _end+2, 40, 30)];
        _likeNumLabel.text = [[NSString alloc] initWithFormat:@"%ld", _like];
        _likeNumLabel.font = [UIFont fontWithName:@"Arial" size:18];
        _likeNumLabel.textColor = UIColor.grayColor;
        
        UIButton* like = [[UIButton alloc] initWithFrame:CGRectMake(_likeNumLabel.frame.origin.x-30, _likeNumLabel.frame.origin.y-2, 25, 25)];
        [like setBackgroundImage:[UIImage imageNamed:@"good_g.png"] forState:UIControlStateNormal];
        
        [like addTarget:self action:@selector(selectLike) forControlEvents:UIControlEventTouchDown];
        _likeBtn = like;
        
        [self.view addSubview:_likeNumLabel];
        [self.view addSubview:_likeBtn];
    }
}

- (void)selectLike
{
    NSLog(@"Like");
    [_likeBtn setBackgroundImage:[UIImage imageNamed:@"good_r.png"] forState:UIControlStateNormal];
    _likeNumLabel.text = [[NSString alloc] initWithFormat:@"%ld", _like+1];
    
    [_Request likeAddToContent:self.content.ID];
    // send a message. if success, change.
}

- (void)loadComment
{
    if (_commentNumLabel == nil) {
        _commentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40+_wide/4, _end+2, 100, 25)];
        _commentNumLabel.text = [[NSString alloc] initWithFormat:@"%ld", _comment];
        _commentNumLabel.font = [UIFont fontWithName:@"Arial" size:18];
        _commentNumLabel.textColor = UIColor.grayColor;
        [_commentNumLabel sizeToFit];
        
        UIButton* comment = [[UIButton alloc] initWithFrame:CGRectMake(_commentNumLabel.frame.origin.x-30, _commentNumLabel.frame.origin.y-2, 25, 25)];
        [comment setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        
        [comment addTarget:self action:@selector(selectComment) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview:_commentNumLabel];
        [self.view addSubview:comment];
    }
}

- (void)selectComment
{
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
        
        NSString *comment = [[NSString alloc] initWithFormat:@"%@", addAlertVC.textFields.firstObject.text];
        
        [self addCommentToContent:comment];
        
        NSLog(@"%@", comment);
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

- (void)loadTableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _end+30, self.view.frame.size.width, self.view.frame.size.height-130-_end) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setScrollEnabled:YES];
        
        [self.view addSubview:_tableView];
    }
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
    // 创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"回复评论" message:@"确定回复评论吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入回复内容";
    }];
    
    // 创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    // 添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];
    
    
    // 创建 确认按钮(事件) 并添加到弹窗界面
    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        NSString *reply = [[NSString alloc] initWithFormat:@"%@", addAlertVC.textFields.firstObject.text];
        
        
        [self.Request commentAddWithContentId:self.Comments[indexPath.row].comment.ID fatherId:self.content.ID content:reply isReply:YES];
        
    }];
    //添加确定按钮(事件)到弹窗
    [addAlertVC addAction:confirmAction];
    
    
    //模态显示一个弹框  注意: UIAlterController只能通过模态形式进行弹出,不能使用push
    [self presentViewController:addAlertVC animated:NO completion:nil];
}

# pragma mark - Notification Observer
- (void)commentGetList:(NSString *)contentID
{
    
    [_Request commentGetListById:contentID];
    NSLog(@"request send");
}

- (void)commentGetListSuccess:(NSNotification *)notification
{
    NSLog(@"Comment get success");
    
    self.Comments = [[NSArray alloc] initWithArray:[DataController commentGetListById:[notification userInfo]]];
    [self.cells removeAllObjects];
    
    for (int i = 0; i < self.Comments.count; i ++) {
        NSString *comment = [[NSString alloc] initWithFormat:@"%@: %@", self.Comments[i].user.name, self.Comments[i].comment.content];
        NSMutableArray<NSString *> *rs = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < self.Comments[i].replies.count; j ++) {
            NSString *reply = [[NSString alloc] initWithFormat:@"%@: @%@ %@", self.Comments[i].replies[j].user.name, self.Comments[i].user.name, self.Comments[i].replies[j].reply.content];
            
            // NSLog(@"reply string = %@", reply);
            [rs addObject:reply];
        }
        
        CommentCell *cell = [[[CommentCell alloc] init] loadCellWithComment:comment WithReplies:rs WithWide:self.tableView.frame.size.width];
        
        [self.cells addObject:cell];
    }
    
    _comment = self.Comments.count;
    _commentNumLabel.text = [[NSString alloc] initWithFormat:@"%ld", _comment];
    [_tableView reloadData];
}

- (void)commentGetListFailed:(NSNotification *)notification
{
    NSLog(@"Comment get fail");
}

# pragma mark - Notification CommentAdd
- (void)addCommentToContent:(NSString *)comment
{
    [_Request commentAddWithContentId:self.content.ID fatherId:self.content.ID content:comment isReply:NO];
}

- (void)commentAddSuccess:(NSNotification *)notification
{
    NSLog(@"Comment add success");
    
    [self commentGetList:self.content.ID];
}

- (void)commentAddFailed:(NSNotification *)notification
{
    NSLog(@"Comment add fail");
}

# pragma mark - Notification LikeAdd

- (void)likeAddSuccess:(NSNotification *)notification
{
    NSLog(@"like add success");
    
    [self commentGetList:self.content.ID];
}

- (void)likeAddFailed:(NSNotification *)notification
{
    NSLog(@"like add fail");
}

@end
