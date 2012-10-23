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

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) ConnectViewController *connectViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *detailItem;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *urlField;
@property (strong, nonatomic) IBOutlet UITextField *idField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;


@end
