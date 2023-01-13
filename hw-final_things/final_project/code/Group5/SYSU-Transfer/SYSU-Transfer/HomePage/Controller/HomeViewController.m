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
