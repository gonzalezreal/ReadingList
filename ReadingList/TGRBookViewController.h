//
//  TGRBookViewController.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGRBook;

@interface TGRBookViewController : UITableViewController

@property (copy, nonatomic, readonly) TGRBook *book;

- (id)initWithBook:(TGRBook *)book;

@end
