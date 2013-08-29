//
//  TGRBookSearchController.h
//  ReadingList
//
//  Created by guille on 28/08/13.
//  Copyright (c) 2013 Guillermo Gonzalez. All rights reserved.
//

@class TGRBook;

typedef void (^TGRBookBlock)(TGRBook *book);

@interface TGRBookSearchController : NSObject <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate>

@property (strong, nonatomic, readonly) UISearchDisplayController *searchDisplayController;

- (id)initWithSearchBar:(UISearchBar *)searchBar contentsController:(UIViewController *)viewController didSelectBookBlock:(TGRBookBlock)block;

@end
