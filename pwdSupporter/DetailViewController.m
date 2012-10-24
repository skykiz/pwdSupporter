//
//  DetailViewController.m
//  pwdSupporter
//
//  Created by 修 大橋 on 12/06/04.
//  Copyright (c) 2012年 TeamKNOx. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "ConnectViewController.h"

static NSString* identifier = @"basis-cell";

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
- (UITextField*) textfieldForCell:(const UIView*)cell;
@end

@implementation DetailViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize connectViewController = _connectViewController;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize detailItem = _detailItem;
@synthesize scrollView = _scrollView;

@synthesize nameField = _nameField;
@synthesize urlField = _urlField;
@synthesize idField = _idField;
@synthesize passwordField = _passwordField;
@synthesize memoField = _memoField;

@synthesize textboxTitle = _textboxTitle;
@synthesize textboxURL = _textboxURL;
@synthesize textboxID = _textboxID;
@synthesize textboxPassword = _textboxPassword;
@synthesize textboxMemo = _textboxMemo;

@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    [self becomeFirstResponder];

    if (self.detailItem) {
        self.nameField.text = self.detailItem.name;
        self.urlField.text = self.detailItem.address.loginURL;
        self.idField.text = self.detailItem.address.loginID;
        self.passwordField.text = self.detailItem.address.loginPWD;
        self.memoField.text = self.detailItem.address.loginMemo;
        
        _textboxTitle.text = self.detailItem.name;
        _textboxURL.text = self.detailItem.address.loginURL;
        _textboxID.text = self.detailItem.address.loginID;
        _textboxPassword.text = self.detailItem.address.loginPWD;
        _textboxMemo.text = self.detailItem.address.loginMemo;
    }
    else{
        self.nameField.text = nil;
        self.urlField.text = nil;
        self.idField.text = nil;
        self.passwordField.text = nil;
        self.memoField.text = nil;

        _textboxTitle.text = nil;
        _textboxURL.text = nil;
        _textboxID.text = nil;
        _textboxPassword.text = nil;
        _textboxMemo.text = nil;
    }
}

- (void)done
{
    if (!self.detailItem) {
        _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) 
                                                    inManagedObjectContext:self.managedObjectContext];
        _detailItem.address = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Address class]) 
                                                            inManagedObjectContext:self.managedObjectContext];
    }
    self.detailItem.name = _textboxTitle.text;
    self.detailItem.address.loginURL = _textboxURL.text;
    self.detailItem.address.loginID = _textboxID.text;
    self.detailItem.address.loginPWD = _textboxPassword.text;
    self.detailItem.address.loginMemo = _textboxMemo.text;
    
//    self.detailItem.name = self.nameField.text;
//    self.detailItem.address.loginURL = self.urlField.text;
//    self.detailItem.address.loginID = self.idField.text;
//    self.detailItem.address.loginPWD = self.passwordField.text;
//    self.detailItem.address.loginMemo = self.memoField.text;
    
    NSLog ( @"%@",self.detailItem.name );

    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.view endEditing:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];

    sections_ = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Title:",@""), NSLocalizedString(@"URL:",@""), NSLocalizedString(@"Login-ID:",@""), NSLocalizedString(@"Login-Password:",@""), NSLocalizedString(@"Memo:",@""), nil];
    
    NSArray* rows1 = [NSArray arrayWithObjects:NSLocalizedString(@"", @""), nil];
    NSArray* rows2 = [NSArray arrayWithObjects:NSLocalizedString(@"", @""), nil];
    NSArray* rows3 = [NSArray arrayWithObjects:NSLocalizedString(@"", @""), nil];
    NSArray* rows4 = [NSArray arrayWithObjects:NSLocalizedString(@"", @""), nil];
    NSArray* rows5 = [NSArray arrayWithObjects:NSLocalizedString(@"", @""), nil];
    NSArray* objects = [NSArray arrayWithObjects:rows1, rows2, rows3, rows4, rows5, nil];
    
    dataSource_ = [[NSDictionary alloc] initWithObjects:objects forKeys:sections_];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.scrollView = nil;
    self.nameField.text = nil;
    self.urlField.text = nil;
    self.idField.text = nil;
    self.passwordField.text = nil;
    self.memoField.text = nil;

    self.textboxTitle.text = nil;
    self.textboxURL.text = nil;
    self.textboxID.text = nil;
    self.textboxPassword.text = nil;
    self.textboxMemo.text = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showWebView"]) {
        self.connectViewController.detailItem = self.detailItem;
        self.connectViewController.managedObjectContext = self.fetchedResultsController.managedObjectContext;
//        [[segue destinationViewController] setDetailItem:self.detailItem];
    }
//    [[segue destinationViewController] setManagedObjectContext:self.fetchedResultsController.managedObjectContext];

}




- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    id key = [sections_ objectAtIndex:section];
    return [[dataSource_ objectForKey:key] count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sections_ count];
}


- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    return [sections_ objectAtIndex:section];
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    id key = [sections_ objectAtIndex:indexPath.section];
    cell.textLabel.text = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	for (UIView* view in cell.contentView.subviews) {
		if ([view isKindOfClass:[UISwitch class]] || [view isKindOfClass:[UITextField class]]) {
			[view removeFromSuperview];
		}
	}
    switch (indexPath.section) {
        case 0:
            switch(indexPath.row){
                case 0:
                    if(!_textboxTitle){
                        _textboxTitle = [self textfieldForCell:cell];
                        _textboxTitle.placeholder = NSLocalizedString(@"Enter Title", @"");
                    }
                    [cell.contentView addSubview:_textboxTitle];
                    _textboxTitle.text = self.detailItem.name; 
                    NSLog ( @"%@",_textboxTitle.text );
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch(indexPath.row){
                case 0:
                    if(!_textboxURL){
                        _textboxURL = [self textfieldForCell:cell];
                        _textboxURL.placeholder = NSLocalizedString(@"Enter URL", @"");
                    }
                    [cell.contentView addSubview:_textboxURL];
                    _textboxURL.text = self.detailItem.address.loginURL;
                    break;
                default:
                    break;
            }
            break;
            
        case 2:
            switch(indexPath.row){
                case 0:
                    if(!_textboxID){
                        _textboxID = [self textfieldForCell:cell];
                        _textboxID.placeholder = NSLocalizedString(@"Enter login-ID", @"");
                    }
                    [cell.contentView addSubview:_textboxID];
                    _textboxID.text = self.detailItem.address.loginID;
                    break;
                default:
                    break;
            }
            break;
            
        case 3:
            switch(indexPath.row){
                case 0:
                    if(!_textboxPassword){
                        _textboxPassword = [self textfieldForCell:cell];
                        _textboxPassword.placeholder = NSLocalizedString(@"Enter login-Password", @"");
                    }
                    [cell.contentView addSubview:_textboxPassword];
                    _textboxPassword.text = self.detailItem.address.loginPWD;
                    break;
                default:
                    break;
            }
            break;
            
        case 4:
            switch(indexPath.row){
                case 0:
                    if(!_textboxMemo){
                        _textboxMemo = [self textfieldForCell:cell];
                        _textboxMemo.frame = CGRectMake(30, cell.bounds.size.height / 8, cell.bounds.size.width / 16 * 14, cell.bounds.size.height / 4 * 8);
                        _textboxMemo.contentVerticalAlignment = UIControlContentVerticalAlignmentTop | UIControlContentHorizontalAlignmentLeft;
                        _textboxMemo.placeholder = NSLocalizedString(@"Memo", @"");
                    }
                    [cell.contentView addSubview:_textboxMemo];
                    _textboxMemo.text = self.detailItem.address.loginMemo;
                    break;
                default:
                    break;
            }
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if(indexPath.section == 4){
        return 100;
    }
    else{
        return 44;
    }
}


-(UITextField*) textfieldForCell:(const UIView*)cell{
    UITextField* theTextField = [[UITextField alloc] init];
    theTextField.delegate = self;
    theTextField.frame = CGRectMake(30, cell.bounds.size.height / 8, cell.bounds.size.width / 16 * 14, cell.bounds.size.height / 4 * 3);
    theTextField.borderStyle = UITextBorderStyleRoundedRect;
    theTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return theTextField;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}


@end
