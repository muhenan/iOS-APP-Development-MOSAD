## MOSAD_Final个人报告

本次的期中项目我负责完成的是首页这一块的前端设计。

这是我负责部分整体的结构：

![](./pic/folder.png)

- Home Page
- Uploader
- Downloader
- 遇到的问题和解决方案
- 个人总结和感悟

### Home Page

**部分代码展示：**

```objective-c
//
//  HomeViewController.m
//  HomePage
//
//  Created by nz on 2020/12/19.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "FileCellvh.h"
#import "UploadController.h"
#import "DownloadController.h"
@interface HomeViewController()<GLYPageViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(strong, nonatomic) UIImagePickerController* imagePickerController;
@property(strong, nonatomic) UIImageView* imagePickerControllerView;
@property(nonatomic)GLYPageView* pageView;
@property(nonatomic, strong)NSMutableArray* menuarray;
@property(nonatomic, strong)UIButton* upload;
@property(nonatomic, strong)UIButton* download;
@property(nonatomic)NSMutableArray* filedata;
@property(nonatomic)CGFloat startx;
@property(nonatomic)NSString* code;
@property (nonatomic ,strong) UIScrollView *contentScrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString* url = @"http://222.200.161.218:8080/user/sign_in";
    NSDictionary* body =@{ @"username": @"test", @"password": @"test"};
    [manager POST:url parameters:body headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    UIImage *background = [UIImage imageNamed: @"HomeBack.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: imageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
        [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0],
    ]];
    
    [super viewDidLoad];
    self.imagePickerController=[[UIImagePickerController alloc]init];
    self.imagePickerController.delegate=self;
    self.imagePickerControllerView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 100, 200, 200)];
    self.imagePickerControllerView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imagePickerControllerView];
    
    UIImageView* logo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 110, 48, 48)];
    UIImage* logoimg = [UIImage imageNamed:@"logo.png"];
    logo.image = logoimg;
    
    UIImageView* label = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 428, 100)];
    label.layer.cornerRadius = 20;
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [self.view addSubview:logo];
    self.pageView = [[GLYPageView alloc] initWithFrame:CGRectMake(-80.f, 100, 418, 48.f) titlesArray:@[@"上传",@"接收"]];
    self.pageView.labelRight = 20.f;
    self.pageView.delegate = self;
    self.pageView.scrollViewBackgroundColor = [UIColor whiteColor];
    [self.pageView initalUI];
    [self.view addSubview:self.pageView];
    
    self.upload = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-75, 500, 150, 48)];
    self.upload.backgroundColor = [UIColor whiteColor];
    [self.upload setTitle:@"上传" forState:UIControlStateNormal];
    [self.upload addTarget:self action:@selector(uploadClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.upload setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.upload.layer.cornerRadius = 25;
  //  [self.view addSubview:self.upload];
    
    self.download = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-75+418, 500, 150, 48)];
    self.download.backgroundColor = [UIColor whiteColor];
    [self.download setTitle:@"接收" forState:UIControlStateNormal];
    [self.download addTarget:self action:@selector(downloadClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.download setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.download.layer.cornerRadius = 25;
 //   [self.view addSubview:self.download];
    self.filedata = [NSMutableArray alloc];
    self.contentScrollView = ({
            
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, 418 , 800)];
        scrollView.contentSize = CGSizeMake(418 * 2.f, 800.f);
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        [self.view addSubview:scrollView];
        scrollView;
    });
    [self.contentScrollView addSubview:self.upload];
    [self.contentScrollView addSubview:self.download];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startx = scrollView.contentOffset.x;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging || scrollView.isDecelerating)
    {
        [self.pageView externalScrollView:scrollView totalPage:2 startOffsetX:self.startx];
    }
}
//- (void)pageViewSelectdIndex:(NSInteger)index
//{
//        if(index == 0){
//            self.download.alpha = 0;
//            self.download.frame = CGRectMake(self.view.center.x-75, self.view.center.y+800, 150, 48);
//            [UIView animateWithDuration:1 animations:^{
//                self.upload.frame = CGRectMake(self.view.center.x-75, self.view.center.y+200, 150, 48);
//                self.upload.alpha = 1;
//            }];
//
//        }
//        else{
//            self.upload.alpha = 0;
//            self.upload.frame = CGRectMake(self.view.center.x-75, self.view.center.y+800, 150, 48);
//            [UIView animateWithDuration:1 animations:^{
//                self.download.frame = CGRectMake(self.view.center.x-75, self.view.center.y+200, 150, 48);
//                self.download.alpha = 1;
//            }];
//        }
//}
- (void)pageViewSelectdIndex:(NSInteger)index
{
    [self.contentScrollView setContentOffset:CGPointMake(index * 418, 0) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        [self scrollViewDidEndScrollingAnimation:scrollView];
        
    }
}

- (void)uploadClicked{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择上传的路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];

        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"照片或者视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self selectPhoto];
        }];
    
        UIAlertAction *files = [UIAlertAction actionWithTitle:@"本地文件" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self takeFile];
        }];
        [alertVc addAction:cancle];
        [alertVc addAction:photo];
        
        [alertVc addAction:files];
        [self presentViewController:alertVc animated:YES completion:^{
            nil;
        }];
}


- (void)downloadClicked{
    UIAlertController *alertv = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入接收码" preferredStyle:UIAlertControllerStyleAlert];
    [alertv addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"接收码";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSString* url = [NSString stringWithFormat:@"%@%@", @"http://222.200.161.218:8080/share/", alertv.textFields.firstObject.text];
        [manager HEAD:url parameters:nil headers:nil success:^(NSURLSessionDataTask * _Nonnull task) {
            DownloadController* controller = [DownloadController alloc];
            controller.cells = [[NSMutableArray alloc] init];
            FileCellvh* cell = [[FileCellvh alloc]init];
            controller.uurl = url;
            NSHTTPURLResponse* res = task.response;
            NSString* name = [res.allHeaderFields objectForKey:@"Content-Disposition"];
            NSArray* nameArray = [name componentsSeparatedByString:@"="];
            cell.file_name = nameArray[1];
            cell.file_name = [cell.file_name stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            cell.file_size = [res.allHeaderFields objectForKey:@"Content-Length"];
            NSUInteger len = [cell.file_size intValue];
            unsigned long addition = 0;
            if (len % 1024){
                addition = 1;
            }
            int num = 0;
            while(len > 1024){
                len /= 1024;
                num++;
            }
            if(num == 0){
                cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"B"];
            }
            else if(num == 1){
                cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"KB"];
            }else if( num == 2){
                cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"MB"];
            }else if(num == 3){
                cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"GB"];
            }
            
            cell.file_time = @"2021-1-6";
            cell.height = 50;
            cell.width = 414;
            cell.schedulel = [[UILabel alloc] init];
            cell.schedulel.backgroundColor = [UIColor yellowColor];
            cell.schedulel.alpha = 0.5;
            [cell setFi];
            [cell loadIcon];
            [cell loadName];
            [cell loadSizeAndDate];
            controller.cells = [[NSMutableArray alloc] init];
            [controller.cells addObject:cell];
            [self.navigationController pushViewController:controller animated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
        
    }];
    [alertv addAction:cancel];
    [alertv addAction:confirm];
    [self presentViewController:alertv animated:YES completion:nil];
}

- (void)takePhoto{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated: YES completion: nil];
}
- (void)selectPhoto{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                        UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated: YES completion: nil];
}
- (void)takeFile{
    NSArray *types = @[@"public.content",@"public.text",@"public.source-code",@"public.audiovisual-content",@"com.adobe.pdf",@"com.microsoft.word.doc"];
    types = @[@"public.data"];
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc]
                                                          initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
        documentPicker.delegate = self;
        documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
        documentPicker.view.tintColor = [UIColor blackColor];
        [self presentViewController:documentPicker animated:YES completion:nil];
}
- (NSString *)getFileSize:(NSString *)url{
    NSFileManager *file  = [NSFileManager defaultManager];
    NSDictionary *dict = [file attributesOfItemAtPath:url error:nil];
    unsigned long long size = [dict fileSize];
    return [NSString stringWithFormat:@"%ld",(NSUInteger)size];

}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        FileCellvh* cell = [[FileCellvh alloc] init];
        cell.file_name = [[urls lastObject] lastPathComponent];
        cell.file_data = [[NSData alloc] initWithContentsOfURL:[urls lastObject]];
        cell.file_time = @"2020-12-26";
        cell.height = 50;
        cell.width = 414;
        cell.schedulel = [[UILabel alloc] init];
        cell.schedulel.backgroundColor = [UIColor yellowColor];
        cell.schedulel.alpha = 0.5;
        unsigned long addition = 0;
        if (cell.file_data.length % 1024){
            addition = 1;
        }
        NSUInteger len = cell.file_data.length;
        int num = 0;
        while(len > 1024){
            len /= 1024;
            num++;
        }
        if(num == 0){
            cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"B"];
        }
        else if(num == 1){
            cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"KB"];
        }else if( num == 2){
            cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"MB"];
        }else if(num == 3){
            cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"GB"];
        }
        [cell setFi];
        [cell loadName];
        [cell loadIcon];
        [cell loadSizeAndDate];
        UploadController* controller = [UploadController alloc];
        
        controller.cells = [[NSMutableArray alloc] init];
        [controller.cells addObject:cell];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerImageURL];
    NSData *imageData = UIImageJPEGRepresentation(image,1.0f);
    FileCellvh *cell = [[FileCellvh alloc] init];
    cell.file_name = [imageURL lastPathComponent];
    cell.file_data = imageData;
    cell.file_time = @"2020-12-26";
    cell.height = 50;
    cell.width = 414;
    cell.schedulel = [[UILabel alloc] init];
    cell.schedulel.backgroundColor = [UIColor yellowColor];
    cell.schedulel.alpha = 0.5;
    unsigned long addition = 0;
    if (cell.file_data.length % 1024){
        addition = 1;
    }
    NSUInteger len = cell.file_data.length;
    int num = 0;
    while(len > 1024){
        len /= 1024;
        num++;
    }
    if(num == 0){
        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"B"];
    }
    else if(num == 1){
        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"KB"];
    }else if( num == 2){
        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"MB"];
    }else if(num == 3){
        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"GB"];
    }
    [cell loadName];
    [cell setFi];
    [cell loadIcon];
    [cell loadSizeAndDate];
    UploadController* controller = [UploadController alloc];
    controller.cells = [[NSMutableArray alloc] init];
    [controller.cells addObject:cell];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) addData: (NSData*) data {

    [self.filedata addObject:data];
    [self viewWillAppear: YES];

}
@end
```

**功能截图：**

![](./pic/HomePage.png)

![](./pic/HomePage1.png)

首页是用了一个 UIScrollView ，然后添加了一个可以移动的下划线。然后在 content view 里面添加了两个button 。

这次的首页参考了奶牛快传的首页，但是我们没有在壁纸中添加广告，可喜可贺。

### Uploader

**部分代码展示：**

```objective-c
//
//  UploadController.m
//  HomePage
//
//  Created by nz on 2020/12/25.
//

#import <Foundation/Foundation.h>
#import "UploadController.h"

@interface UploadController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic)int num;
@property(nonatomic)UITextField* fullPathField;
@property(nonatomic)UITextView* enterPath;
@property(nonatomic)NSData* file;
@property(nonatomic)NSData* fullpath;
@end

@implementation UploadController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.num = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.fileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 500) style:UITableViewStyleGrouped];
    [self.fileTable setDelegate:self];
    [self.fileTable setDataSource:self];
    self.fileTable.alwaysBounceVertical = YES;
    self.fileTable.userInteractionEnabled = true;
//    [self.fileTable setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.fileTable];
    self.filelistname = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 32)];
    self.filelistname.text = @"文件";
    [self.filelistname setFont:[UIFont systemFontOfSize:18] ];
    [self.view addSubview:self.filelistname];
    self.addFile = [[UIButton alloc] initWithFrame:CGRectMake(380, 5, 24, 24)];
    [self.addFile setBackgroundImage:[UIImage imageNamed:@"Add.png"] forState:UIControlStateNormal];
    [self.addFile addTarget:self action:@selector(addClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addFile];
    self.uploadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-200, 580, 400, 50)];
    self.uploadButton.backgroundColor = [UIColor grayColor];
    [self.uploadButton setTitle:@"上传" forState:UIControlStateNormal];
    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.uploadButton.layer.cornerRadius = 25;
    [self.uploadButton addTarget:self action:@selector(uploadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadButton];
    self.fullPathField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x-200, 540, 400, 30) ];
    self.fullPathField.placeholder = @"/";
    self.fullPathField.font = [UIFont systemFontOfSize:18];
    self.fullPathField.spellCheckingType = UITextSpellCheckingTypeNo;
    self.fullPathField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.fullPathField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.fullPathField.layer.borderColor = [UIColor blackColor].CGColor;
    self.fullPathField.layer.borderWidth = 1;
    self.fullPathField.layer.cornerRadius = 5;
    
    [self.view addSubview:self.fullPathField];
    self.enterPath = [[UITextView alloc] initWithFrame:CGRectMake(0, 500, 400, 40)];
    self.enterPath.text = @"请输入想要保存的路径";
    self.enterPath.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.enterPath];
}
- (void)addClicked{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择上传的路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];

        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"照片或者视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self selectPhoto];
        }];
        UIAlertAction *files = [UIAlertAction actionWithTitle:@"本地文件" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self takeFile];
        }];
        [alertVc addAction:cancle];
        [alertVc addAction:photo];
        [alertVc addAction:files];
        [self presentViewController:alertVc animated:YES completion:^{
            nil;
        }];
}
- (void)takePhoto{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated: YES completion: nil];
}
- (void)selectPhoto{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                        UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController: imagePickerController animated: YES completion: nil];
}
- (void)takeFile{
    NSArray *types = @[@"public.content",@"public.text",@"public.source-code",@"public.audiovisual-content",@"com.adobe.pdf",@"com.microsoft.word.doc"];
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc]
                                                          initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
        documentPicker.delegate = self;
        documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:documentPicker animated:YES completion:nil];
}
- (NSString *)getFileSize:(NSString *)url{
    NSFileManager *file  = [NSFileManager defaultManager];
    NSDictionary *dict = [file attributesOfItemAtPath:url error:nil];
    unsigned long long size = [dict fileSize];
    return [NSString stringWithFormat:@"%ld",(NSUInteger)size];

}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        FileCellvh* cell = [[FileCellvh alloc] init];
        cell.file_name = [[urls lastObject] lastPathComponent];
        cell.file_data = [[NSData alloc] initWithContentsOfURL:[urls lastObject]];
        cell.file_time = @"2020-12-26";
        cell.height = 50;
        cell.width = 414;
        cell.schedulel = [[UILabel alloc] init];
        cell.schedulel.backgroundColor = [UIColor yellowColor];
        cell.schedulel.alpha = 0.5;
        NSUInteger len = cell.file_data.length;
                    unsigned long addition = 0;
                    if (len % 1024){
                        addition = 1;
                    }
                    int num = 0;
                    while(len > 1024){
                        len /= 1024;
                        num++;
                    }
                    if(num == 0){
                        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"B"];
                    }
                    else if(num == 1){
                        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"KB"];
                    }else if( num == 2){
                        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"MB"];
                    }else if(num == 3){
                        cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"GB"];
                    }
        [cell loadName];
        [cell loadIcon];
        [cell setFi];
        [cell loadSizeAndDate];
        [self.cells addObject:cell];
        [self viewDidLoad];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerImageURL];
    NSData *imageData = UIImageJPEGRepresentation(image,1.0f);
    FileCellvh *cell = [[FileCellvh alloc] init];
    cell.file_name = [imageURL lastPathComponent];
    cell.file_data = imageData;
    cell.file_time = @"2020-12-26";
    cell.height = 50;
    cell.width = 414;
    cell.schedulel = [[UILabel alloc] init];
    cell.schedulel.backgroundColor = [UIColor yellowColor];
    cell.schedulel.alpha = 0.5;
    NSUInteger len = cell.file_data.length;
                unsigned long addition = 0;
                if (len % 1024){
                    addition = 1;
                }
                int num = 0;
                while(len > 1024){
                    len /= 1024;
                    num++;
                }
                if(num == 0){
                    cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"B"];
                }
                else if(num == 1){
                    cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"KB"];
                }else if( num == 2){
                    cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"MB"];
                }else if(num == 3){
                    cell.file_size = [NSString stringWithFormat:@"%lu %@" ,len + addition, @"GB"];
                }
    [cell loadName];
    [cell loadIcon];
    [cell setFi];
    [cell loadSizeAndDate];
    [self.cells addObject:cell];
    [self viewDidLoad];
}


-(void)uploadButtonClicked{
    NSLog(@"network upload");
    AFHTTPSessionManager* manager =[AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    NSString* url = @"http://222.200.161.218:8080/files/";
    for(int i = 0; i < self.cells.count; ++i){
        self.file = self.cells[i].file_data;
        self.fullpath = [[NSString stringWithFormat:@"%@%@", self.fullPathField.text, self.cells[i].file_name] dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",self.fullpath);
    [manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:self.file name:@"file" fileName:self.cells[i].file_name mimeType:@"multipart/form-data"];
            [formData appendPartWithFormData:self.fullpath name:@"fullPath"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        if(uploadProgress.fractionCompleted == 1.0f){
            dispatch_async(dispatch_get_main_queue(), ^{
                float num = uploadProgress.fractionCompleted;
                [self.cells[i] setScheduleNow:num];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                float num = uploadProgress.fractionCompleted;
                [self.cells[i] setScheduleNow:num];
                        });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
        
    }
}
- (void) addData: (NSData*) data {

    [self viewWillAppear: YES];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.cells.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cells[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cells[indexPath.row];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cells removeObjectAtIndex:indexPath.row];
        [self.fileTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
```

**功能截图：**

![](./pic/selected1.png)

![](./pic/uploadList.png)

![](./pic/uploadFinished.png)

### Downloader

**部分代码展示：**

```objective-c
//
//  UploadController.m
//  HomePage
//
//  Created by nz on 2020/12/25.
//

#import <Foundation/Foundation.h>
#import "DownloadController.h"

@interface DownloadController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic)int num;
@property(nonatomic) UIButton* editButton;
@property(nonatomic) UIButton* allButton;
@property(nonatomic) NSMutableArray<FileCellvh*>* downloadList;
@end

@implementation DownloadController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.downloadList = [[NSMutableArray alloc] init];
    self.fileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 500) style:UITableViewStyleGrouped];
    [self.fileTable setDelegate:self];
    [self.fileTable setDataSource:self];
    self.fileTable.alwaysBounceVertical = YES;
    self.fileTable.userInteractionEnabled = true;
//    [self.fileTable setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.fileTable];
    self.filelistname = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 32)];
    self.filelistname.text = @"文件";
    [self.filelistname setFont:[UIFont systemFontOfSize:18] ];
    [self.view addSubview:self.filelistname];
    self.downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-200, 520, 400, 50)];
    self.downloadButton.backgroundColor = [UIColor grayColor];
    [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    [self.downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.downloadButton.layer.cornerRadius = 25;
    [self.downloadButton addTarget:self action:@selector(downloadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadButton];
    
    self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(360, 5, 40, 24)];
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editButton];
    self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 5, 40, 24)];
    [self.allButton setTitle:@"全选" forState:UIControlStateNormal];
    [self.allButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.allButton addTarget:self action:@selector(allClicked) forControlEvents:UIControlEventTouchUpInside];
    self.allButton.alpha = 0;
    [self.view addSubview:self.allButton];
}
-(void)downloadButtonClicked{
    
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.uurl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if(downloadProgress.fractionCompleted == 1.0f){
            dispatch_async(dispatch_get_main_queue(), ^{
                float num = downloadProgress.fractionCompleted;
                [self.cells[0] setScheduleNow:num];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                float num = downloadProgress.fractionCompleted;
                [self.cells[0] setScheduleNow:num];
                        });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *createPath = [NSString stringWithFormat:@"%@/Download", documentDirectory];
        if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        NSString* sandBoxFilePath = [NSString alloc];
        NSData* fileData = [NSData alloc];
        for(int i = 0; i<self.cells.count; ++i){
            sandBoxFilePath = [createPath stringByAppendingPathComponent:self.cells[i].file_name];
            fileData = responseObject;
            [fileData writeToFile:sandBoxFilePath atomically:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.cells.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cells[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    [cell.contentView addSubview:self.cells[indexPath.row]];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cells removeObjectAtIndex:indexPath.row];
        [self.fileTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)allClicked{
    if([self.allButton.titleLabel.text isEqualToString:@"全选"] ){
        for (int i = 0; i< self.cells.count; i++) {
          NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
          [self.fileTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
         }
        [self.allButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    else{
        for (int i = 0; i< self.cells.count; i++) {
          NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
          [self.fileTable deselectRowAtIndexPath:indexPath animated:NO];
         }
        [self.allButton setTitle:@"全选" forState:UIControlStateNormal];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.downloadList addObject:self.cells[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.downloadList removeObject:self.cells[indexPath.row]];
}
- (void)editClicked{
    self.fileTable.allowsMultipleSelectionDuringEditing = YES;
//    [self.fileTable setEditing:YES animated:YES];
    self.fileTable.editing = !self.fileTable.editing;
    if(self.fileTable.editing == YES){
        [self.editButton setTitle:@"退出" forState:UIControlStateNormal];
        self.allButton.alpha = 1;
    }else{
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        self.allButton.alpha = 0;
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
@end
```

**功能截图：**

![](./pic/download.png)

![](./pic/downloadPage.png)

![](./pic/downloading.png)

![](./pic/downloadFinished.png)

![](./pic/Allpick.png)

### 遇到的问题

- **UIScrollView** : 由于在首页想要做到左右手势可以列表滑动以及按钮的动画，所以使用了 UIScrollView 这个组件，但是由于不熟悉所以运用起来比较吃力，最后还是靠着博客的教程慢慢学会。
- **NSProgress在子线程和主线程中的调用** :  这次考虑到进度条单独做比较困难，所以我们考虑将进度条做在上传和下载的页面上，然后在 AFNetworking 这个库中提供了一个 NSProgress 类让我可以直接调用然后查看进度。一开始我是直接调整进度条的 frame ，但是 Xcode 报错说不能在子线程中更改 frame ，这一度让我很难解决。后来我发现可以在子线程中调用主线程，然后在更改 frame ，这样就可以成功更改 frame。



### 个人总结和感悟

这次的期末项目，让我巩固了自己OC的基础知识，学习了与他人共同编程的方法的策略，收获了在团队编程上面要注意的一些事项以及代码编写的规范性。即便延期了2周，但我还是勉强完成了属于我这一块内容的编写，这也反映着我能力的不足。我会继续努力提高自己的代码水平，争取以后能够更快地完成任务。