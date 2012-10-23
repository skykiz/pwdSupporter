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

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
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
    }
    else{
        self.nameField.text = nil;
        self.urlField.text = nil;
        self.idField.text = nil;
        self.passwordField.text = nil;
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
    self.detailItem.name = self.nameField.text;
    self.detailItem.address.loginURL = self.urlField.text;
    self.detailItem.address.loginID = self.idField.text;
    self.detailItem.address.loginPWD = self.passwordField.text;
    
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



@end
