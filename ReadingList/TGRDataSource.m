//
//  TGRDataSource.m
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRDataSource.h"
#import "NSObject+Abstract.h"

@interface TGRDataSource ()

@property (copy, nonatomic, readonly) NSString *cellIdentifier;
@property (copy, nonatomic, readonly) TGRDataSourceConfigureCellBlock configureCellBlock;

@end

@implementation TGRDataSource

- (id)initWithCellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock {
    NSParameterAssert(configureCellBlock);

    self = [super init];

    if (self) {
        _cellIdentifier = [cellIdentifier copy];
        _configureCellBlock = [configureCellBlock copy];
    }

    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    [self subclassResponsibility:_cmd];
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self subclassResponsibility:_cmd];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);

    return cell;
}

@end
