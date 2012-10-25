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
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation ConnectViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize detailItem = _detailItem;
@synthesize nameField = _nameField;
@synthesize urlField = _urlField;
@synthesize idField = _idField;
@synthesize passwordField = _passwordField;

@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;        
    }
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
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
	
	CGRect webFrame = [[UIScreen mainScreen] bounds];

	myWebView = [[UIWebView alloc] initWithFrame:webFrame];
	myWebView.backgroundColor = [UIColor whiteColor];
	myWebView.scalesPageToFit = YES;
	myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    //	myWebView.detectsPhoneNumbers = NO;
	myWebView.delegate = self;
	[contentView addSubview: myWebView];
	
	// create the UIToolbar at the bottom of the view controller
	//
	toolbar = [UIToolbar new];
	toolbar.barStyle = UIBarStyleDefault;
	
	// size up the toolbar and set its frame
	[toolbar sizeToFit];
	CGFloat toolbarHeight = [toolbar frame].size.height;
	CGRect mainViewBounds = self.view.bounds;
	[toolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
								 CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - (toolbarHeight * 2.0) + 2.0,
								 CGRectGetWidth(mainViewBounds),
								 toolbarHeight)];
	
	[self.view addSubview:toolbar];
    [self createToolbarItems];
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
    self.navigationItem.title = _detailItem.name;
    //    NSURL *url = [NSURL URLWithString:@"http://www.yahoo.co.jp"];
    NSURL *url = [NSURL URLWithString:_detailItem.address.loginURL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:req];
    
    [self copyToID];
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

- (void)createToolbarItems
{
    UIBarButtonItem *idBtn =
    [[UIBarButtonItem alloc]
     initWithTitle:@"     ID     "
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(copyToID)
     ];

    UIBarButtonItem *pwdBtn =
    [[UIBarButtonItem alloc]
     initWithTitle:@"Password"
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(copyToPassword)
     ];

	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
    
	NSArray *items = [NSArray arrayWithObjects: /*systemItem, addItem, */flexItem, idBtn, pwdBtn, nil];
	[toolbar setItems:items animated:NO];

}

- (void)copyToID
{
    UIPasteboard* board = [UIPasteboard generalPasteboard];
    if(_detailItem.address.loginID)
        board.string = _detailItem.address.loginID;
}

- (void)copyToPassword
{
    UIPasteboard* board = [UIPasteboard generalPasteboard];
    if(_detailItem.address.loginPWD)
        board.string = _detailItem.address.loginPWD;
}

@end
