//
//  SearchView.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchParser.h"
#import "SearchResultCell.h"
#import "SearchResultTitleCell.h"
@interface SearchView : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,SearchParserDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UISearchDisplayController *displayController;
@property (strong, nonatomic) IBOutlet UITableView *searchResultTable;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)closeSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bgView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UILabel *lblLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aivLoading;

@end
