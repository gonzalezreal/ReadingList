//
//  TGRArrayDataSource.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRDataSource.h"

@interface TGRArrayDataSource : TGRDataSource

@property (copy, nonatomic, readonly) NSArray *items;

+ (instancetype)dataSourceWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock;

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock;

@end
