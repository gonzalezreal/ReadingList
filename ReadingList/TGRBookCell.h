//
//  TGRBookCell.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@class TGRBook;

extern const CGFloat TGRBookCellHeight;

@interface TGRBookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

- (void)configureWithBook:(TGRBook *)book;

@end
