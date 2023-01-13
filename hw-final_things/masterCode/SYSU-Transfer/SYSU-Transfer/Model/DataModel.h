//
//  DataModel.h
//  SYSU-Transfer
//
//  Created by itlab on 2021/1/6.
//  Copyright © 2021 itlab. All rights reserved.
//

#ifndef DataModel_h
#define DataModel_h

#import <Foundation/Foundation.h>

@interface File : NSObject
@property NSInteger ID;
@property NSString *name;
@property NSString *type;
@property NSString *fullPath;
@property NSArray<File *> *children; // maybe enum
@property File* parent;
@property NSData* data;

+(File *) dic2Object:(NSDictionary *)dic;

@end

#endif /* DataModel_h */
