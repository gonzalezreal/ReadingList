//
//  TGRBookListViewController.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@class TGRReadingList;

@interface TGRBookListViewController : UITableViewController

@property (strong, nonatomic, readonly) TGRReadingList *readingList;

- (id)initWithReadingList:(TGRReadingList *)readingList;

@end
