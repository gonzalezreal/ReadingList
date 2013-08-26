//
//  TGRMasterViewController.h
//  ReadingList
//
//  Created by guille on 26/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGRDetailViewController;

@interface TGRMasterViewController : UITableViewController

@property (strong, nonatomic) TGRDetailViewController *detailViewController;

@end
