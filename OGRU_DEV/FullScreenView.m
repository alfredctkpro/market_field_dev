/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  FullScreenView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5
//
#import "FullScreenView.h"
#import "ArticleModel.h"
#import "ImageScrollView.h"

@implementation FullScreenView
{
    UILabel* lblLoading;
    UIActivityIndicatorView* aivLoading;
    UIImageView* bgLoading;
    UIImageView* arrow;
    NSOperationQueue *queue;
    NSOperationQueue *mainQueue;
}
@synthesize messageModel,viewToOverLap,fullScreenBG,mode;
- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [imageScrollView subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[ImageScrollView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, frame.origin.y);
			view.frame = frame;
			if (currrentInterfaceOrientation==UIInterfaceOrientationPortrait ||currrentInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
                curXLoc += (600);
            }
			else
            {
                 curXLoc += (468);
            }
		}
	}
	
	// set the content size so it can be scrollable
	[imageScrollView setContentSize:CGSizeMake(( curXLoc), [imageScrollView bounds].size.height)];
  
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(  [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue]<=webView.frame.size.height)
    {
        [arrow removeFromSuperview];
    };
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if(navigationType ==  UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:request.URL];
		return NO;
	}
	else
		return YES;
}

-(id)initWithModel:(NSString*)model {
	if (self = [super init]) {
        
		messageModel = model;
        pageControl.currentPage=0;
        
		[self setBackgroundColor:[UIColor whiteColor]];
		
		contentView = [[UIView alloc] init];
		[contentView setBackgroundColor:[UIColor whiteColor]];
		
        bgLoading=[[UIImageView alloc]initWithFrame:contentView.frame];
        //UIImage *img = [[UIImage alloc]initWithContentsOfFile:
        //                [[NSBundle mainBundle]pathForResource:@"COLOR" ofType:@"png"]];
        bgLoading.image=[UIImage imageNamed:@"COLOR.png"];
      //  [img release];
        bgLoading.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [contentView addSubview:bgLoading];
        
        lblLoading=[[UILabel alloc]init];
        lblLoading.text=@"   Fetching Content...";
        lblLoading.backgroundColor=[UIColor clearColor];
        [lblLoading sizeToFit];
     
        [contentView addSubview:lblLoading];

        aivLoading=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(379, 519, 20, 20)];
        aivLoading.hidesWhenStopped=YES;
        aivLoading.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
        [aivLoading startAnimating];
        [contentView addSubview:aivLoading];
        
		
		userNameLabel = [[UILabel alloc] init];
		userNameLabel.font =[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24];
		[userNameLabel setTextColor:RGBCOLOR(51,51,51)];
		[userNameLabel setBackgroundColor:[UIColor clearColor]];
		//[userNameLabel setText:[NSString stringWithFormat:@"%@",messageModel.title]];
		[userNameLabel setFrame:CGRectMake(84, 480, 0, 0)];
		[contentView addSubview:userNameLabel];
	
		timeStampLabel = [[UILabel alloc] init];
	//	[timeStampLabel setText:messageModel.date];
		timeStampLabel.font =[UIFont fontWithName:@"HelveticaNeue" size:14];

		[timeStampLabel setTextColor:[[AppDelegate instance] getThemeColor]];
    
		[timeStampLabel setBackgroundColor:[UIColor clearColor]];
		[timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y, 0, 0)];
		timeStampLabel.alpha = 0;
		[contentView addSubview:timeStampLabel];
		
		//scrollView = [[UIScrollView alloc] init];
		//[scrollView setBackgroundColor:[UIColor clearColor]];
		//[scrollView setFrame:CGRectMake(85, 555 , 600, 360)];
		//[contentView addSubview:scrollView];
		//textLayer=[[CATextLayer alloc]init];
		messageLabel = [[UIWebView alloc] init];
        messageLabel.delegate=self;
        messageLabel.opaque = NO;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.frame=CGRectMake(85, 555 , 600, 360);
        messageLabel.scrollView.delegate=self;
       // messageLabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:16];
	//	textLayer.wrapped=YES   ;
		//textLayer.font = CFBridgingRetain([UIFont fontWithName:@"HelveticaNeue-Light" size:16].fontName);
      //  textLayer.fontSize=16;
	//	textLayer.foregroundColor = [UIColor blackColor].CGColor;
      //  textLayer.backgroundColor=[UIColor whiteColor].CGColor;
     //    textLayer.alignmentMode=kCAAlignmentJustified;
    
 //      [messageLabel.layer addSublayer:textLayer];
		//messageLabel.highlightedTextColor = RGBCOLOR(33,33,33);
				//messageLabel.alpha = 0;
    //    messageLabel.numberOfLines=0;
		[contentView addSubview:messageLabel];
		
		
		closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImageView* closeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OG_portrait_Header_icon_back.png"]];
		[closeImage setFrame:CGRectMake(0, 0, 46, 52)];
		[closeButton addSubview:closeImage];
		//[closeImage release];
		[closeButton addTarget:self action:@selector(closeFullScreenView:) forControlEvents:UIControlEventTouchUpInside];
		[closeButton sizeToFit];
		closeButton.alpha = 0;
		[contentView addSubview:closeButton];
		 

      
		//[contentView addSubview:nextButton];
  
        
      //  [contentView addSubview:prevButton];
		[self addSubview:contentView];
        
        pageControl=[[OGRUPageControl alloc]init];
        pageControl.hidesForSinglePage=YES;
       
        [pageControl setFrame:CGRectMake(0, 41+400+10, pageControl.frame.size.width, pageControl.frame.size.height)];
        [pageControl sizeToFit];
        [contentView addSubview:pageControl];
        // load all the images from our bundle and add them to the scroll view
    
        //NSString* arrowPath=[[NSBundle mainBundle]pathForResource:@"arrow" ofType:@"png"];
        
        //UIImage* arrowImage=[[UIImage alloc]initWithContentsOfFile:arrowPath];
        arrow=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
        [contentView addSubview:arrow];
        arrow.alpha=0;
        
        parser=[[ArticleParser alloc]init ];
        parser.delegate=self;
        queue= [NSOperationQueue new];
    
        mainQueue=[NSOperationQueue mainQueue];
        
        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadContent)
                                            object:nil];
        [queue addOperation:operation];
        
       
         

	}
	return self;
}
-(void)loadContent
{

    [parser startWithArticleID:messageModel];
}

- (void)reAdjustLayout{
	
    if (currrentInterfaceOrientation==0) {
        currrentInterfaceOrientation=[AppDelegate instance].viewController.interfaceOrientation;
    }
  
		//[userImageView setFrame:CGRectMake(10, 10, 130, 130)];
      if(currrentInterfaceOrientation==UIInterfaceOrientationPortrait||currrentInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
      {
          [contentView setFrame:CGRectMake(0, 0, 768, 1024-45)];
                  
          if (lblLoading.superview!=nil) {
           
              lblLoading.center=contentView.center;
              
              aivLoading.center=contentView.center;
              aivLoading.frame=CGRectMake(aivLoading.frame.origin.x,aivLoading.frame.origin.y+lblLoading.frame.size.height,aivLoading.frame.size.height,aivLoading.frame.size.height);
          }
          
          CGSize contentViewArea = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
		[userNameLabel sizeToFit];
          if (detailModel.images.count>0) {

              [userNameLabel setFrame:CGRectMake(84, 480, userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
          }
          else{
               [userNameLabel setFrame:CGRectMake(84, 41, userNameLabel.frame.size.width, userNameLabel.frame.size.height)];
          }
		[timeStampLabel sizeToFit];
		[timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+10, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];

		[closeButton setFrame:CGRectMake(0, 0, 46, 52)];

		[messageLabel setFrame:CGRectMake(85, timeStampLabel.frame.origin.y   +timeStampLabel.frame.size.height+10, 600, contentViewArea.height-45-timeStampLabel.frame.origin.y -timeStampLabel.frame.size.height-14)];
          if (detailModel) {
              
          
          NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                        @"<br/><br/>" options:0 error:nil];
          NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:
                                         @"<br/>" options:0 error:nil];
          NSMutableString *str = [NSMutableString stringWithString:
                                  detailModel.content];
          [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"<br><br>"];
          [regex2 replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
          NSString *css = [NSString stringWithFormat:
                           @"<html><head><style>body { background-color: trasparent; text-align: %@; font-size: %ipx; color: black;font-family:HelveticaNeue-Light;margin: 0px 0px 0px 0px;} a { color: gray; } </style></head><body>",
                           @"justify",
                           16];
          
          NSMutableString *desc = [NSMutableString stringWithFormat:@"%@%@%@",
                                   css,
                                   str,
                                   
                                   @"</body></html>"];
          
          
          [messageLabel loadHTMLString:desc baseURL:nil];
    
              arrow.frame=CGRectMake((768-21)/2, 1024-45-26-20,21, 26);
              arrow.alpha=1;

          }
          //[messageLabel sizeToFit];
		///////////////////////////////////////////////////////////////
		//[messageLabel setText:messageModel.content];
		//messageLabel.numberOfLines = 0;
		//[messageLabel sizeToFit];
        
	

                   
          if (imageScrollView!=nil) {
              [imageScrollView removeFromSuperview];
            
            //  [imageScrollView release];
              imageScrollView=nil;
          }
          //if (imageScrollView==nil) {
          if (detailModel.images.count>0) {
              imageScrollView=[[UIScrollView alloc]init];
              
              [imageScrollView setFrame:CGRectMake(84, 41, 600, 400)];
              aiv=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
              
              aiv.hidesWhenStopped=YES;
              aiv.frame=imageScrollView.frame;
              [aiv startAnimating];
              [contentView addSubview:imageScrollView];
              [contentView addSubview:aiv];
              [imageScrollView setBackgroundColor:[UIColor blackColor]];
              [imageScrollView setCanCancelContentTouches:NO];
              imageScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
              imageScrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
              imageScrollView.scrollEnabled = YES;
              imageScrollView.userInteractionEnabled=YES;
              // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
              // if you want free-flowing scroll, don't set this property.
              imageScrollView.pagingEnabled = YES;
             // pageControl.currentPage=0;
              imageScrollView.delegate=self;
              [pageControl setFrame:CGRectMake(0,imageScrollView.frame.origin.y  +imageScrollView.frame.size.height+ 10, pageControl.frame.size.width, pageControl.frame.size.height)];
              //dispatch_async(dispatch_get_main_queue(), ^{
             //   [self portraitLoadImage];
             // });
          
              NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                                  initWithTarget:self
                                                  selector:@selector(portraitLoadImage)
                                                  object:nil];
              
              [queue addOperation:operation];
              //[self portraitLoadImage];
                   }
          
          
      }
    else
    {
        [contentView setFrame:CGRectMake(0, 0, 1024, 768-45)];
        if (lblLoading.superview!=nil) {
            lblLoading.center=contentView.center;
            
            aivLoading.center=contentView.center;
            aivLoading.frame=CGRectMake(aivLoading.frame.origin.x,aivLoading.frame.origin.y+lblLoading.frame.size.height,aivLoading.frame.size.height,aivLoading.frame.size.height);
        }
        CGSize contentViewArea = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
        [userNameLabel sizeToFit];
        if (detailModel.images.count>0) {
            
           [userNameLabel setFrame:CGRectMake(0, 380, contentViewArea.width, userNameLabel.frame.size.height)];
        }
        else{
           [userNameLabel setFrame:CGRectMake(0, 30, contentViewArea.width, userNameLabel.frame.size.height)];
        }

		
        userNameLabel.textAlignment=NSTextAlignmentCenter;
		[timeStampLabel sizeToFit];
		[timeStampLabel setFrame:CGRectMake(0, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, contentViewArea.width, timeStampLabel.frame.size.height)];
         timeStampLabel.textAlignment=NSTextAlignmentCenter;
        
		[closeButton setFrame:CGRectMake(0, 0, 46, 52)];

		
        [messageLabel setFrame:CGRectMake(152, timeStampLabel.frame.origin.y   +timeStampLabel.frame.size.height+10, 720, contentViewArea.height-45-timeStampLabel.frame.origin.y -timeStampLabel.frame.size.height-14)];
        if (detailModel) {
            
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                      @"<br/><br/>" options:0 error:nil];
        NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:
                                       @"<br/>" options:0 error:nil];
        NSMutableString *str = [NSMutableString stringWithString:
                                detailModel.content];
        [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"<br><br>"];
        [regex2 replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
        NSString *css = [NSString stringWithFormat:
                         @"<html><head><style>body { background-color: trasparent; text-align: %@; font-size: %ipx; color: black;font-family:HelveticaNeue-Light} a { color: gray; } </style></head><body>",
                         @"justify",
                         16];
        
        NSMutableString *desc = [NSMutableString stringWithFormat:@"%@%@%@",
                                 css,
                                 str,
                                 
                                 @"</body></html>"];
        
        
        [messageLabel loadHTMLString:desc baseURL:nil];
    

            arrow.frame=CGRectMake((1024-21)/2, 768-45-26-20,21, 26);
            arrow.alpha=1;

        }
		///////////////////////////////////////////////////////////////
		//[messageLabel setText:messageModel.content];
	//	messageLabel.numberOfLines = 0;
		//messageLabel.backgroundColor=RGBACOLOR(0, 245, 184,0.8);
		//[messageLabel setFrame:CGRectMake(0, 0, 720,messageLabel.frame.size.height)];
       // [messageLabel sizeToFit];
	//	[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, messageLabel.frame.origin.y + messageLabel.frame.size.height)];
       // [scrollView sizeToFit];
     

        if (imageScrollView!=nil) {
            [imageScrollView removeFromSuperview];
       //     [imageScrollView release];
            imageScrollView=nil;
        }
            if (detailModel.images.count>0) {
                //if (imageScrollView==nil) {
                imageScrollView=[[UIScrollView alloc]init];
                
                [imageScrollView setFrame:CGRectMake(275, 30, 468, 306)];
                aiv=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                
                aiv.hidesWhenStopped=YES;
                aiv.frame=imageScrollView.frame;
                [aiv startAnimating];
                
                [contentView addSubview:imageScrollView];
                [contentView addSubview:aiv];
                [imageScrollView setBackgroundColor:[UIColor blackColor]];
                [imageScrollView setCanCancelContentTouches:NO];
                imageScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
                imageScrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
                imageScrollView.scrollEnabled = YES;
                imageScrollView.userInteractionEnabled=YES;
                // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
                // if you want free-flowing scroll, don't set this property.
                imageScrollView.pagingEnabled = YES;
                imageScrollView.delegate=self;
                [pageControl setFrame:CGRectMake(0,imageScrollView.frame.origin.y  +imageScrollView.frame.size.height+ 10, pageControl.frame.size.width, pageControl.frame.size.height)];
           //     [self    landSpaceLoadImage];
           
                NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                                    initWithTarget:self
                                                    selector:@selector(landSpaceLoadImage)
                                                    object:nil];
                [queue addOperation:operation];
            }

    }
}


-(void)closeFullScreenView:(id)sender {
    [queue cancelAllOperations];
    [mainQueue cancelAllOperations];
    if (viewToOverLap!=nil) {
        viewToOverLap.alpha = 1;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [sender removeFromSuperview];
        [UIView beginAnimations:@"CLOSEFULLSCREEN" context:NULL];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:YES];
        [self setFrame:viewToOverLap.originalRect];
        fullScreenBG.alpha = 0;
        for (UIView* subview in [self subviews]) {
            subview.alpha = 0;
        }
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
        [UIView commitAnimations];
    }
    else
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [sender removeFromSuperview];
        [UIView beginAnimations:@"CLOSEFULLSCREEN" context:NULL];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:YES];
       
        fullScreenBG.alpha = 0;
        for (UIView* subview in [self subviews]) {
            subview.alpha = 0;
        }
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
        [UIView commitAnimations];
    }
}
-(void)landSpaceLoadImage
{
      for (int i = 0; i < detailModel.images.count; i++)
    {
        
        
        
        UIImage* image =[[AppDelegate instance]imageWithURL:[detailModel.images objectAtIndex:i]];
        ImageScrollView *imageView = [[ImageScrollView alloc] init];
        imageView.userInteractionEnabled=YES;
        // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
        CGRect rect = imageView.frame;
        imageView.index=i;
        rect.size.height = imageScrollView.frame.size.height;
        rect.size.width = imageScrollView.frame.size.width;
        rect.origin.x=rect.size.width*i;
        imageView.frame = rect;
        imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [imageView displayImage:image];

        imageView.tag = i+1;	// tag our images for later use when we place them in serial fashion
        // add gesture recognizers to the image view
        //  UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        //   UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        
        [doubleTap setNumberOfTapsRequired:1];
        // [twoFingerTap setNumberOfTouchesRequired:2];
        
        //[imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        // [imageView addGestureRecognizer:twoFingerTap];
        
        // [singleTap release];
        //    [doubleTap release];
        // [twoFingerTap release];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [imageScrollView addSubview:imageView];
          [imageView layoutSubviews];
        //   [imageView release];
    }

   [mainQueue addOperationWithBlock:^{
       [aiv stopAnimating];
       [aiv removeFromSuperview];
       aiv=nil;
       
       [self layoutScrollImages];
       [imageScrollView setContentOffset:CGPointMake(468*pageControl.currentPage, imageScrollView.contentOffset.y)];
   }];
 

}

-(void)portraitLoadImage
{
  
    
    for (int i = 0; i < detailModel.images.count; i++)
    {
        
        
        UIImage* image =[[AppDelegate instance]imageWithURL:[detailModel.images objectAtIndex:i]];
        ImageScrollView *imageView = [[ImageScrollView alloc] init];
        imageView.userInteractionEnabled=YES;
        // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
        CGRect rect = imageView.frame;
        imageView.index=i;
        rect.size.height = imageScrollView.frame.size.height;
        rect.size.width = imageScrollView.frame.size.width;
        rect.origin.x=rect.size.width*i;
 
        imageView.frame = rect;

        imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [imageView displayImage:image];
    
        imageView.tag = i+1;	// tag our images for later use when we place them in serial fashion
        // add gesture recognizers to the image view
        //  UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        //   UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        
        [doubleTap setNumberOfTapsRequired:1];
        // [twoFingerTap setNumberOfTouchesRequired:2];
        
        //[imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        // [imageView addGestureRecognizer:twoFingerTap];
        
        // [singleTap release];
        //    [doubleTap release];
        // [twoFingerTap release];
        imageView.contentMode=UIViewContentModeScaleAspectFit;

 [imageScrollView addSubview:imageView];
        [imageView layoutSubviews];

        
        //  [imageView release];
    }
  [mainQueue addOperationWithBlock:^{
      [aiv stopAnimating];
      [aiv removeFromSuperview];
      aiv=nil;
      
      [self layoutScrollImages];
      [imageScrollView setContentOffset:CGPointMake(600*pageControl.currentPage, imageScrollView.contentOffset.y)];

  }];
   
}
-(void)nextFullScreenView:(id)sender
{
    if ([mode isEqualToString:@"index"]) {
     
        NSInteger index= [  [AppDelegate instance].IndexArticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj articleId]isEqualToString:self.messageModel];
          
        }];
        index++;
        self.messageModel=[[[AppDelegate instance].IndexArticles objectAtIndex:index]articleId];
         [parser startWithArticleID:[[[AppDelegate instance].IndexArticles objectAtIndex:index] articleId]];
    }
    else if([mode isEqualToString:@"search"])
    {
        NSInteger index= [  [AppDelegate instance].SearchArticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj articleId]isEqualToString:self.messageModel];
            
        }];
        index++;
        self.messageModel=[[[AppDelegate instance].SearchArticles objectAtIndex:index]articleId];
        [parser startWithArticleID:[[[AppDelegate instance].SearchArticles objectAtIndex:index] articleId]];
    }
    else if([mode isEqualToString:@"archive"])
    {
        NSInteger index= [  [AppDelegate instance].Archiverticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj articleId]isEqualToString:self.messageModel];
            
        }];
        index++;
        self.messageModel=[[[AppDelegate instance].Archiverticles objectAtIndex:index]articleId];
        [parser startWithArticleID:[[[AppDelegate instance].Archiverticles objectAtIndex:index] articleId]];
    }
    
}
-(void)prevFullScreenView:(id)sender
{
    if ([mode isEqualToString:@"index"]) {
        NSInteger index= [  [AppDelegate instance].IndexArticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
           return [[obj articleId]isEqualToString:self.messageModel];
        }];
        index--;
        self.messageModel=[[[AppDelegate instance].IndexArticles objectAtIndex:index]articleId];
        [parser startWithArticleID:[[[AppDelegate instance].IndexArticles objectAtIndex:index] articleId]];
    }
    else if([mode isEqualToString:@"search"])
    {
        NSInteger index= [  [AppDelegate instance].SearchArticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj articleId]isEqualToString:self.messageModel];
            
        }];
        index--;
        self.messageModel=[[[AppDelegate instance].SearchArticles objectAtIndex:index]articleId];
        [parser startWithArticleID:[[[AppDelegate instance].SearchArticles objectAtIndex:index] articleId]];
    }
    else if([mode isEqualToString:@"archive"])
    {
        NSInteger index= [  [AppDelegate instance].Archiverticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj articleId]isEqualToString:self.messageModel];
            
        }];
        index--;
        self.messageModel=[[[AppDelegate instance].Archiverticles objectAtIndex:index]articleId];
        [parser startWithArticleID:[[[AppDelegate instance].Archiverticles objectAtIndex:index] articleId]];
    }
    
}
- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
   if ([animationID isEqualToString:@"CLOSEFULLSCREEN"]) {
	   self.alpha = 0;
	   [self removeFromSuperview];
	   [[AppDelegate instance] closeFullScreen];
   }
}

-(void)showFields {
	[self reAdjustLayout]; // i just need this dont know why ... but will look at this later and fix it 
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.20];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
	timeStampLabel.alpha = 1;
	closeButton.alpha = 1;
	messageLabel.alpha = 1;
    
   
    
   
	[UIView commitAnimations];
}


-(void) dealloc {
      nextButton=nil;
    arrow=nil;
	closeButton=nil;

	userImageView=nil;

	userNameLabel=nil;

	timeStampLabel=nil;

	messageLabel=nil;

	scrollView=nil;

	contentView=nil;
    parser.delegate=nil;

    parser=nil;

    mode=nil;

    imageScrollView=nil;

    pageControl=nil;

    lblLoading=nil;
    aivLoading=nil;
    bgLoading=nil;
    messageModel=nil;
    viewToOverLap=nil;
    fullScreenBG=nil;

}

-(void)scrollViewDidScroll:(UIScrollView *)theScrollView
{
    if (theScrollView==imageScrollView) {
        CGFloat pageWidth = imageScrollView.frame.size.width;
        int page = floor((imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
    }
    else if(theScrollView==messageLabel.scrollView)
    {
        [arrow removeFromSuperview];
    }

}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
#pragma mark <iTunesRSSParserDelegate> Implementation

- (void)parserDidEndParsingData:(IndexParser *)parser {



  
   
    //dispatch_semaphore_signal(semaphore);
}
-(void)displayContent:(NSArray *)parsedArticles
{
    
    [lblLoading removeFromSuperview];
    [aivLoading stopAnimating];
    [aivLoading removeFromSuperview];
    [bgLoading removeFromSuperview   ];
    
    if (parsedArticles.count>0) {
        
        detailModel=[parsedArticles objectAtIndex:0];
        pageControl.numberOfPages=detailModel.images.count;
        pageControl.currentPage=0;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                      @"<br/><br/>" options:0 error:nil];
        NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:
                                      @"<br/>" options:0 error:nil];
        NSMutableString *str = [NSMutableString stringWithString:
                                detailModel.content];
        [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"<br><br>"];
         [regex2 replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
        NSString *css = [NSString stringWithFormat:
                         @"<html><head><style>body { background-color: trasparent; text-align: %@; font-size: %ipx; color: black;font-family:HelveticaNeue-Light;} a { color: gray; } </style></head><body>",
                         @"justify",
                         16];
        
        NSMutableString *desc = [NSMutableString stringWithFormat:@"%@%@%@",
                                 css,
                                 str,
                               
                                 @"</body></html>"];
        
     [mainQueue addOperationWithBlock:^{
         [messageLabel loadHTMLString:desc baseURL:nil];
         // messageLabel.text=str;
         userNameLabel.text=detailModel.title;
         timeStampLabel.text=detailModel.date;
     }];
       
        
    }
    
    [mainQueue addOperationWithBlock:^{
        [self reAdjustLayout];
    }];

   
    

}
- (void)parser:(IndexParser *)parser didParseIndex:(NSArray *)parsedArticles{

    NSArray* myArray=[[NSArray alloc]initWithArray:parsedArticles];
    [self displayContent:myArray];
    //  [songs addObjectsFromArray:parsedSongs];
    // Three scroll view properties are checked to keep the user interface smooth during parse. When new objects are delivered by the parser, the table view is reloaded to display them. If the table is reloaded while the user is scrolling, this can result in eratic behavior. dragging, tracking, and decelerating can be checked for this purpose. When the parser finishes, reloadData will be called in parserDidEndParsingData:, guaranteeing that all data will ultimately be displayed even if reloadData is not called in this method because of user interaction.
    //if (!self.tableView.dragging && !self.tableView.tracking && !self.tableView.decelerating) {
    //  self.title = [NSString stringWithFormat:NSLocalizedString(@"Top %d Songs", @"Top Songs format"), [songs count]];
    //[self.tableView reloadData];
    //}
}

- (void)parser:(IndexParser *)parser didFailWithError:(NSError *)error {
   


    // handle errors as appropriate to your application...
    // dispatch_semaphore_signal(semaphore);
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {

    NSArray* arr=[[NSArray alloc]initWithObjects:detailModel,[NSNumber numberWithInteger: pageControl.currentPage], nil];
    
    [[self viewController]performSegueWithIdentifier:@"SigleImage" sender:arr];
          
}


#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
@end
