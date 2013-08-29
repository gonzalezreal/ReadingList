//
//  TGRBook.h
//  ReadingList
//
//  Created by guille on 27/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@interface TGRBook : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *author;
@property (copy, nonatomic, readonly) NSString *overview;
@property (copy, nonatomic, readonly) NSArray *genres;
@property (copy, nonatomic, readonly) NSDate *releaseDate;
@property (copy, nonatomic, readonly) NSNumber *identifier;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSURL *coverURL;
@property (copy, nonatomic, readonly) NSURL *bigCoverURL;

@end
