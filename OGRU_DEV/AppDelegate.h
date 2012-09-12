//
//  AppDelegate.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    IndexViewController *viewController;

    
    Reachability* hostReach;
    Reachability* ogruReach;

    Reachability* internetReach;
    Reachability* wifiReach;
       
}
+ (AppDelegate *) instance;

-(void)showViewInFullScreen:(UIViewExtention*)viewToShow withModel:(ArticleModel*)model Mode:(NSString*)mode;
-(void)closeFullScreen;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) IndexViewController *viewController;
@property (nonatomic,retain) NSMutableArray* IndexArticles;
@property (nonatomic,retain) NSMutableArray* SearchArticles;
@property (nonatomic,retain) NSMutableArray* Archiverticles;
@property (nonatomic,copy) NSString* lastSearchString;
@property (nonatomic,retain) Reachability* hostReach;
@property (nonatomic,retain) Reachability* ogruReach;
+ (NSCache *)imageCache;
+ (NSCache *)indexImageCache;
+ (int)getSplitIndexWithString:(NSString *)str frame:(CGRect)frame andFont:(UIFont *)font;
- (UIImage *)imageWithURL:(NSString*)url ;
- (UIImage *)indexImageWithURL:(NSString*)url ;
@end
