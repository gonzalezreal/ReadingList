//
//  TGRBookViewController.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@class TGRBook;
@class TGRReadingList;

@interface TGRBookViewController : UIViewController

@property (copy, nonatomic, readonly) TGRBook *book;
@property (strong, nonatomic, readonly) TGRReadingList *readingList;

- (id)initWithBook:(TGRBook *)book readingList:(TGRReadingList *)readingList;

@end
