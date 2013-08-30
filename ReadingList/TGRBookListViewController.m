//
//  TGRBookListViewController.m
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookListViewController.h"
#import "TGRBookSearchController.h"
#import "TGRBookViewController.h"
#import "TGRReadingList.h"
#import "TGRBook.h"
#import "TGRFetchedResultsControllerDataSource.h"
#import "TGRBookCell.h"

typedef NS_ENUM(NSInteger, TGRBookListSortOrder) {
    TGRBookListSortOrderTitle = 0,
    TGRBookListSortOrderAuthor,
    TGRBookListSortOrderCategory
};

static NSString *const kCellIdentifier = @"BookCell";

@interface TGRBookListViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) TGRBookSearchController *bookSearchController;

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender;

@end

@implementation TGRBookListViewController

- (id)initWithReadingList:(TGRReadingList *)readingList {
    self = [super init];
    if (self) {
        _readingList = readingList;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Reading List", @"");

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGRBookCell class]) bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    self.tableView.sectionIndexMinimumDisplayRowCount = INT_MAX;

    [self setupSearchBar];
    [self setupBookSearchController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setupToolbar:animated];

    if (!self.dataSource) {
        [self setSortOrder:TGRBookListSortOrderTitle];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setToolbarHidden:YES animated:animated];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *item = [self.dataSource itemAtIndexPath:indexPath];
    TGRBook *book = [MTLManagedObjectAdapter modelOfClass:[TGRBook class] fromManagedObject:item error:NULL];

    TGRBookViewController *bookViewController = [[TGRBookViewController alloc] initWithBook:book readingList:self.readingList];
    [self.navigationController pushViewController:bookViewController animated:YES];
}

#pragma mark - Private methods

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [self setSortOrder:(TGRBookListSortOrder) sender.selectedSegmentIndex];
}

- (void)setupSearchBar {
    self.searchBar.placeholder = NSLocalizedString(@"Search iBooks Store", @"");

    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:UITextField.class]) {
            UITextField *textField = (UITextField *) view;
            [textField setReturnKeyType:UIReturnKeyDone];
            break;
        }
    }
}

- (void)setupBookSearchController {
    UINavigationController *navigationController = self.navigationController;
    TGRReadingList *readingList = self.readingList;

    self.bookSearchController = [[TGRBookSearchController alloc] initWithSearchBar:self.searchBar contentsController:self didSelectBookBlock:^(TGRBook *book) {
        TGRBookViewController *bookViewController = [[TGRBookViewController alloc] initWithBook:book readingList:readingList];
        [navigationController pushViewController:bookViewController animated:YES];
    }];
}

- (void)setupToolbar:(BOOL)animated {
    if (!self.toolbarItems) {
        self.toolbarItems = @[
                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                              target:nil action:nil],
                [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl],
                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                              target:nil action:nil]
        ];
    }

    if ([self.navigationController isToolbarHidden]) {
        [self.navigationController setToolbarHidden:NO animated:animated];
    }
}

- (void)setSortOrder:(TGRBookListSortOrder)sortOrder {
    NSDictionary *sortDescriptors = @{
            @(TGRBookListSortOrderTitle) : @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]],
            @(TGRBookListSortOrderAuthor) : @[[NSSortDescriptor sortDescriptorWithKey:@"author" ascending:YES]],
            @(TGRBookListSortOrderCategory) : @[[NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES]]
    };
    NSDictionary *sectionNameKeyPaths = @{
            @(TGRBookListSortOrderCategory) : @"category"
    };
    
    NSFetchRequest *fetchRequest = [TGRReadingList fetchRequest];
    fetchRequest.sortDescriptors = sortDescriptors[@(sortOrder)];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:self.readingList.managedObjectContext
                                                                                                 sectionNameKeyPath:sectionNameKeyPaths[@(sortOrder)]
                                                                                                          cacheName:nil];
    TGRDataSourceConfigureCellBlock configureCellBlock = ^(TGRBookCell *cell, NSManagedObject *item) {
        TGRBook *book = [MTLManagedObjectAdapter modelOfClass:[TGRBook class] fromManagedObject:item error:NULL];
        [cell configureWithBook:book];
    };
    
    self.dataSource = [TGRFetchedResultsControllerDataSource dataSourceWithFetchedResultsController:fetchedResultsController
                                                                                     cellIdentifier:kCellIdentifier
                                                                                 configureCellBlock:configureCellBlock];
}

@end
