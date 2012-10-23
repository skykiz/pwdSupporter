//
//  Person.h
//  pwdSupporter
//
//  Created by 修 大橋 on 12/06/13.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Address.h"

@interface Person : NSManagedObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Address *address;


@end
