//
//  AppDelegate.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
static NSCache *imageCache = nil;
static NSCache *indexImageCache=nil;

@implementation AppDelegate

@synthesize viewController,IndexArticles,SearchArticles,Archiverticles;
@synthesize window ,lastSearchString,ogruReach,hostReach;
- (void)dealloc
{
    self.viewController=nil;
    self.IndexArticles=nil;
    self.SearchArticles=nil;
    self.Archiverticles=nil;
    self.window=nil;
    self.lastSearchString=nil;
    self.ogruReach=nil;
    self.hostReach=nil;
    
}
+ (AppDelegate *) instance {
	return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}
/* We use a single NSCache for all instances of ImageFile.  The count limit is set to a value that allows demonstrating the cache evicting objects.
 */
+ (void)initialize {
    if (self == [AppDelegate class]) {
        imageCache = [[NSCache alloc] init];
        [imageCache setCountLimit:40];
        indexImageCache=[[NSCache alloc]init];
        [indexImageCache setCountLimit:40];

    }
    
}

+ (NSCache *)imageCache {
    return imageCache;
}
+ (NSCache *)indexImageCache {
    return indexImageCache;
}
/* In case we want to have a per-instance cache.
 */
- (NSCache *)imageCache {
    return imageCache;
}
- (NSCache *)indexImageCache {
    return indexImageCache;
}
- (UIImage *)imageWithURL:(NSString*)url {
    NSCache *cache = [self imageCache];
   
    UIImage *image;
    if (!(image = [cache objectForKey:url])) {
        // Cache miss, recreate image
        
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        image = [[UIImage alloc] initWithData:imageData] ;
   
      
        if (image) {	// Insert image in cache
            [cache setObject:image forKey:url];
        }
     
    }
    return image;
}
- (UIImage *)indexImageWithURL:(NSString*)url {
  //  NSCache *cache = [self indexImageCache];
    
   // UIImage *image;
  //  if (!(image = [cache objectForKey:url])) {
        // Cache miss, recreate image
        
  //      NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
 //       image = [[UIImage alloc] initWithData:imageData] ;
     
        
    //    if (image) {	// Insert image in cache
   //         [cache setObject:image forKey:url];
    //    }
        
  //  }
 //   return image;
    return [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]]];
}
//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    if (curReach==hostReach && curReach.currentReachabilityStatus==NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Login"
                              
                                                        message:@"Network is not reachable"  //警告訊息內文的設定
                                                       delegate:self // 叫出AlertView之後，要給該ViewController去處理
                              
                                              cancelButtonTitle:@"OK"  //cancel按鈕文字的設定
                                              otherButtonTitles: nil]; // 其他按鈕的設定
        [alert show];
        [viewController performSegueWithIdentifier:@"Logout" sender:nil];
    }
    else if (curReach==ogruReach && curReach.currentReachabilityStatus==NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Get Articles"
                              
                                                        message:@"Network is not reachable"  //警告訊息內文的設定
                                                       delegate:self // 叫出AlertView之後，要給該ViewController去處理
                              
                                              cancelButtonTitle:@"OK"  //cancel按鈕文字的設定
                                              otherButtonTitles: nil]; // 其他按鈕的設定
        [alert show];
        [viewController performSegueWithIdentifier:@"Logout" sender:nil];
    }
}
	

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   // viewController = [[IndexViewController alloc] initWithNibName:nil bundle:nil];
	
   // [self.window addSubview:viewController.view];
    //[self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	hostReach = [Reachability reachabilityWithHostName: @"ogru.ctkpro.com"];
	[hostReach startNotifier];
    
     ogruReach  = [Reachability reachabilityWithHostName: @"65.223.18.5"];
	[ogruReach startNotifier];
    
	//    internetReach = [Reachability reachabilityForInternetConnection];
	//[internetReach startNotifier];
    
   // wifiReach = [Reachability reachabilityForLocalWiFi];
	//[wifiReach startNotifier];
	
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)showViewInFullScreen:(UIViewExtention*)viewToShow withModel:(ArticleModel*)model Mode:(NSString*)mode{
    BOOL anim=!viewController.isInFullScreenMode;
    if(viewController.isInFullScreenMode)
    {
        [viewController closeFullScreen];
    }
	[viewController showViewInFullScreen:viewToShow withModel:model Mode:mode Animated:anim];
}
-(void)closeFullScreen {
	[viewController closeFullScreen];
}
+ (int)getSplitIndexWithString:(NSString *)str frame:(CGRect)frame andFont:(UIFont *)font
{
    int length = 0;
    int lastSpace = 0;
    NSString *cutText = [str substringToIndex:length];
    CGSize textSize = [cutText sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height + 500)];
    while (textSize.height <= frame.size.height)
    {
        if (length==str.length) {
            return length;
        }
        NSRange range = NSMakeRange (length, 1);
        if ([[str substringWithRange:range] isEqualToString:@" "])
        {
            lastSpace = length;
        }
        length++;
        cutText = [str substringToIndex:length];
        textSize = [cutText sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height + 500)];
    }

    return lastSpace;
}
@end
