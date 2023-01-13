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
