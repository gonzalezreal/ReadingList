//
//  TGRBook.m
//  ReadingList
//
//  Created by guille on 27/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBook.h"

@implementation TGRBook

- (NSURL *)bigCoverURL {
    NSString *bigCoverURL = [[self.coverURL absoluteString] stringByReplacingOccurrencesOfString:@"100x100" withString:@"225x225"];
    return [NSURL URLWithString:bigCoverURL];
}

#pragma mark - JSON serialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"author" : @"artistName",
            @"overview" : @"description",
            @"identifier" : @"trackId",
            @"title" : @"trackName",
            @"coverURL" : @"artworkUrl100"
    };
}

+ (NSValueTransformer *)releaseDateJSONTransformer {
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;

    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    });

    return [MTLValueTransformer transformerWithBlock:^id(NSString *string) {
        return [dateFormatter dateFromString:string];
    }];
}

+ (NSValueTransformer *)coverURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

#pragma mark - Managed object serialization

+ (NSString *)managedObjectEntityName {
    return @"Book";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
            @"coverURL" : @"coverLink"
    };
}

+ (NSValueTransformer *)coverURLEntityAttributeTransformer {
    return [[NSValueTransformer valueTransformerForName:MTLURLValueTransformerName] mtl_invertedTransformer];
}

@end
