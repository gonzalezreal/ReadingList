//
//  TGRArrayDataSource.m
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRArrayDataSource.h"

@implementation TGRArrayDataSource

+ (instancetype)dataSourceWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    return [[self alloc] initWithItems:items cellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
}

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    self = [super initWithCellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];

    if (self) {
        _items = [items copy];
    }

    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

@end
