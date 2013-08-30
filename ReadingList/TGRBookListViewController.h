//
//  TGRBookListViewController.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRFetchedResultsTableViewController.h"

@class TGRReadingList;

@interface TGRBookListViewController : TGRFetchedResultsTableViewController

@property (strong, nonatomic, readonly) TGRReadingList *readingList;

- (id)initWithReadingList:(TGRReadingList *)readingList;

@end
