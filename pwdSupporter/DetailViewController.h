//
//  DetailViewController.h
//  pwdSupporter
//
//  Created by 修 大橋 on 12/06/04.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConnectViewController;
#import "Person.h"


@interface DetailViewController : UIViewController<UISplitViewControllerDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate>{
    
@private
    NSArray* sections_;
    NSDictionary* dataSource_;
    
//    CGFloat animatedDistance;
    CGRect originalFrame;
}

@property (strong, nonatomic) ConnectViewController *connectViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *detailItem;

@property (strong, nonatomic) UITextField *textboxTitle;
@property (strong, nonatomic) UITextField *textboxURL;
@property (strong, nonatomic) UITextField *textboxID;
@property (strong, nonatomic) UITextField *textboxPassword;
@property (strong, nonatomic) UITextField *textboxMemo;


@end
