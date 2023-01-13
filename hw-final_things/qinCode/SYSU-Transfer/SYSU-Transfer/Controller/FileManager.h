//
//  FileManager.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef FileManager_h
#define FileManager_h

@interface FileManager : NSObject

+(void) WriteFile:(NSData *)data ByID:(NSInteger)ID;

+(NSData *) ReadFileByID:(NSInteger)ID;

+(void) DeleteFileByID:(NSInteger)ID;

+(void) WriteFile:(NSData *)data ByName:(NSString *)name;

+(NSData *) ReadFileByName:(NSString *)name;

@end

#endif /* FileManager_h */
