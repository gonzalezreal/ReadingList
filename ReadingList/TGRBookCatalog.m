//
//  TGRBookCatalog.m
//  ReadingList
//
//  Created by guille on 27/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookCatalog.h"
#import "TGRBook.h"

@implementation TGRBookCatalog

- (id)init {
    return [super initWithBaseURL:[NSURL URLWithString:@"https://itunes.apple.com"]];
}

- (void)searchBooksWithTerm:(NSString *)term completionBlock:(void (^)(NSArray *results, NSError *error))block {
    NSParameterAssert(term);
    NSParameterAssert(block);

    OVCQuery *query = [OVCQuery queryWithMethod:OVCQueryMethodGet
                                           path:@"search"
                                     parameters:@{
                                             @"term" : term,
                                             @"entity" : @"ebook"
                                     }
                                     modelClass:[TGRBook class]
                                  objectKeyPath:@"results"];

    [self executeQuery:query completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
        block(object, error);
    }];
}

@end
