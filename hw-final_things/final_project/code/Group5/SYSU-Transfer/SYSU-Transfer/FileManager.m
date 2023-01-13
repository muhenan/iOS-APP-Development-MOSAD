//
//  FileManager.m
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManager.h"

@interface FileManager()

@end

@implementation FileManager

+(void) WriteFile:(NSData *)data ByID:(NSInteger)ID
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%ld", ID]];
    
    NSLog(@"write path = %@", filePath);
    
    [data writeToFile:filePath atomically:YES];
}

+(NSData *) ReadFileByID:(NSInteger)ID
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%ld", ID]];
    
    return [NSData dataWithContentsOfFile:filePath];;
}

+(void) DeleteFileByID:(NSInteger)ID
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%ld", ID]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:filePath error:nil];
}

+(void) WriteFile:(NSData *)data ByName:(NSString *)name
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%@", name]];
    
    NSLog(@"write path = %@", filePath);
    
    [data writeToFile:filePath atomically:YES];
}

+(void) DeleteFileByName:(NSString *)name
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%@", name]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:filePath error:nil];
}


+(NSData *) ReadFileByName:(NSString *)name
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%@", name]];
    
    return [NSData dataWithContentsOfFile:filePath];;
}

+(NSArray *)ReadDirByPath:(NSString *)path
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%@", path]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    return [fm contentsOfDirectoryAtPath:filePath error:nil];
    // return [fm subpathsOfDirectoryAtPath:filePath error:nil];
}

+(void) CreateDirByPath:(NSString *)path
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%@", path]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}

+(BOOL) fileIsFolder:(NSString *)path
{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingString:[NSString stringWithFormat:@"/%@", path]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL isFolder;
    [fm fileExistsAtPath:filePath isDirectory:&isFolder];
    
    return isFolder;
}

@end
