//
//  TGRBookViewController.m
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookViewController.h"
#import "TGRBook.h"

#import "UIImageView+AFNetworking.h"
#import "UIView+FrameAdditions.h"

static NSString *const kBookDescriptionFormat = @"<html>"
        "<style type=\"text/css\">"
        "body { font-family:HelveticaNeue; font-size:15;}"
        "</style>"
        "<body>"
        "%@"
        "</body></html>";

@interface TGRBookViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionView;

@end

@implementation TGRBookViewController

- (id)initWithBook:(TGRBook *)book {
    self = [super init];
    if (self) {
        _book = [book copy];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Info", @"");

    [self setupViews];
}

- (void)viewDidLayoutSubviews {
    [self layoutHeader];
    [self layoutDescription];
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self layoutDescription];
}

#pragma mark - Private methods

- (void)setupViews {
    [self.coverImageView setImageWithURL:self.book.bigCoverURL];

    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    [self layoutHeader];

    self.genreLabel.text = [self.book.genres mtl_firstObject];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;

    self.releaseDateLabel.text = [dateFormatter stringFromDate:self.book.releaseDate];

    if (self.book.overview) {
        NSString *htmlString = [NSString stringWithFormat:kBookDescriptionFormat, self.book.overview];
        [self.descriptionView loadHTMLString:htmlString baseURL:nil];
        self.descriptionView.scrollView.scrollEnabled = NO;
    }
}

- (void)layoutHeader {
    const CGFloat maxWidth = self.view.$width - self.titleLabel.$x - 8;
    const CGSize maxTitleSize = (CGSize) { .width = maxWidth, .height = 58 };

    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                        constrainedToSize:maxTitleSize
                                            lineBreakMode:NSLineBreakByTruncatingTail];
    self.titleLabel.$size = titleSize;

    self.authorLabel.$y = self.titleLabel.$bottom + 2;
    self.authorLabel.$width = maxWidth;
}

- (void)layoutDescription {
    self.descriptionView.$height = [[self.descriptionView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight;"] floatValue];
    self.scrollView.contentSize = (CGSize) { .width = self.view.$width, .height = self.descriptionView.$bottom };
}

@end
