//
//  FlipFullScreenView.m
//  OGRU_DEV
//
//  Created by Yup on 2012-08-16.
//
//

#import "FlipFullScreenView.h"

@implementation FlipFullScreenView
@synthesize messageModel,viewToOverLap,fullScreenBG,mode;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithModel:(NSString*)model withMode:(NSString*)m{
	if (self = [super init]) {
        self.mode=m;
        if ([AppDelegate instance].viewController.interfaceOrientation== UIInterfaceOrientationPortrait || [AppDelegate instance].viewController.interfaceOrientation== UIInterfaceOrientationPortraitUpsideDown) {
            flipper = [[AFKPageFlipper alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];//直立的大小，遇到橫立的要給另一個大小
        }else {
            flipper = [[AFKPageFlipper alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];//直立的大小，遇到橫立的要給另一個大小
        }
        flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
       
        if ([self.mode isEqualToString:@"index"]) {
            flipper.currentPage= [  [AppDelegate instance].IndexArticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [[obj articleId]isEqualToString:model];
                
            }]+1;
        }
        else if([self.mode isEqualToString:@"search"])
        {
            flipper.currentPage= [  [AppDelegate instance].SearchArticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [[obj articleId]isEqualToString:model];
                
            }]+1;
        }
        else if([self.mode isEqualToString:@"archive"])
        {
            flipper.currentPage= [  [AppDelegate instance].Archiverticles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [[obj articleId]isEqualToString:model];
                
            }]+1;
        }
        [flipper setDataSource:self WithPage:flipper.currentPage+1];
        [self     addSubview:flipper];
    }
    return self;
}

- (NSInteger) numberOfPagesForPageFlipper:(AFKPageFlipper *)pageFlipper {
    // while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
    //     [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    //  }
    if ([self.mode isEqualToString:@"index"]) {
       return [AppDelegate instance].IndexArticles.count+2;
    }
    else if([self.mode isEqualToString:@"search"])
    {
       return [AppDelegate instance].SearchArticles.count+2;    }
    else 
    {
      return [AppDelegate instance].Archiverticles.count+2;
    }

	
}
//如果flipper要view的時候，依其隨機分配到的layout組合，把view長出來回傳出去
- (UIView *) viewForPage:(NSInteger) page inFlipper:(AFKPageFlipper *) pageFlipper {
    NSInteger count;
    NSString* articleid=nil;
    if ([mode isEqualToString:@"index"]) {
        //articleid=[[[AppDelegate instance].IndexArticles objectAtIndex:page-2] articleId];
        count=[AppDelegate instance].IndexArticles.count;
    }
    else if([mode isEqualToString:@"search"])
    {
        //articleid=[[[AppDelegate instance].SearchArticles objectAtIndex:page-2] articleId];
          count=[AppDelegate instance].SearchArticles.count;
    }
    else// if([mode isEqualToString:@"archive"])
    {
       // articleid=[[[AppDelegate instance].Archiverticles objectAtIndex:page-2] articleId];
          count=[AppDelegate instance].Archiverticles.count;
    }
    if (page==1 || page== count+2) {
        UIView* view=[[UIView alloc]init];
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:
                        [[NSBundle mainBundle]pathForResource:@"flipEND_bg" ofType:@"png"]];
        [view setBackgroundColor:[UIColor colorWithPatternImage:img]];
   //     [img release];
        if ([AppDelegate instance].viewController.interfaceOrientation == UIInterfaceOrientationPortrait || [AppDelegate instance].viewController.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            [view setFrame:CGRectMake(0, 0, 768, 1024)];//直立的大小，遇到橫立的要給另一個大小
        }else {
            [view setFrame:CGRectMake(0, 0, 1024, 768)];//直立的大小，遇到橫立的要給另一個大小
        }
        
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        return view ;
    }
    if ([mode isEqualToString:@"index"]) {
        articleid=[[[AppDelegate instance].IndexArticles objectAtIndex:page-2] articleId];
        //count=[AppDelegate instance].IndexArticles.count;
    }
    else if([mode isEqualToString:@"search"])
    {
        articleid=[[[AppDelegate instance].SearchArticles objectAtIndex:page-2] articleId];
        //count=[AppDelegate instance].SearchArticles.count;
    }
    else if([mode isEqualToString:@"archive"])
    {
        articleid=[[[AppDelegate instance].Archiverticles objectAtIndex:page-2] articleId];
       // count=[AppDelegate instance].Archiverticles.count;
    }
    FullScreenView*  fsv=[[FullScreenView alloc]initWithModel:articleid];
    if (articleid!=nil) {
      
         articleid=nil;
    }
   
    [fsv showFields];
    if([AppDelegate instance].viewController.interfaceOrientation==UIInterfaceOrientationPortrait ||[AppDelegate instance].viewController.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
    fsv.frame=CGRectMake(0, 0, 768, 1024-45);
    }
    else
    {
         fsv.frame=CGRectMake(0, 0, 1024, 768-45);
    }
    return fsv ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)reAdjustLayout {
	for (UIView* subview in flipper.subviews) {
        if ([subview isKindOfClass:[FullScreenView class]]) {
            FullScreenView* layoutView = (FullScreenView*)subview;
            [layoutView rotate:currrentInterfaceOrientation animation:YES];
			//	layoutView.footerView.alpha = 0;
            //[UIView beginAnimations:nil context:NULL];
            //[UIView setAnimationDuration:0.10];
			//	if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            //	[layoutView.footerView setFrame:CGRectMake(0, 1004 - 20, 768, layoutView.footerView.frame.size.height)];
            //}else {
            //	[layoutView.footerView setFrame:CGRectMake(0, 748 - 20, 1024, layoutView.footerView.frame.size.height)];
            //}
            //[layoutView.footerView rotate:toInterfaceOrientation animation:YES];
            //[layoutView.headerView rotate:toInterfaceOrientation animation:YES];
            //[UIView commitAnimations];
        }
        
    }

}
- (void)dealloc
{
       mode=nil;
  
    flipper=nil;
    messageModel=nil;
    viewToOverLap=nil;
    fullScreenBG=nil;

}
@end
