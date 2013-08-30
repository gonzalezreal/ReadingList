//
//  TGRFetchedResultsControllerDataSource.m
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRFetchedResultsControllerDataSource.h"

@implementation TGRFetchedResultsControllerDataSource

+ (instancetype)dataSourceWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    return [[self alloc] initWithFetchedResultsController:fetchedResultsController cellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
}

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    self = [super initWithCellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];

    if (self) {
        _fetchedResultsController = fetchedResultsController;
    }

    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController sections][(NSUInteger) section] numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.fetchedResultsController sections][(NSUInteger) section] name];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

@end
