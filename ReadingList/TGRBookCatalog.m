//
//  TGRBookCatalog.m
//  ReadingList
//
//  Created by guille on 27/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookCatalog.h"
#import "TGRBook.h"
#import "TGRBookResponse.h"

@implementation TGRBookCatalog

- (id)init {
    return [super initWithBaseURL:[NSURL URLWithString:@"https://itunes.apple.com"]];
}

- (void)searchBooksWithTerm:(NSString *)term completionBlock:(void (^)(NSArray *results, NSError *error))block {
    NSParameterAssert(term);
    NSParameterAssert(block);
    
    NSDictionary *parameters = @{
                                 @"term" : term,
                                 @"entity" : @"ebook"
                                 };

    [self GET:@"search" parameters:parameters
        completion:^(OVCResponse *response, NSError *error) {
            block(response.result, error);
   }];
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"*": [TGRBook class],
             };
}

+ (Class)responseClass {
    return [TGRBookResponse class];
}

@end
