//
//  DataController.h
//  SYSU-TreeHole
//
//  Created by itlab on 2020/11/16.
//  Copyright © 2020 itlab. All rights reserved.
//

#ifndef DataController_h
#define DataController_h
#import "DataModel.h"

@interface DataController : NSObject

@property (atomic, strong) NSMutableArray<NSJSONSerialization *> *Users;
@property (atomic, strong) NSMutableArray<NSJSONSerialization *> *Contents;

@end

#endif /* DataController_h */
