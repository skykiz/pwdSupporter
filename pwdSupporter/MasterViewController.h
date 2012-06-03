//
//  MasterViewController.h
//  pwdSupporter
//
//  Created by 修 大橋 on 12/06/04.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
