//
//  ConnectViewController.m
//  pwdSupporter
//
//  Created by ooo on 2012/10/23.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import "ConnectViewController.h"
#import "DetailViewController.h"
#import <Twitter/TWTweetComposeViewController.h>

@interface ConnectViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation UIView (FindFirstResponder)

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
	
//  [self.view addSubview:toolbar];
//  [self createToolbarItems];


    // Add the Insert button
    UIBarButtonItem *tweetButton= [[UIBarButtonItem alloc]
                                  initWithTitle:NSLocalizedString(@"Tweet", @"")
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(tweetLogin)];
    
    self.navigationItem.rightBarButtonItem = tweetButton;
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
    
    // Start observing
    if (!_observing) {
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(keyboardWillShow:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(keybaordWillHide:)
                       name:UIKeyboardWillHideNotification
                     object:nil];
        
        _observing = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

    // Stop observing
    if (_observing) {
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center removeObserver:self
                          name:UIKeyboardWillShowNotification
                        object:nil];
        [center removeObserver:self
                          name:UIKeyboardWillHideNotification
                        object:nil];
        
        _observing = NO;
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)createToolbarItems
{
    UIBarButtonItem *idBtn =
    [[UIBarButtonItem alloc]
     initWithTitle:NSLocalizedString(@"     ID     ", @"")
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(copyToID)
     ];

    UIBarButtonItem *pwdBtn =
    [[UIBarButtonItem alloc]
     initWithTitle:NSLocalizedString(@"Password", @"")
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(copyToPassword)
     ];

    UIBarButtonItem *tweetBtn =
    [[UIBarButtonItem alloc]
     initWithTitle:NSLocalizedString(@"tweet", @"")
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(tweetLogin)
     ];
    
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
    
	NSArray *items = [NSArray arrayWithObjects: tweetBtn, /*systemItem, addItem, */flexItem, idBtn, pwdBtn, nil];
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

- (void)tweetLogin
{
    // ビューコントローラの初期化
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"yyyy/MM/dd HH:mm:ss";
    NSString *str = [df stringFromDate:[NSDate date]];
    
    // 送信文字列を設定
    NSString* tweetSentense = [NSString stringWithFormat:@"%@ is log-in at %@ on %@.", _detailItem.address.loginID, _detailItem.name, str];;
    
    [tweetViewController setInitialText:tweetSentense];
    
    // 送信画像を設定
//    [tweetViewController addImage:[UIImage imageNamed:@"test.png"]];
    
    // イベントハンドラ定義
    tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        if (res == TWTweetComposeViewControllerResultCancelled) {
            NSLog(@"キャンセル");
        }
        else if (res == TWTweetComposeViewControllerResultDone) {
            NSLog(@"成功");
        }
        [self dismissModalViewControllerAnimated:YES];
    };
    
    // 送信View表示
    [self presentModalViewController:tweetViewController animated:YES];
    
}

- (void)keyboardWillShow:(NSNotification *)notificatioin
{

    NSMutableArray* menuItems = [NSMutableArray array];
    
    UIMenuController* menuController = [UIMenuController sharedMenuController];
    [menuController setTargetRect:CGRectZero inView:self.view];
    menuController.arrowDirection = UIMenuControllerArrowDown;
    
    [menuItems addObject:
     [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"login-ID", @"")
                                action:@selector(menu1:)]];
    [menuItems addObject:
     [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"login-PWD", @"")
                                action:@selector(menu2:)]];
    
    menuController.menuItems = menuItems;
    [menuController setMenuVisible:YES animated:YES];

    
    return;
}

- (void)keybaordWillHide:(NSNotification*)notification
{
    return;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(menu1:) ||
        action == @selector(menu2:) ||
        action == @selector(paste:)){
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)menu1:(id)sender
{
    [self copyToID];

    UIView* firstView = [myWebView findFirstResponder];
    if ([firstView respondsToSelector:@selector(paste:)]) {
        [firstView paste:sender];
    }
}

- (void)menu2:(id)sender
{
    [self copyToPassword];

    UIView* firstView = [myWebView findFirstResponder];
    if ([firstView respondsToSelector:@selector(paste:)]) {
        [firstView paste:sender];
    }
}

- (void)paste:(id)sender
{
    return [super paste:sender];
}

@end
