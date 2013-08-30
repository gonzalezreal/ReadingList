//
//  TGRReadingList.h
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@class TGRBook;

@interface TGRReadingList : NSObject

@property (copy, nonatomic, readonly) NSString *filePath;
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithFile:(NSString *)path;

- (BOOL)containsBook:(TGRBook *)book;

- (BOOL)saveBook:(TGRBook *)book error:(NSError * __autoreleasing *)error;

- (BOOL)removeBook:(TGRBook *)book error:(NSError * __autoreleasing *)error;

@end
