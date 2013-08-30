//
//  TGRFetchedResultsTableViewController.m
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRFetchedResultsTableViewController.h"
#import "TGRFetchedResultsControllerDataSource.h"

@interface TGRFetchedResultsTableViewController ()

@property (strong, nonatomic) NSMutableIndexSet *insertedSections;
@property (strong, nonatomic) NSMutableIndexSet *deletedSections;
@property (strong, nonatomic) NSMutableArray *insertedRows;
@property (strong, nonatomic) NSMutableArray *deletedRows;
@property (strong, nonatomic) NSMutableArray *updatedRows;

@end

@implementation TGRFetchedResultsTableViewController

- (void)setDataSource:(TGRFetchedResultsControllerDataSource *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource.fetchedResultsController.delegate = nil;
        _dataSource = dataSource;
        _dataSource.fetchedResultsController.delegate = self;

        self.tableView.dataSource = dataSource;
        [self performFetch];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        _contentAnimationMaximumChangeCount = 25;
    }

    return self;
}

- (void)performFetch {
    if (self.dataSource) {
        NSError *error = nil;
        [self.dataSource.fetchedResultsController performFetch:&error];

        NSAssert(!error, @"error: %@", [error localizedDescription]);
    }

    [self.tableView reloadData];
}

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.insertedSections addIndex:sectionIndex];
            break;

        case NSFetchedResultsChangeDelete:
            [self.deletedSections addIndex:sectionIndex];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (![self.insertedSections containsIndex:(NSUInteger) newIndexPath.section]) {
                [self.insertedRows addObject:newIndexPath];
            }

            break;

        case NSFetchedResultsChangeDelete:
            if (![self.deletedSections containsIndex:(NSUInteger) indexPath.section]) {
                [self.deletedRows addObject:indexPath];
            }

            break;

        case NSFetchedResultsChangeUpdate:
            [self.updatedRows addObject:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            if (![self.insertedSections containsIndex:(NSUInteger) newIndexPath.section]) {
                [self.insertedRows addObject:newIndexPath];
            }
            if (![self.deletedSections containsIndex:(NSUInteger) indexPath.section]) {
                [self.deletedRows addObject:indexPath];
            }

            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSUInteger changeCount = self.insertedSections.count + self.deletedSections.count +
            self.insertedRows.count + self.deletedRows.count + self.updatedRows.count;

    if (changeCount <= self.contentAnimationMaximumChangeCount) {
        [self.tableView beginUpdates];
        [self.tableView deleteSections:self.deletedSections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView insertSections:self.insertedSections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView deleteRowsAtIndexPaths:self.deletedRows withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView insertRowsAtIndexPaths:self.insertedRows withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView reloadRowsAtIndexPaths:self.updatedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    else {
        [self.tableView reloadData];
    }

    self.insertedSections = nil;
    self.deletedSections = nil;
    self.insertedRows = nil;
    self.deletedRows = nil;
    self.updatedRows = nil;
}

#pragma mark - Private methods

- (NSMutableIndexSet *)insertedSections {
    if (!_insertedSections) {
        _insertedSections = [[NSMutableIndexSet alloc] init];
    }
    return _insertedSections;
}

- (NSMutableIndexSet *)deletedSections {
    if (!_deletedSections) {
        _deletedSections = [[NSMutableIndexSet alloc] init];
    }
    return _deletedSections;
}

- (NSMutableArray *)insertedRows {
    if (!_insertedRows) {
        _insertedRows = [[NSMutableArray alloc] init];
    }
    return _insertedRows;
}

- (NSMutableArray *)deletedRows {
    if (!_deletedRows) {
        _deletedRows = [[NSMutableArray alloc] init];
    }
    return _deletedRows;
}

- (NSMutableArray *)updatedRows {
    if (!_updatedRows) {
        _updatedRows = [[NSMutableArray alloc] init];
    }
    return _updatedRows;
}

@end
