//
//  TGRBookResponse.m
//  ReadingList
//
//  Created by Steve Moser on 8/19/14.
//  Copyright (c) 2014 Guillermo Gonzalez. All rights reserved.
//

#import "TGRBookResponse.h"

@implementation TGRBookResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"results";
}

@end
