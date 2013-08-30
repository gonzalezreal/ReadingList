//
//  NSObject+Abstract.h
//  ReadingList
//
//  Created by guille on 30/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Abstract)

// Blatantly copied from NSObject+GNUstepBase
- (id)subclassResponsibility:(SEL)aSel;

@end
