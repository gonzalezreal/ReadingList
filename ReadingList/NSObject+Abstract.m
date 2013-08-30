//
//  NSObject+Abstract.m
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "NSObject+Abstract.h"
#import <objc/runtime.h>

@implementation NSObject (Abstract)

// Blatantly copied from NSObject+GNUstepBase
- (id)subclassResponsibility:(SEL)aSel {
    char	c = (class_isMetaClass(object_getClass(self)) ? '+' : '-');

    [NSException raise: NSInvalidArgumentException
                format: @"[%@%c%@] should be overridden by subclass",
                        NSStringFromClass([self class]), c,
                        aSel ? (id)NSStringFromSelector(aSel) : (id)@"(null)"];
    return self;	// Not reached
}

@end
