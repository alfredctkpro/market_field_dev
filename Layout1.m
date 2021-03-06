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
//  Layout1.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "Layout1.h"
#import "UIViewExtention.h"
#import "TitleAndTextView.h"
@implementation Layout1

@synthesize view1;

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary{
    self.userInteractionEnabled=YES;
    view1=[[TitleAndTextView alloc] initWithMessageModel:(ArticleModel*)[viewCollectionDictonary objectForKey:@"view1"] WithName:@"1_1"];
    waitFinshViewCount=1;
    view1.delegate=self;

		self.isFullScreen= FALSE;
		view1.isFullScreen = FALSE;
		
	self.backgroundColor=[UIColor whiteColor];	
		[self addSubview:view1];
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
		if (view1 != nil) {
			[view1 setFrame:CGRectMake(0, 50, 768, 954)];
            borderLeftTop.frame=CGRectMake(0, 0, 30, 1024);
            borderLeftTop2.frame=CGRectMake(0, 45, 768, 30);
            borderRightTop.frame=CGRectMake(738, 0, 30, 1024);
            borderLeftBottom.frame=CGRectMake(0, 1004-30, 768, 30);
		}
	}else {
		if (view1 != nil) {		
			[view1 setFrame:CGRectMake(0, 50, 1024, 698)];
           			
            borderLeftTop.frame=CGRectMake(0, 0, 30, 1024);
            borderLeftTop2.frame=CGRectMake(0, 45, 1024, 30);
            borderRightTop.frame=CGRectMake(1024-30, 0, 30, 768);
            borderLeftBottom.frame=CGRectMake(0, 748-30, 1024, 30);

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
		[view1 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
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
	[view1 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
}

-(void)dealloc
{
    self.view1=nil;
  
    borderLeftTop=nil;
    borderLeftTop2=nil;
    borderRightTop=nil;
    borderLeftBottom=nil;
}

@end
