//
//  TGRFetchedResultsControllerDataSource.h
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRDataSource.h"

@interface TGRFetchedResultsControllerDataSource : TGRDataSource

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)dataSourceWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                                        cellIdentifier:(NSString *)cellIdentifier
                                    configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock;

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                        cellIdentifier:(NSString *)cellIdentifier
                    configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock;

@end
