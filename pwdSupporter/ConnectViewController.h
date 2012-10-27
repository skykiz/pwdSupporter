//
//  ConnectViewController.h
//  pwdSupporter
//
//  Created by ooo on 2012/10/23.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "Person.h"

@interface ConnectViewController : UIViewController <UIWebViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate>
{
	UIWebView *myWebView;
//	UIWebDocumentView *myWebView;
	UIToolbar *toolbar;
    BOOL _observing;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *detailItem;

@property (strong, nonatomic) NSString *nameField;
@property (strong, nonatomic) NSString *urlField;
@property (strong, nonatomic) NSString *idField;
@property (strong, nonatomic) NSString *passwordField;

@end
