//
//  IndexViewController.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFKPageFlipper.h"
#import "MessageModel.h"
#import "FullScreenView.h"
#import "IndexParser.h"
#import "ArticleModel.h"
#import "SearchView.h"
#import "PhotoViewController.h"
#import "ArchiveController.h"
#import "SearchView.h"
#import "FlipFullScreenView.h"
#import "AppDelegate.h"
@interface IndexViewController : UIViewController<AFKPageFlipperDataSource,IndexParserDelegate,UIPopoverControllerDelegate>
{
  	NSMutableArray* viewControlerStack;	
	AFKPageFlipper *flipper;
	UIViewExtention* viewToShowInFullScreen;
	FlipFullScreenView* fullScreenView;
	UIView* fullScreenBGView;
	NSString* wallTitle;
	BOOL isInFullScreenMode;
	NSMutableArray* messageArrayCollection;
    
    NSMutableArray *articles;
    //DetailController *detailController;
    IndexParser *parser;
    dispatch_semaphore_t semaphore;
    ArchiveController* archiveController;
    SearchView* searchView;
    CGRect portraitSize;
    CGRect landSpaceSize;
}
-(void)showViewInFullScreen:(UIViewExtention*)viewToShow withModel:(ArticleModel*)model Mode:(NSString*)mode Animated:(BOOL)anim;
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
-(void)closeFullScreen;
-(void)buildPages:(NSArray*)messagesArray;
- (IBAction)doXMLParser:(id)sender;
-(void)hideArchiveViewAnimate:(BOOL)anim;
-(void)hideSearchViewAnimate:(BOOL)anim;
@property (nonatomic) BOOL isInFullScreenMode;
@property (nonatomic, strong) NSMutableArray *articles;
//@property (nonatomic, retain, readonly) DetailController *detailController;
@property (nonatomic, strong) IndexParser *parser;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *searchBarItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *archiveBarItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logoutBarItem;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) NSMutableArray* viewControlerStack;
@property (nonatomic, strong) UIGestureRecognizer* gestureRecognizer;
@property (nonatomic, strong) NSString* wallTitle;

//- (IBAction)btnLogout:(id)sender;
//@property (retain, nonatomic) IBOutlet UIView *bodyView;

- (IBAction)btnSearchClick:(id)sender;
- (IBAction)btnArchive:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblLoading;
@property (strong, nonatomic) IBOutlet UIImageView *indicator;
@property (strong, nonatomic) IBOutlet UIImageView *indicator2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *aivContentLoading;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;

@end
