//
//  Address.h
//  pwdSupporter
//
//  Created by 修 大橋 on 12/06/13.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Address : NSManagedObject

@property (strong, nonatomic) NSString *loginURL;
@property (strong, nonatomic) NSString *loginID;
@property (strong, nonatomic) NSString *loginPWD;
@property (strong, nonatomic) NSString *loginMemo;

@end
