//
//  TGRBookSearchController.m
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookSearchController.h"
#import "TGRBook.h"
#import "TGRBookCatalog.h"
#import "TGRArrayDataSource.h"
#import "TGRBookCell.h"

static NSString *const kCellIdentifier = @"SearchResultCell";

@interface TGRBookSearchController ()

@property (copy, nonatomic, readonly) TGRBookBlock didSelectBookBlock;
@property (strong, nonatomic) TGRArrayDataSource *dataSource;
@property (strong, nonatomic) TGRBookCatalog *bookCatalog;

@end

@implementation TGRBookSearchController

- (id)initWithSearchBar:(UISearchBar *)searchBar contentsController:(UIViewController *)viewController didSelectBookBlock:(TGRBookBlock)block {
    self = [super init];

    if (self) {
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:viewController];
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsDelegate = self;

        _didSelectBookBlock = [block copy];

        searchBar.delegate = self;
    }

    return self;
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchDisplayDelegate methods

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    self.bookCatalog = [[TGRBookCatalog alloc] init];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    [self.bookCatalog.operationQueue cancelAllOperations];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    tableView.rowHeight = TGRBookCellHeight;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGRBookCell class]) bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    if (![searchString length]) {
        self.dataSource = nil;
    }
    else if ([searchString length] > 2) {
        [self performSelector:@selector(loadResultsWithSearchString:) withObject:searchString afterDelay:0.5];
    }

    return YES;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectBookBlock) {
        self.didSelectBookBlock([self.dataSource itemAtIndexPath:indexPath]);
    }
}

#pragma mark - Private methods

- (void)setDataSource:(TGRArrayDataSource *)dataSource {
    _dataSource = dataSource;

    self.searchDisplayController.searchResultsDataSource = dataSource;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)loadResultsWithSearchString:(NSString *)searchString {
    NSParameterAssert([searchString length]);

    [self.bookCatalog.operationQueue cancelAllOperations];

    @weakify(self);
    
    [self.bookCatalog searchBooksWithTerm:searchString completionBlock:^(NSArray *results, NSError *error) {
        if (error == nil) {
            @strongify(self);
            
            self.dataSource = [TGRArrayDataSource dataSourceWithItems:results cellIdentifier:kCellIdentifier configureCellBlock:^(TGRBookCell *cell, TGRBook *book) {
                [cell configureWithBook:book];
            }];
        }
    }];
}

@end
