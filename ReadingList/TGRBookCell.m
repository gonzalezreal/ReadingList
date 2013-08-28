//
//  TGRBookCell.m
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookCell.h"
#import "TGRBook.h"

#import "UIImageView+AFNetworking.h"

const CGFloat TGRBookCellHeight = 96.0;

@implementation TGRBookCell

- (void)prepareForReuse {
    [self.coverImageView cancelImageRequestOperation];
}

- (void)configureWithBook:(TGRBook *)book {
    [self.coverImageView setImageWithURL:book.coverURL];
    self.titleLabel.text = book.title;
    self.authorLabel.text = book.author;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // TODO: layout labels
}

@end
