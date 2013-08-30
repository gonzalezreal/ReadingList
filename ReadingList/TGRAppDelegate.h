//
//  TGRAppDelegate.h
//  ReadingList
//
//  Created by guille on 26/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGRReadingList;

@interface TGRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) TGRReadingList *readingList;

@end
