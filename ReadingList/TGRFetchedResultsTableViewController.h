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

// Maximum number of changes in the fetched results controller that will be animated. Default is 25.
@property (nonatomic) NSUInteger contentAnimationMaximumChangeCount;

- (void)performFetch;

@end
