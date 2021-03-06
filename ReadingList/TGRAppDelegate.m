//
//  TGRAppDelegate.m
//  ReadingList
//
//  Created by guille on 26/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import "TGRAppDelegate.h"
#import "TGRBookListViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "TGRReadingList.h"

@implementation TGRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Create the reading list
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [filePath stringByAppendingPathComponent:@"MyReadingList"];
    self.readingList = [[TGRReadingList alloc] initWithFile:filePath];

    // Create the book list view controller
    TGRBookListViewController *bookListViewController = [[TGRBookListViewController alloc] initWithReadingList:self.readingList];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:bookListViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    // Enable network activity indicator
    AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
