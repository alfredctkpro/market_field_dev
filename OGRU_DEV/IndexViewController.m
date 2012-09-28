//
//  IndexViewController.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IndexViewController.h"
#import "TitleAndTextView.h"
#import "Layout6.h"
#import "Layout5_1.h"
#import "Layout5_2.h"

#import "Layout1.h"
#import "Layout2.h"
#import "Layout3_1.h"
#import "Layout3_2.h"
#import "Layout4_1.h"
#import "Layout4_2.h"
#import "UIViewExtention.h"
#import "AFKPageFlipper.h"
#import "FullScreenView.h"
#import "FooterView.h"
#import "HeaderView.h"

#import "MessageModel.h"
#import "ArticleModel.h"

@interface IndexViewController ()

@end

@implementation IndexViewController
{
     __weak UIPopoverController *searchPopover;
    __weak UIPopoverController *archivePopover;
     NSMutableDictionary* preIndexView;
   // NSOperationQueue *queue ;
    
}
@synthesize lblHeader;
@synthesize searchBarItem;
@synthesize archiveBarItem;
@synthesize logoutBarItem;
@synthesize toolbar;
@synthesize lblLoading;
@synthesize indicator;
@synthesize indicator2;
@synthesize aivContentLoading;
@synthesize bgImage;
@synthesize viewControlerStack,gestureRecognizer,wallTitle,parser,articles,isInFullScreenMode;
-(void)preBuild:(NSNumber*)numberPage
{
    NSInteger page=[numberPage integerValue];
    for (id key in preIndexView) {
        if (abs([key integerValue]-page)>2) {
            [preIndexView removeObjectForKey:key];
        }
    }
    for (int i=page-2; i<=page+2; i++) {
        if (i>0 && [preIndexView objectForKey:[NSString stringWithFormat:@"%i",i]]==nil) {
            [self prepareIndexView:i];
        }
    }
}
-(void)prepareIndexView:(NSInteger)page
{
    if (page==1 || page==[viewControlerStack count]+2) {
        UIView* view=[[UIView alloc]init];
        
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:
                        [[NSBundle mainBundle]pathForResource:@"flipEND_bg" ofType:@"png"]];
        [view setBackgroundColor:[UIColor colorWithPatternImage:img]];
        
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            [view setFrame:portraitSize];//直立的大小，遇到橫立的要給另一個大小
        }else {
            [view setFrame:landSpaceSize];//直立的大小，遇到橫立的要給另一個大小
        }
        
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [preIndexView setObject:view forKey:[NSString stringWithFormat:@"%i",page]];
        return;
    }
    
    
    LayoutViewExtention* layoutToReturn = nil;
    NSString* layoutNumber = [viewControlerStack objectAtIndex:page-2];
    
    int rangeFrom = 0;
    int rangeTo = 0;
    BOOL shouldContinue = FALSE;
    
    for (int i=0; i<page-2; i++) {
        rangeFrom+=[[[viewControlerStack objectAtIndex:i] substringWithRange:NSMakeRange(0, 1)] intValue];
    }
    rangeTo=[[[viewControlerStack objectAtIndex:page-2]substringWithRange:NSMakeRange(0, 1)]intValue];
    
    
    if (page-1<viewControlerStack.count+2) {
        shouldContinue=TRUE;
    }
    
    if (shouldContinue) {
        
        NSRange rangeForView = NSMakeRange(rangeFrom, rangeTo);
        
        NSArray* messageArray= [[AppDelegate instance].IndexArticles subarrayWithRange:rangeForView];
        
        NSMutableDictionary* viewDictonary = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [messageArray count]; i++) {
            if (i == 0) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view1"];
            }
            if (i == 1) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view2"];
            }
            if (i == 2) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view3"];
            }
            if (i == 3) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view4"];
            }
            if (i == 4) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view5"];
            }
        }
        
        Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%@",layoutNumber]);
        id layoutObject ;
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            layoutObject= [[class alloc] initWithFrame:portraitSize];
         
            //直立的大小，遇到橫立的要給另一個大小
        }else {
            layoutObject= [[class alloc] initWithFrame:landSpaceSize];
            
        }
        if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
            
            layoutToReturn = (LayoutViewExtention*)layoutObject;
            
            [layoutToReturn initalizeViews:viewDictonary];
            [layoutToReturn rotate:self.interfaceOrientation animation:NO];
    
                while (![layoutToReturn isDidLoadFinsh]) {
                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
                 }
            
            layoutToReturn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
    }
    
    [preIndexView setObject:layoutToReturn forKey:[NSString stringWithFormat:@"%i",page]];
    

}
-(void)prepareIndexView2:(NSInteger)page
{
    if (page==1 || page==[viewControlerStack count]+2) {
        UIView* view=[[UIView alloc]init];
        
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:
                        [[NSBundle mainBundle]pathForResource:@"flipEND_bg" ofType:@"png"]];
        [view setBackgroundColor:[UIColor colorWithPatternImage:img]];
        
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            [view setFrame:portraitSize];//直立的大小，遇到橫立的要給另一個大小
        }else {
            [view setFrame:landSpaceSize];//直立的大小，遇到橫立的要給另一個大小
        }
        
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [preIndexView setObject:view forKey:[NSString stringWithFormat:@"%i",page]];
        return;
    }
    
    
    LayoutViewExtention* layoutToReturn = nil;
    NSString* layoutNumber = [viewControlerStack objectAtIndex:page-2];
    
    int rangeFrom = 0;
    int rangeTo = 0;
    BOOL shouldContinue = FALSE;
    
    for (int i=0; i<page-2; i++) {
        rangeFrom+=[[[viewControlerStack objectAtIndex:i] substringWithRange:NSMakeRange(0, 1)] intValue];
    }
    rangeTo=[[[viewControlerStack objectAtIndex:page-2]substringWithRange:NSMakeRange(0, 1)]intValue];
    
    
    if (page-1<viewControlerStack.count+2) {
        shouldContinue=TRUE;
    }
    
    if (shouldContinue) {
        
        NSRange rangeForView = NSMakeRange(rangeFrom, rangeTo);
        
        NSArray* messageArray= [[AppDelegate instance].IndexArticles subarrayWithRange:rangeForView];
        
        NSMutableDictionary* viewDictonary = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [messageArray count]; i++) {
            if (i == 0) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view1"];
            }
            if (i == 1) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view2"];
            }
            if (i == 2) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view3"];
            }
            if (i == 3) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view4"];
            }
            if (i == 4) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view5"];
            }
        }
        
        Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%@",layoutNumber]);
        id layoutObject ;
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            layoutObject= [[class alloc] initWithFrame:portraitSize];
            
            //直立的大小，遇到橫立的要給另一個大小
        }else {
            layoutObject= [[class alloc] initWithFrame:landSpaceSize];
            
        }
        if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
            
            layoutToReturn = (LayoutViewExtention*)layoutObject;
            
            [layoutToReturn initalizeViews:viewDictonary];
            [layoutToReturn rotate:self.interfaceOrientation animation:NO];
            //    while (![layoutToReturn isDidLoadFinsh]) {
            //        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
            //     }
            
            
            layoutToReturn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
    }
    
    [preIndexView setObject:layoutToReturn forKey:[NSString stringWithFormat:@"%i",page]];
    
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
    
        portraitSize=CGRectMake(0, 0, 768, 1024);
        landSpaceSize=CGRectMake(0, 0, 1024, 768);
		isInFullScreenMode = FALSE;
		messageArrayCollection = [NSMutableArray array];
        flipper.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            flipper = [[AFKPageFlipper alloc] initWithFrame:portraitSize];//直立的大小，遇到橫立的要給另一個大小
        }else
        {
            flipper = [[AFKPageFlipper alloc] initWithFrame:landSpaceSize];//直立的大小，遇到橫立的要給另一個大小
        }
   
        [AppDelegate instance].viewController=self;
        if([AppDelegate instance].IndexArticles==nil)
        {
            [AppDelegate instance].IndexArticles= [NSMutableArray array];
        }
        else
        {
            [[AppDelegate instance].IndexArticles removeAllObjects];
            
        }
  //   queue = [NSOperationQueue new];
        parser=[[IndexParser alloc]init];
        parser.delegate=self;
        [parser start];
     

    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (fullScreenView != nil) {
		//[UIView beginAnimations:@"WILLROTATE" context:NULL];
		//[UIView setAnimationDuration:0.50];
		//[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
		if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            [fullScreenView setFrame:CGRectMake(0, 45, 768, 1024-45)];
		}else {
			[fullScreenView setFrame:CGRectMake(0, 45, 1024, 768-45)];
		}
		[fullScreenView rotate:self.interfaceOrientation animation:NO];
		//[UIView setAnimationDelegate:self];
		//[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
		//[UIView commitAnimations];
	}
    
	if ([viewControlerStack count] > 0 && [flipper.subviews count] > 0) {
		
		for (UIView* subview in flipper.subviews) {
			if ([subview isKindOfClass:[LayoutViewExtention class]]) {
				LayoutViewExtention* layoutView = (LayoutViewExtention*)subview;
				[layoutView rotate:self.interfaceOrientation animation:NO];
                
			}
			
		}
		
	}
    [self setToolbarBackgroundImage:self.interfaceOrientation];
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        flipper.frame=portraitSize;//直立的大小，遇到橫立的要給另一個大小
    }else
    {
        flipper .frame=landSpaceSize;//直立的大小，遇到橫立的要給另一個大小
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:
                    [[NSBundle mainBundle]pathForResource:@"COLOR" ofType:@"png"]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
    self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    searchBarItem.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OG_portrait_Header_icon_search"]];
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnSearchClick:)];
    searchBarItem.customView.userInteractionEnabled=YES;
    [searchBarItem.customView addGestureRecognizer:tapRecognizer];
    archiveBarItem.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OG_portrait_Header_icon_list"]];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnArchive:)];
    archiveBarItem.customView.userInteractionEnabled=YES;
    [archiveBarItem.customView addGestureRecognizer:tapRecognizer];
 
    logoutBarItem.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OG_portrait_Header_icon_exit"]];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnLogout:)];
    logoutBarItem.customView.userInteractionEnabled=YES;
    [logoutBarItem.customView addGestureRecognizer:tapRecognizer];
    [self setToolbarBackgroundImage:self.interfaceOrientation];

    [self.view insertSubview:flipper atIndex:0];
    UIStoryboard* storyBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    archiveController= [storyBoard instantiateViewControllerWithIdentifier:@"archiveView"];
    archiveController.view.frame=CGRectMake(0, 45, 768, 958);
    archiveController.view.alpha=0;
    [self.view addSubview:archiveController.view];
    searchView=  [storyBoard instantiateViewControllerWithIdentifier:@"searchView"];
    searchView.view.frame=CGRectMake(0, 45, 768, 958);
    searchView.view.alpha=0;
    [self.view addSubview:searchView.view];
    
	// Do any additional setup after loading the view.
}



- (int)getRandomNumber:(int)from to:(int)to {
	return (int)from + random() % (to-from+1);
}

//計算頁數
//隨機選layout
-(void)buildPages:(NSArray*)messageArray {
	

	viewControlerStack = [[NSMutableArray alloc] init]; 
	int remainingMessageCount = [messageArray count];
    //因為除5會有餘數。1~4分別是可以顯示1~4個 message的 layout。這次的project應該用不到
    while (remainingMessageCount>=3) {
		int randomNumber = [self getRandomNumber:3 to:5];//隨機選layout
        if (remainingMessageCount<=5) {
            randomNumber=remainingMessageCount;
        }
         remainingMessageCount = remainingMessageCount -randomNumber;
		int verNumber=[self getRandomNumber:1 to:2];
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d_%d",randomNumber,verNumber]];    
    }
	if (remainingMessageCount > 0) {
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",remainingMessageCount]];
	}
}

- (IBAction)doXMLParser:(id)sender {
    parser=[[IndexParser alloc]init];
    parser.delegate=self;
    [parser start];

}
#pragma mark -
#pragma mark AFKPageFlipperDataSource

- (NSInteger) numberOfPagesForPageFlipper:(AFKPageFlipper *)pageFlipper {
	return [viewControlerStack count]+2;
}
//如果flipper要view的時候，依其隨機分配到的layout組合，把view長出來回傳出去
- (UIView *) viewForPage:(NSInteger) page inFlipper:(AFKPageFlipper *) pageFlipper {
    UIView* tempView= [preIndexView objectForKey:[NSString stringWithFormat:@"%i",page]];
    tempView.alpha=1;
 
    tempView.hidden=NO;
    if (page!=1 && page !=[viewControlerStack count]+2 ){
        LayoutViewExtention* layoutView=[preIndexView objectForKey:[NSString stringWithFormat:@"%i",page]];
    
    if(    [AppDelegate instance].viewController.interfaceOrientation!=layoutView.currrentInterfaceOrientation) {
        [layoutView rotate:[AppDelegate instance].viewController.interfaceOrientation animation:NO];
    }
    }
  
  

    return tempView;
   /*
    if (page==1 || page==[viewControlerStack count]+2) {
        UIView* view=[[UIView alloc]init];
     
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:
                        [[NSBundle mainBundle]pathForResource:@"flipEND_bg" ofType:@"png"]];
        [view setBackgroundColor:[UIColor colorWithPatternImage:img]];
      
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            [view setFrame:portraitSize];//直立的大小，遇到橫立的要給另一個大小
        }else {
            [view setFrame:landSpaceSize];//直立的大小，遇到橫立的要給另一個大小
        }
        
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        return view;
    }
    UIView* tempView=[[UIView alloc]init];
    [tempView setBackgroundColor:[UIColor blueColor]];
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [tempView setFrame:portraitSize];//直立的大小，遇到橫立的要給另一個大小
    }else {
        [tempView setFrame:landSpaceSize];//直立的大小，遇到橫立的要給另一個大小
    }
    
    tempView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return tempView;
  	LayoutViewExtention* layoutToReturn = nil;
	NSString* layoutNumber = [viewControlerStack objectAtIndex:page-2];
	
	int rangeFrom = 0;
	int rangeTo = 0;
	BOOL shouldContinue = FALSE;
	
    for (int i=0; i<page-2; i++) {
        rangeFrom+=[[[viewControlerStack objectAtIndex:i] substringWithRange:NSMakeRange(0, 1)] intValue];
    }   
    rangeTo=[[[viewControlerStack objectAtIndex:page-2]substringWithRange:NSMakeRange(0, 1)]intValue];
    

	if (page-1<viewControlerStack.count+2) {
        shouldContinue=TRUE;
    }
    
	if (shouldContinue) {
		
		NSRange rangeForView = NSMakeRange(rangeFrom, rangeTo);
		
		NSArray* messageArray= [[AppDelegate instance].IndexArticles subarrayWithRange:rangeForView];
		
		NSMutableDictionary* viewDictonary = [[NSMutableDictionary alloc] init];
				for (int i = 0; i < [messageArray count]; i++) {
			if (i == 0) {
                [viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view1"];
			}
			if (i == 1) {
				[viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view2"];
			}
			if (i == 2) {
				[viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view3"];
			}
			if (i == 3) {
				[viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view4"];
			}
			if (i == 4) {
				[viewDictonary setObject:[messageArray objectAtIndex:i] forKey:@"view5"];
			}
		}
		
		Class class =  NSClassFromString([NSString stringWithFormat:@"Layout%@",layoutNumber]);
		id layoutObject ;
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            layoutObject= [[class alloc] initWithFrame:portraitSize];
            //直立的大小，遇到橫立的要給另一個大小
        }else {
             layoutObject= [[class alloc] initWithFrame:landSpaceSize];
     
        }
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
	
			layoutToReturn = (LayoutViewExtention*)layoutObject;
			
			[layoutToReturn initalizeViews:viewDictonary];
			[layoutToReturn rotate:self.interfaceOrientation animation:NO];
          
			
			layoutToReturn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
					}
	}
	
	return layoutToReturn;
    */
}
-(void)showViewInFullScreen:(UIViewExtention*)viewToShow withModel:(ArticleModel*)model Mode:(NSString*)mode Animated:(BOOL)anim{
	if (!isInFullScreenMode) {
        [self clearView];
		isInFullScreenMode = TRUE;
		
		CGRect bounds = [UIScreen mainScreen].bounds;
		if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
			CGFloat width = bounds.size.width;
			bounds.size.width = bounds.size.height;
			bounds.size.height = width;
		}
		if (searchPopover!=nil && searchPopover.isPopoverVisible) {
            [searchPopover dismissPopoverAnimated:YES];
            searchPopover=nil;
        }
		

		
		
		viewToShowInFullScreen =  viewToShow;
		viewToShowInFullScreen.originalRect = viewToShowInFullScreen.frame;
		viewToShowInFullScreen.isFullScreen = TRUE;
		FlipFullScreenView* fullView = [[FlipFullScreenView alloc] initWithModel:model.articleId withMode:mode];
		fullView.frame = viewToShowInFullScreen.frame;
		fullView.viewToOverLap = viewToShowInFullScreen;
		fullView.fullScreenBG = fullScreenBGView;
       
		fullScreenView = fullView;
		[self.view addSubview:fullView];
		
		[self.view bringSubviewToFront:fullScreenBGView];	
		[self.view bringSubviewToFront:fullView];
		if(anim)
        {
		[UIView beginAnimations:@"SHOWFULLSCREEN" context:NULL];
		[UIView setAnimationDuration:0.40];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
        }
		fullScreenBGView.alpha = 1;
		if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			fullView.frame=CGRectMake(0, 45, 768, 1024-45);
            
		}else {
			fullView.frame=CGRectMake(0, 45, 1024, 768-45);
		}
		[fullScreenView rotate:self.interfaceOrientation animation:YES];
        if(anim)
        {
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
		[UIView commitAnimations];
        }

		
	}
    
	
}

-(void)closeFullScreen {
	if (fullScreenView != nil) {

		fullScreenView.alpha = 0;
		[fullScreenView removeFromSuperview];

		fullScreenView = nil;
		isInFullScreenMode = FALSE;
	}
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
	if (fullScreenView != nil) {
		[UIView beginAnimations:@"WILLROTATE" context:NULL];
		[UIView setAnimationDuration:0.50];
		[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
		if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            [fullScreenView setFrame:CGRectMake(0, 45, 768, 1024-45)];
		}else {
			[fullScreenView setFrame:CGRectMake(0, 45, 1024, 768-45)];
		}
		[fullScreenView rotate:toInterfaceOrientation animation:YES];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
		[UIView commitAnimations];
	}
	   
	if ([viewControlerStack count] > 0 && [flipper.subviews count] > 0) {
		
		for (UIView* subview in flipper.subviews) {
			if ([subview isKindOfClass:[LayoutViewExtention class]]) {
				LayoutViewExtention* layoutView = (LayoutViewExtention*)subview;
				[layoutView rotate:toInterfaceOrientation animation:YES];

			}
			
		}
		
	}
        [self setToolbarBackgroundImage:toInterfaceOrientation];
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        flipper.frame=portraitSize;//直立的大小，遇到橫立的要給另一個大小
    }else
    {
        flipper .frame=landSpaceSize;//直立的大小，遇到橫立的要給另一個大小
    }
}
-(void)setToolbarBackgroundImage:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"portrait_title_45" ofType:@"png"];
        
        [toolbar setBackgroundImage:[UIImage imageWithContentsOfFile:path] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"landscape_title_45" ofType:@"png"];
        
        [toolbar setBackgroundImage:[UIImage imageWithContentsOfFile:path] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        
    }
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {

}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
	if ([animationID isEqualToString:@"WILLROTATE"]) {
		if (fullScreenView != nil) {
			[fullScreenView setBackgroundColor:RGBACOLOR(0,0,0,0.6)];
		}		
	}else if ([animationID isEqualToString:@"FOOTER"]) {
		if (context) {
			((UIView*)CFBridgingRelease(context)).alpha = 1;
		}
	}else if ([animationID isEqualToString:@"SHOWFULLSCREEN"]) {

	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (flipper) {
		return !flipper.animating;
	}
	
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
   
    [self setLblLoading:nil];
    [self setSearchBarItem:nil];
    [self setArchiveBarItem:nil];
    [self setLogoutBarItem:nil];
    [self setToolbar:nil];
    [self setLblHeader:nil];
    [self setIndicator:nil];
    [self setIndicator2:nil];
    [self setAivContentLoading:nil];
    [self setBgImage:nil];
    self.viewControlerStack=nil;
    
    self.gestureRecognizer=nil;
    self.wallTitle=nil;
    self.parser=nil;
    self.articles=nil;
     dispatch_release(semaphore);
    searchView=nil;
    archiveController=nil;
    messageArrayCollection=nil;
    wallTitle=nil;
    fullScreenBGView=nil;
    fullScreenView=nil;
    viewToShowInFullScreen=nil;
    flipper=nil;
    preIndexView=nil;
  
        [super viewDidUnload];
    
}


-(void) generateViews:(NSArray *)currentMesageArray {
	
	int remainingMessageCount = 0;
	int totalMessageCount = [currentMesageArray count];
	int numOfGroup = totalMessageCount /5;
	
	remainingMessageCount = totalMessageCount;
	
	for (int i=1; i<=numOfGroup; i++) {
		remainingMessageCount = totalMessageCount - (i * 5);
		int randomNumber = [self getRandomNumber:5 to:8];
		
		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",randomNumber]];
	}
	
	if (remainingMessageCount > 0) {

		[viewControlerStack addObject:[NSString stringWithFormat:@"%d",remainingMessageCount]];
	}
	
	flipper.numberOfPages = [viewControlerStack count];	
	

}

- (void)dealloc {
   
	[[NSNotificationCenter defaultCenter] removeObserver:self];
 
}
#pragma mark <iTunesRSSParserDelegate> Implementation

- (void)parserDidEndParsingData:(IndexParser *)parser {
   
    /*
    NSMutableIndexSet *discardedItems = [NSMutableIndexSet indexSet];
    
    if ([AppDelegate instance].IndexArticles.count>60) {
        for (int i=61; i<[AppDelegate instance].IndexArticles.count;i++) {
            [discardedItems addIndex:i];
        }
        [[AppDelegate instance].IndexArticles removeObjectsAtIndexes:discardedItems];

    }
     */
  //  NSLog(@"bulid view begin");
    NSLog(@"Begin");
    [self buildPages:[AppDelegate instance].IndexArticles];
    preIndexView=[[NSMutableDictionary alloc]init];
    
    
    for (int page=1; page<=2; page++) {
        [self prepareIndexView:page];
    }
    for (int page=3; page<=[viewControlerStack count]+2; page++) {
        [self prepareIndexView2:page];
    }
    NSLog(@"End");
   // for (int page=3; page<=[viewControlerStack count]+2; page++){
   //     [self prepareIndexView2:page];
   // }
  // NSLog(@"bulid view end");
    flipper.dataSource = self;
    self.parser = nil;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.aivContentLoading stopAnimating];
    [self.lblLoading removeFromSuperview ];
    [self.bgImage removeFromSuperview];
    [UIView commitAnimations];
}

- (void)parser:(IndexParser *)parser didParseIndex:(NSArray *)parsedArticles{
  
    [[AppDelegate instance].IndexArticles addObjectsFromArray:parsedArticles];
   

}

- (void)parser:(IndexParser *)parser didFailWithError:(NSError *)error {

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // make sure it's the right segue if you have more than one in this VC
    if ([segue.identifier isEqualToString:@"showSearch"]) {
        searchPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
        searchPopover.delegate=self;
    }
    else if ([segue.identifier isEqualToString:@"showArchive"]) {
        archivePopover=[(UIStoryboardPopoverSegue *)segue popoverController];
        archivePopover.delegate=self;

    }
    else if([segue.identifier isEqualToString:@"SigleImage"])
    {
        
      PhotoViewController* vc=  segue.destinationViewController;
            vc.currentModel=(ArticleModel*)sender;
        
    }
    
}

- (void)btnSearchClick:(UIGestureRecognizer *)gestureRecognizer {

    [self switchSearchViewAnimated:YES];

}
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController  
{
    if (searchPopover==popoverController) 
    {
    
        searchPopover=nil;
    }
    if (archivePopover==popoverController) 
    {
        
        archivePopover=nil;
    }
}
- (IBAction)btnArchive:(id)sender {
    [self switchArchiveViewAnimated:YES];
}
- (IBAction)btnLogout:(id)sender {
      [self performSegueWithIdentifier:@"Logout" sender:sender];
        
}
-(void )switchArchiveViewAnimated:(BOOL)anim
{
       if (archiveController.view.alpha==1) {

           [self hideArchiveViewAnimate:anim];
        
    }else{
          [self clearView];
        [self showArchiveViewAnimate:anim];
    }
    
 }
-(void)showArchiveViewAnimate:(BOOL)anim
{
    if (archiveController.view.alpha==0) {
        [self.view bringSubviewToFront:archiveController.view];
        [self.view bringSubviewToFront:self.indicator];

        archiveController.view.alpha=1;
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            archiveController.view.frame=CGRectMake(0, 45, 768, 959);
            archiveController.archiveView.frame=CGRectMake(-500, 0, 500, 1024-65);
        }
        else
        {
            archiveController.view.frame=CGRectMake(0, 45, 1024, 768-21-44);
              archiveController.archiveView.frame=CGRectMake(-500, 0, 500, 703);
        }
        

  
    if(anim)
    {
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
    }
      archiveController.archiveView.frame=CGRectMake(0, 0, archiveController.archiveView.frame.size.width, archiveController.archiveView.frame.size.height );
  
          self.indicator.alpha=1;
 
    
    
    if (anim) {
        [UIView commitAnimations];
    }
        
    }
}
-(void)hideArchiveViewAnimate:(BOOL)anim
{
    if (archiveController.view.alpha==1) {

    if(anim)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
   [UIView setAnimationBeginsFromCurrentState:YES];
             
    }
        archiveController.view.alpha=0;
        self.indicator.alpha=0;
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            archiveController.archiveView.frame=CGRectMake(-500, 0, 500, 1024-65);
            
        }
        else
        {
            archiveController.archiveView.frame=CGRectMake(-500, 0, 500, 703);
        }
    if (anim) {
        [UIView commitAnimations];
    }
        
    }
}
-(void )switchSearchViewAnimated:(BOOL)anim
{
    if (searchView.view.alpha==1) {
   
        [self hideSearchViewAnimate:anim];
        
    }else{
          [self clearView];
        [self showSearchViewAnimate:anim];
    }
    
}
-(void)showSearchViewAnimate:(BOOL)anim
{
    if (searchView.view.alpha==0) {
        [self.view bringSubviewToFront:searchView.view];
        [self.view bringSubviewToFront:self.indicator2];
          searchView.view.alpha=1;
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            searchView.view.frame=CGRectMake(0, 45, 768, 959);
            searchView.searchView.frame=CGRectMake(-500, 0, 500, 1024-65);
        }
        else
        {
            searchView.view.frame=CGRectMake(0, 45, 1024, 768-21-44);
            searchView.searchView.frame=CGRectMake(-500, 0, 500, 703);
        }
        
        if(anim)
        {
             [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
           
        }
        
      
        self.indicator2.alpha=1;
            searchView.searchView.frame=CGRectMake(0, 0,  searchView.searchView.frame.size.width,  searchView.searchView.frame.size.height );
        [searchView.searchBar becomeFirstResponder];

  
        
        
        if (anim) {
            [UIView commitAnimations];
        }
        
    }
}
-(void)hideSearchViewAnimate:(BOOL)anim
{
    if (searchView.view.alpha==1) {
        
        if(anim)
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationBeginsFromCurrentState:YES];
            
        }
        searchView.view.alpha=0;
        self.indicator2.alpha=0;
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            searchView.searchView.frame=CGRectMake(-500, 0, 500, 1024-65);
            
        }
        else
        {
           searchView.searchView.frame=CGRectMake(-500, 0, 500, 703);
        }           [searchView.searchBar resignFirstResponder];
        if (anim) {
            [UIView commitAnimations];
        }
        
    }
}
-(void)clearView
{
    [self hideArchiveViewAnimate:NO];
    [self hideSearchViewAnimate:NO];
}
@end
