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
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cache stringByAppendingString:[NSString stringWithFormat:@"/%ld", ID]];
    
    NSLog(@"write path = %@", filePath);
    
    [data writeToFile:filePath atomically:YES];
}

+(NSData *) ReadFileByID:(NSInteger)ID
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cache stringByAppendingString:[NSString stringWithFormat:@"/%ld", ID]];
    
    return [NSData dataWithContentsOfFile:filePath];;
}

+(void) DeleteFileByID:(NSInteger)ID
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cache stringByAppendingString:[NSString stringWithFormat:@"/%ld", ID]];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm removeItemAtPath:filePath error:nil];
}

+(void) WriteFile:(NSData *)data ByName:(NSString *)name
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cache stringByAppendingString:[NSString stringWithFormat:@"/%@", name]];
    
    NSLog(@"write path = %@", filePath);
    
    [data writeToFile:filePath atomically:YES];
}

+(NSData *) ReadFileByName:(NSString *)name
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cache stringByAppendingString:[NSString stringWithFormat:@"/%@", name]];
    
    return [NSData dataWithContentsOfFile:filePath];;
}

@end
