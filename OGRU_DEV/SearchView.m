//
//  SearchView.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchView.h"
@interface SearchView()
{
    
        SearchParser* searchPaser;
    NSMutableArray* temp;
    
}
@end
@implementation SearchView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@synthesize bgView;
@synthesize searchView;
@synthesize displayController;
@synthesize searchResultTable;
@synthesize searchBar;

- (void)viewDidUnload {
    [self setDisplayController:nil];
    [self setSearchResultTable:nil];
    [self setSearchBar:nil];
    [self setBgView:nil];
    [self setSearchView:nil];
    searchPaser=nil;
    temp=nil;
    [super viewDidUnload];
    
}
-(void)viewDidLoad
{
    temp=[[NSMutableArray alloc]init];
    self.displayController.searchResultsDelegate=self;
    self.displayController.searchResultsDataSource=self;
    self.displayController.delegate=self;
    self.displayController.searchBar.delegate=self;
    for (UIView *view in searchBar.subviews){
   
        if ([view isKindOfClass: [UITextField class]]) {
            
            UITextField *tf = (UITextField *)view;
         
            tf.delegate = self;
          
            break;
          
        }
    
    }

       if([AppDelegate instance].SearchArticles==nil)
    {
        [AppDelegate instance].SearchArticles=[[NSMutableArray alloc]init];
    }
    else if([AppDelegate instance].SearchArticles.count>0)
    {
         displayController.searchBar.text=[AppDelegate instance].lastSearchString;
          [displayController.searchResultsTableView reloadData];
    }
    self.lblLoading.center=self.searchResultTable.center;
    self.aivLoading.center=self.searchResultTable.center;
    self.aivLoading.frame=CGRectMake(self.aivLoading.frame.origin.x,self.aivLoading.frame.origin.y+self.lblLoading.frame.size.height , self.aivLoading.frame.size.width, self.aivLoading.frame.size.height);
    self.lblLoading.hidden=YES;

}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    //if we only try and resignFirstResponder on textField or searchBar,
    
    //the keyboard will not dissapear (at least not on iPad)!
    
    [self performSelector:@selector(searchBarCancelButtonClicked:) withObject:self.searchBar afterDelay: 0.1];
    
    return YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

         return [AppDelegate instance].SearchArticles.count;
    
  
   
  
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([AppDelegate instance].lastSearchString ==nil) {
        UITableViewCell* blank=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blank"];
        blank.backgroundColor=[UIColor whiteColor];
        return blank;
    }
    NSString *CellIdentifier = @"TitleCell";
    SearchResultTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SearchResultTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setCount:[[NSString alloc] initWithFormat:@"%d",[AppDelegate instance].SearchArticles.count] ];
    return cell;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
    }
    //config the cell
 cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
    cell.lblTitle.frame=CGRectMake(cell.lblTitle.frame.origin.x, cell.lblTitle.frame.origin.y, tableView.frame.size.width, cell.lblTitle.frame.size.height);
    cell.lblTitle.text=[(ArticleModel*)[[AppDelegate instance].SearchArticles objectAtIndex:indexPath.row] title];
       cell.lblDate.text=[(ArticleModel*)[[AppDelegate instance].SearchArticles objectAtIndex:indexPath.row] date];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [[AppDelegate instance]showViewInFullScreen:nil withModel:[[AppDelegate instance].SearchArticles objectAtIndex:indexPath.row]Mode:@"search"];
     
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return NO;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return NO;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [AppDelegate instance].lastSearchString =nil;
     [[AppDelegate instance].SearchArticles removeAllObjects];
    [self.searchResultTable reloadSectionIndexTitles];
    [self.searchResultTable reloadData];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)s
{
    [s resignFirstResponder];
 
    [temp removeAllObjects];
    searchPaser=[[SearchParser alloc]init];
    searchPaser.delegate=self;
    [searchPaser startWithArticleID:searchBar.text];
    if([AppDelegate instance].SearchArticles.count==0)
    {
        [self.aivLoading startAnimating];
        self.lblLoading.hidden=NO;
    }

}
#pragma mark <iTunesRSSParserDelegate> Implementation

- (void)parserDidEndParsingData:(SearchParser *)parser {
    //NSLog(@"parserDidEndParsingData total articles:%d",[articles count]);
    // self.title = [NSString stringWithFormat:NSLocalizedString(@"Top %d Songs", @"Top Songs format"), [songs count]];
    //[self.tableView reloadData];
    //  self.navigationItem.rightBarButtonItem.enabled = YES;
  //  [self buildPages:articles];
   // flipper.dataSource = self;
    [self.aivLoading stopAnimating];
    self.lblLoading.hidden=YES;
  [[AppDelegate instance].SearchArticles removeAllObjects];
      [[AppDelegate instance].SearchArticles addObjectsFromArray:temp];
    [AppDelegate instance].lastSearchString=self.searchBar.text;
    [self.searchResultTable reloadData];
//    [self.searchResultTable reloadSectionIndexTitles];
    //dispatch_semaphore_signal(semaphore);
}

- (void)parser:(SearchParser *)parser didParseIndex:(NSArray *)parsedArticles{
    

    [temp addObjectsFromArray:parsedArticles];
    //  [songs addObjectsFromArray:parsedSongs];
    // Three scroll view properties are checked to keep the user interface smooth during parse. When new objects are delivered by the parser, the table view is reloaded to display them. If the table is reloaded while the user is scrolling, this can result in eratic behavior. dragging, tracking, and decelerating can be checked for this purpose. When the parser finishes, reloadData will be called in parserDidEndParsingData:, guaranteeing that all data will ultimately be displayed even if reloadData is not called in this method because of user interaction.
    //if (!self.tableView.dragging && !self.tableView.tracking && !self.tableView.decelerating) {
    //  self.title = [NSString stringWithFormat:NSLocalizedString(@"Top %d Songs", @"Top Songs format"), [songs count]];
    //[self.tableView reloadData];
    //}
}

-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.frame=CGRectMake(20, tableView.frame.origin.y, tableView.frame.size.width-20, tableView.frame.size.height);
}
- (void)parser:(SearchParser *)parser didFailWithError:(NSError *)error {
    // handle errors as appropriate to your application...
    // dispatch_semaphore_signal(semaphore);
}

- (IBAction)closeSearch:(id)sender {
    [[[AppDelegate instance] viewController]hideSearchViewAnimate:YES];
}
@end
