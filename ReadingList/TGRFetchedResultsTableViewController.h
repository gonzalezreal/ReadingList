//
//  TGRFetchedResultsTableViewController.h
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@class TGRFetchedResultsControllerDataSource;

@interface TGRFetchedResultsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) TGRFetchedResultsControllerDataSource *dataSource;
@property (nonatomic) BOOL ignoreContentChanges;

- (void)performFetch;

@end
