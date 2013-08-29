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
#import "UIView+FrameAdditions.h"

const CGFloat TGRBookCellHeight = 96.0;

@implementation TGRBookCell

- (void)prepareForReuse {
    [self.coverImageView cancelImageRequestOperation];
    self.coverImageView.image = nil;
}

- (void)configureWithBook:(TGRBook *)book {
    [self.coverImageView setImageWithURL:book.coverURL];
    self.titleLabel.text = book.title;
    self.authorLabel.text = book.author;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    const CGFloat maxWidth = self.contentView.$width - self.titleLabel.$x - 8;
    const CGSize maxTitleSize = { .width = maxWidth, .height = 58 };

    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                        constrainedToSize:maxTitleSize
                                            lineBreakMode:NSLineBreakByTruncatingTail];
    self.titleLabel.$size = titleSize;

    self.authorLabel.$y = self.titleLabel.$bottom + 2;
    self.authorLabel.$width = maxWidth;
}

@end
