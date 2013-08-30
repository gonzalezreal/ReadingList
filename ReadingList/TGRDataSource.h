//
//  TGRDataSource.h
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

typedef void (^TGRDataSourceConfigureCellBlock)(id cell, id item);

@interface TGRDataSource : NSObject <UITableViewDataSource>

- (id)initWithCellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TGRDataSourceConfigureCellBlock)configureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
