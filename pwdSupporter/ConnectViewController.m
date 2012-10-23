//
//  ConnectViewController.m
//  pwdSupporter
//
//  Created by ooo on 2012/10/23.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import "ConnectViewController.h"
#import "DetailViewController.h"

@interface ConnectViewController ()
@end

@implementation ConnectViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize detailItem = _detailItem;
@synthesize nameField = _nameField;
@synthesize urlField = _urlField;
@synthesize idField = _idField;
@synthesize passwordField = _passwordField;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;        
    }
}

/*
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //初期化処理
}
*/

- (void)loadView
{
    [super loadView];
	// the base view for this view controller
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor whiteColor];
	// important for view orientation rotation
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view = contentView;
	
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];

	myWebView = [[UIWebView alloc] initWithFrame:webFrame];
	myWebView.backgroundColor = [UIColor whiteColor];
	myWebView.scalesPageToFit = YES;
	myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    //	myWebView.detectsPhoneNumbers = NO;
	myWebView.delegate = self;
	[contentView addSubview: myWebView];
	
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    return;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



@end
