//
//  TGRDetailViewController.h
//  ReadingList
//
//  Created by guille on 26/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGRDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
