//
//  TGRReadingList.m
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRReadingList.h"
#import "TGRBook.h"

static const int kBatchSize = 40;

@interface TGRReadingList ()

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation TGRReadingList {
    NSManagedObjectContext *_managedObjectContext;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }

    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }

    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];

        NSDictionary *options = @{
                NSMigratePersistentStoresAutomaticallyOption : @YES,
                NSInferMappingModelAutomaticallyOption : @YES
        };

        NSError *error = nil;
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:[NSURL fileURLWithPath:self.filePath]
                                                        options:options
                                                          error:&error];
        NSAssert(error == nil, @"Error: %@", [error localizedDescription]);
    }

    return _persistentStoreCoordinator;
}

+ (NSFetchRequest *)fetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[TGRBook managedObjectEntityName]];
    [fetchRequest setFetchBatchSize:kBatchSize];

    return fetchRequest;
}

- (id)initWithFile:(NSString *)path {
    self = [super init];

    if (self) {
        _filePath = [path copy];
    }

    return self;
}

- (BOOL)containsBook:(TGRBook *)book {
    NSFetchRequest *fetchRequest = [[self class] fetchRequestForBookWithIdentifier:book.identifier];
    NSUInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:NULL];

    return (count != NSNotFound && count > 0);
}

- (BOOL)saveBook:(TGRBook *)book error:(NSError * __autoreleasing *)error {
    NSManagedObject *managedBook = [MTLManagedObjectAdapter managedObjectFromModel:book insertingIntoContext:self.managedObjectContext error:error];

    if (*error == nil) {
        if (book.genres.count > 0) {
            [managedBook setValue:book.genres[0] forKey:@"category"];
        }

        return [self.managedObjectContext save:error];
    }

    return NO;
}

- (BOOL)removeBook:(TGRBook *)book error:(NSError * __autoreleasing *)error {
    NSFetchRequest *fetchRequest = [[self class] fetchRequestForBookWithIdentifier:book.identifier];
    NSManagedObject *managedBook = [[self.managedObjectContext executeFetchRequest:fetchRequest error:error] lastObject];

    if (*error == nil) {
        [self.managedObjectContext deleteObject:managedBook];
        return [self.managedObjectContext save:error];
    }

    return NO;
}

#pragma mark - Private methods

+ (NSFetchRequest *)fetchRequestForBookWithIdentifier:(NSNumber *)identifier {
    static dispatch_once_t onceToken;
    static NSPredicate *predicateTemplate;

    dispatch_once(&onceToken, ^{
        predicateTemplate = [NSPredicate predicateWithFormat:@"identifier == $identifier"];
    });

    NSPredicate *predicate = [predicateTemplate predicateWithSubstitutionVariables:@{
            @"identifier" : identifier
    }];

    NSFetchRequest *fetchRequest = [self fetchRequest];
    [fetchRequest setPredicate:predicate];

    return fetchRequest;
}

@end
