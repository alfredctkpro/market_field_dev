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
//  Layout7.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "Layout5_1.h"
#import "UIViewExtention.h"
#import "TitleAndTextView.h"
@implementation Layout5_1

@synthesize view1;
@synthesize view2;
@synthesize view3;
@synthesize view4;
@synthesize view5;

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary{
    
    view1=[[TitleAndTextView alloc] initWithMessageModel:(ArticleModel*)[viewCollectionDictonary objectForKey:@"view1"] WithName:@"5_1_1"] ;
    view2=[[TitleAndTextView alloc] initWithMessageModel:(ArticleModel*)[viewCollectionDictonary objectForKey:@"view2"] WithName:@"5_1_2"] ;
    view3=[[TitleAndTextView alloc] initWithMessageModel:(ArticleModel*)[viewCollectionDictonary objectForKey:@"view3"] WithName:@"5_1_3"] ;
    view4=[[TitleAndTextView alloc] initWithMessageModel:(ArticleModel*)[viewCollectionDictonary objectForKey:@"view4"] WithName:@"5_1_4"];
    view5=[[TitleAndTextView alloc] initWithMessageModel:(ArticleModel*)[viewCollectionDictonary objectForKey:@"view5"]WithName:@"5_1_5"] ;
    waitFinshViewCount=5;
    view1.delegate=self;
    view2.delegate=self;
	view3.delegate=self;
    view4.delegate=self;
    view5.delegate=self;
    

    
    

	self.backgroundColor=[UIColor whiteColor];
		[self addSubview:view1];
		[self addSubview:view2];
		[self addSubview:view3];
		[self addSubview:view4];
		[self addSubview:view5];
    borderLeftTop=[[UIView alloc]init];
    borderLeftTop.backgroundColor=[UIColor whiteColor];
    borderLeftTop.userInteractionEnabled=NO;
    borderLeftTop2=[[UIView alloc]init];
    borderLeftTop2.backgroundColor=[UIColor whiteColor];
    borderLeftTop2.userInteractionEnabled=NO;
    borderRightTop=[[UIView alloc]init];
    borderRightTop.backgroundColor=[UIColor whiteColor];
    borderRightTop.userInteractionEnabled=NO;
    borderLeftBottom=[[UIView alloc]init];
    borderLeftBottom.backgroundColor=[UIColor whiteColor];
    borderLeftBottom.userInteractionEnabled=NO;
    
    [self  addSubview:borderLeftTop  ];
    [self  addSubview:borderLeftTop2  ];
    [self  addSubview:borderRightTop  ];
    [self  addSubview:borderLeftBottom  ];

}


-(void)rotate:(UIInterfaceOrientation)orientation animation:(BOOL)animation {

currrentInterfaceOrientation = orientation;
  
	for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			if (self.isFullScreen) {
				if (!((UIViewExtention*)myview).isFullScreen) {
					[((UIViewExtention*)myview) setAlpha:0];
				}
			}else {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
	}
	
	if (animation) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.50];
	}
	
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.image=[UIImage imageNamed:@"P_5_1.png"];
		if (view1 != nil) {
			//v1
			[view1 setFrame:CGRectMake(0, 45, 768,479)];
     
          //  [view1 reAdjustLayout];
			[view2 setFrame:CGRectMake(0,479+45,384,232)];
            [view3 setFrame:CGRectMake(384, 479+45, 384,232)];
  
			[view4 setFrame:CGRectMake(0,479+45+232,384,247)];
			[view5 setFrame:CGRectMake(384, 479+45+232, 384,247)];
            borderLeftTop.frame=CGRectMake(0, 0, 15, 1024);
             borderLeftTop2.frame=CGRectMake(0, 45, 768, 15);
            borderRightTop.frame=CGRectMake(753, 0, 15, 1024);
            borderLeftBottom.frame=CGRectMake(0, 1004-15, 768, 15);
		}
	}else {
        self.image=[UIImage imageNamed:@"L_5_1.png"];
		if (view1 != nil) {		
			
			[view1 setFrame:CGRectMake(0, 45, 512, 702)];
           
			[view2 setFrame:CGRectMake(512, 45, 247, 351)];
			
			[view3 setFrame:CGRectMake(512, 45+351 , 247,351)];
       
                 
			[view4 setFrame:CGRectMake(512+247 ,45,265,351)];
			[view5 setFrame:CGRectMake(512+247, 45+351,265,351)];
            borderLeftTop.frame=CGRectMake(0, 0, 15, 1024);
            borderLeftTop2.frame=CGRectMake(0, 45, 1024, 15);
            borderRightTop.frame=CGRectMake(1024-15, 0, 15, 768);
            borderLeftBottom.frame=CGRectMake(0, 748-15, 1024, 15);
		}
	}
	
	if (animation) {
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
		[UIView commitAnimations];
	}else {

		for (UIView* myview in [self subviews]) {
			if ([myview isKindOfClass:[UIViewExtention class]]) {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
     
		
		
	}
	
	
	for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			[((UIViewExtention*)myview) rotate:orientation animation:YES];
		}
	}	
	

	
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {	
	for (UIView* myview in [self subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			[((UIViewExtention*)myview) setAlpha:1];
		}
	}

	
	
}
-(void)dealloc
{
    self.view1=nil;
    self.view2=nil;
    self.view3=nil;
    self.view4=nil;
    self.view5=nil;
     borderLeftTop=nil;
     borderLeftTop2=nil;
    borderRightTop=nil;
     borderLeftBottom=nil;
}

@end
