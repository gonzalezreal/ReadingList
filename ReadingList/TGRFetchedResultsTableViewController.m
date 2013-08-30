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

@property (nonatomic) BOOL shouldEndTableViewUpdates;

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

- (void)setIgnoreContentChanges:(BOOL)ignore {
    if (ignore) {
        _ignoreContentChanges = YES;
    }
    else {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _ignoreContentChanges = NO;
        }];
    }
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (!self.ignoreContentChanges) {
        [self.tableView beginUpdates];
        self.shouldEndTableViewUpdates = YES;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    if (!self.ignoreContentChanges) {
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
                break;

            case NSFetchedResultsChangeDelete:
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            default:
                break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    if (!self.ignoreContentChanges) {
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;

            case NSFetchedResultsChangeDelete:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;

            case NSFetchedResultsChangeUpdate:
                [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;

            case NSFetchedResultsChangeMove:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.shouldEndTableViewUpdates) {
        [self.tableView endUpdates];
    }
}

@end
