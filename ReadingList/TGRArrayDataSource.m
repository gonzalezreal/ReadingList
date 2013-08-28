//
//  TGRArrayDataSource.m
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRArrayDataSource.h"

@interface TGRArrayDataSource ()

@property (copy, nonatomic, readonly) NSString *cellIdentifier;
@property (copy, nonatomic, readonly) TGRDataSourceConfigureCellBlock configureCellBlock;

@end

@implementation TGRArrayDataSource

+ (instancetype)dataSourceWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    return [[self alloc] initWithItems:items cellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
}

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    NSParameterAssert(configureCellBlock);

    self = [super init];

    if (self) {
        _items = [items copy];
        _cellIdentifier = [cellIdentifier copy];
        _configureCellBlock = [configureCellBlock copy];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);

    return cell;
}

@end
