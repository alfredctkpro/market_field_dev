//
//  AFKPageFlipper.m
//  AFKPageFlipper
//
//  Created by Marco Tabini on 10-10-12.
//  Copyright 2010 AFK Studio Partnership. All rights reserved.
//
//  Modified by Reefaq Mohammed on 16/07/11.
 
//
#import "AFKPageFlipper.h"


#pragma mark -
#pragma mark UIView helpers


@interface UIView(Extended) 

- (UIImage *) imageByRenderingView;
-(UIImage *) screenshot;
@end


@implementation UIView(Extended)


- (UIImage *) imageByRenderingView {
   
	    CGSize size;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		size=CGSizeMake(768, 1004);
	}else {
		size=CGSizeMake(2048, 748*2);
	}
	
	UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	

	return resultingImage;
}
- (UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		imageSize=CGSizeMake(768, 1004);
	}else {
		imageSize=CGSizeMake(1024, 748);
	}
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front

            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [self center].x, [self center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [self transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[self bounds].size.width * [[self layer] anchorPoint].x,
                                  -[self bounds].size.height * [[self layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[self layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        
    
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
@end


#pragma mark -
#pragma mark Private interface


//@interface AFKPageFlipper()
//
//@property (nonatomic,assign) UIView *currentView;
//@property (nonatomic,assign) UIView *newView;
//
//@end


@implementation AFKPageFlipper


#pragma mark -
#pragma mark Flip functionality

@synthesize pageDifference,numberOfPages,animating,theNewView;

- (void) initFlip {

	@autoreleasepool {
     
   	// Create screenshots of view
    //    NSDate* startDate;
    //    startDate = [NSDate date];
        
       
	UIImage *currentImage = [self.currentView screenshot];
        
	UIImage *newImage = [self.theNewView screenshot];
	// NSLog(@"%f",  -[startDate timeIntervalSinceNow]);

	// Hide existing views
	[self.currentView setHidden:TRUE];
	[self.theNewView setHidden:TRUE];	
	self.currentView.alpha = 0;
	self.theNewView.alpha = 0;
	
	// Create representational layers
	
        CGRect rect ;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		rect=CGRectMake(0, 0, 768, 1004);
	}else {
		rect=CGRectMake(0, 0, 1024, 748);
	}
	backgroundAnimationLayer = [CALayer layer];
	backgroundAnimationLayer.frame = rect;
	backgroundAnimationLayer.zPosition = -300000;
	rect.size.width /= 2;

	CALayer *leftLayer = [CALayer layer];
	leftLayer.frame = rect;
	leftLayer.masksToBounds = YES;
	leftLayer.contentsGravity = kCAGravityLeft;
	
	[backgroundAnimationLayer addSublayer:leftLayer];
	
	rect.origin.x = rect.size.width;
	
	CALayer *rightLayer = [CALayer layer];
	rightLayer.frame = rect;
	rightLayer.masksToBounds = YES;
	rightLayer.contentsGravity = kCAGravityRight;
	
        [backgroundAnimationLayer addSublayer:rightLayer];
        rightLayer.contentsScale=[UIScreen mainScreen].scale;
        leftLayer.contentsScale=[UIScreen mainScreen].scale;
	if (flipDirection == AFKPageFlipperDirectionRight) {
        
		leftLayer.contents = (id) [newImage CGImage];
		rightLayer.contents = (id) [currentImage CGImage];
	} else {
		leftLayer.contents = (id) [currentImage CGImage];
		rightLayer.contents = (id) [newImage CGImage];
	}
    
	[self.layer addSublayer:backgroundAnimationLayer];
	
	rect.origin.x = 0;

	flipAnimationLayer = [CATransformLayer layer];
	flipAnimationLayer.anchorPoint = CGPointMake(1.0, 0.5);
	flipAnimationLayer.frame = rect;
	
	blankFlipAnimationLayerOnLeft1 = [CATransformLayer layer];
	blankFlipAnimationLayerOnLeft1.anchorPoint = CGPointMake(1.0, 0.5);
	blankFlipAnimationLayerOnLeft1.frame = rect;
	blankFlipAnimationLayerOnLeft1.zPosition = -250000;
	
	blankFlipAnimationLayerOnRight1 = [CATransformLayer layer];
	blankFlipAnimationLayerOnRight1.anchorPoint = CGPointMake(1.0, 0.5);
	blankFlipAnimationLayerOnRight1.frame = rect;
	blankFlipAnimationLayerOnRight1.zPosition = 250000;
	
	
	blankFlipAnimationLayerOnLeft2 = [CATransformLayer layer];
	blankFlipAnimationLayerOnLeft2.anchorPoint = CGPointMake(1.0, 0.5);
	blankFlipAnimationLayerOnLeft2.frame = rect;
	blankFlipAnimationLayerOnLeft2.zPosition = -260000;
	
	blankFlipAnimationLayerOnRight2 = [CATransformLayer layer];
	blankFlipAnimationLayerOnRight2.anchorPoint = CGPointMake(1.0, 0.5);
	blankFlipAnimationLayerOnRight2.frame = rect;
	blankFlipAnimationLayerOnRight2.zPosition = 350000;
	
	[self.layer addSublayer:flipAnimationLayer];
	if (pageDifference > 1) {
		[self.layer addSublayer:blankFlipAnimationLayerOnLeft1];
		[self.layer addSublayer:blankFlipAnimationLayerOnRight1];
		if (pageDifference > 2) {
			[self.layer addSublayer:blankFlipAnimationLayerOnLeft2];
			[self.layer addSublayer:blankFlipAnimationLayerOnRight2];
		}
	}
	
	// start
	CALayer *blankBackLayerForLayerLeft = [CALayer layer];
	blankBackLayerForLayerLeft.frame = blankFlipAnimationLayerOnLeft1.bounds;
	blankBackLayerForLayerLeft.doubleSided = NO;
	blankBackLayerForLayerLeft.masksToBounds = YES;
	[blankFlipAnimationLayerOnLeft1 addSublayer:blankBackLayerForLayerLeft];
	
	CALayer *blankFrontLayerForLayerLeft = [CALayer layer];
	blankFrontLayerForLayerLeft.frame = blankFlipAnimationLayerOnLeft1.bounds;
	blankFrontLayerForLayerLeft.doubleSided = NO;
	blankFrontLayerForLayerLeft.masksToBounds = YES;
	blankFrontLayerForLayerLeft.transform = CATransform3DMakeRotation(M_PI, 0, 1.0, 0);
	[blankFlipAnimationLayerOnLeft1 addSublayer:blankFrontLayerForLayerLeft];
	
	
	CALayer *blankBackLayerForLayerRight = [CALayer layer];
	blankBackLayerForLayerRight.frame = blankFlipAnimationLayerOnRight1.bounds;
	blankBackLayerForLayerRight.doubleSided = NO;
	blankBackLayerForLayerRight.masksToBounds = YES;
	[blankFlipAnimationLayerOnRight1 addSublayer:blankBackLayerForLayerRight];
	
	CALayer *blankFrontLayerForLayerRight = [CALayer layer];
	blankFrontLayerForLayerRight.frame = blankFlipAnimationLayerOnRight1.bounds;
	blankFrontLayerForLayerRight.doubleSided = NO;
	blankFrontLayerForLayerRight.masksToBounds = YES;
	blankFrontLayerForLayerRight.transform = CATransform3DMakeRotation(M_PI, 0, 1.0, 0);
	[blankFlipAnimationLayerOnRight1 addSublayer:blankFrontLayerForLayerRight];
	// end	
	
	// start
	CALayer *blankBackLayerForLayerLeft2 = [CALayer layer];
	blankBackLayerForLayerLeft2.frame = blankFlipAnimationLayerOnLeft2.bounds;
	blankBackLayerForLayerLeft2.doubleSided = NO;
	blankBackLayerForLayerLeft2.masksToBounds = YES;
	[blankFlipAnimationLayerOnLeft2 addSublayer:blankBackLayerForLayerLeft2];
	
	CALayer *blankFrontLayerForLayerLeft2 = [CALayer layer];
	blankFrontLayerForLayerLeft2.frame = blankFlipAnimationLayerOnLeft2.bounds;
	blankFrontLayerForLayerLeft2.doubleSided = NO;
	blankFrontLayerForLayerLeft2.masksToBounds = YES;
	blankFrontLayerForLayerLeft2.transform = CATransform3DMakeRotation(M_PI, 0, 1.0, 0);
	[blankFlipAnimationLayerOnLeft2 addSublayer:blankFrontLayerForLayerLeft2];
	
	
	CALayer *blankBackLayerForLayerRight2 = [CALayer layer];
	blankBackLayerForLayerRight2.frame = blankFlipAnimationLayerOnRight2.bounds;
	blankBackLayerForLayerRight2.doubleSided = NO;
	blankBackLayerForLayerRight2.masksToBounds = YES;
	[blankFlipAnimationLayerOnRight2 addSublayer:blankBackLayerForLayerRight2];
	
	CALayer *blankFrontLayerForLayerRight2 = [CALayer layer];
	blankFrontLayerForLayerRight2.frame = blankFlipAnimationLayerOnRight2.bounds;
	blankFrontLayerForLayerRight2.doubleSided = NO;
	blankFrontLayerForLayerRight2.masksToBounds = YES;
	blankFrontLayerForLayerRight2.transform = CATransform3DMakeRotation(M_PI, 0, 1.0, 0);
	[blankFlipAnimationLayerOnRight2 addSublayer:blankFrontLayerForLayerRight2];
	// end	
	
	CALayer *backLayer = [CALayer layer];
	backLayer.frame = flipAnimationLayer.bounds;
	backLayer.doubleSided = NO;
	backLayer.masksToBounds = YES;
	[flipAnimationLayer addSublayer:backLayer];
	
	CALayer *frontLayer = [CALayer layer];
	frontLayer.frame = flipAnimationLayer.bounds;
	frontLayer.doubleSided = NO;
	frontLayer.masksToBounds = YES;
	frontLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1.0, 0);
	[flipAnimationLayer addSublayer:frontLayer];
	

	// shadows
	frontLayerShadow = [CALayer layer];
	frontLayerShadow.frame = frontLayer.bounds;
	frontLayerShadow.doubleSided = NO;
	frontLayerShadow.masksToBounds = YES;
	frontLayerShadow.opacity = 0;
	frontLayerShadow.backgroundColor = [UIColor blackColor].CGColor;
	[frontLayer addSublayer:frontLayerShadow];

	backLayerShadow = [CALayer layer];
	backLayerShadow.frame = backLayer.bounds;
	backLayerShadow.doubleSided = NO;
	backLayerShadow.masksToBounds = YES;
	backLayerShadow.opacity = 0;
	backLayerShadow.backgroundColor = [UIColor blackColor].CGColor;
	[backLayer addSublayer:backLayerShadow];
	
	
	leftLayerShadow = [CALayer layer];
	leftLayerShadow.frame = leftLayer.bounds;
	leftLayerShadow.doubleSided = NO;
	leftLayerShadow.masksToBounds = YES;
	leftLayerShadow.opacity = 0.0;
	leftLayerShadow.backgroundColor = [UIColor blackColor].CGColor;
	[leftLayer addSublayer:leftLayerShadow];
	
	rightLayerShadow = [CALayer layer];
	rightLayerShadow.frame = rightLayer.bounds;
	rightLayerShadow.doubleSided = NO;
	rightLayerShadow.masksToBounds = YES;
	rightLayerShadow.opacity = 0.0;
	rightLayerShadow.backgroundColor = [UIColor blackColor].CGColor;
	[rightLayer addSublayer:rightLayerShadow];
	// shadows

	
	
	backLayer.contentsScale=[UIScreen mainScreen].scale;
        frontLayer.contentsScale=[UIScreen mainScreen].scale;
	if (flipDirection == AFKPageFlipperDirectionRight) {
		
		backLayer.contents = (id) [currentImage CGImage];
		backLayer.contentsGravity = kCAGravityLeft;
		
		frontLayer.contents = (id) [newImage CGImage];
		frontLayer.contentsGravity = kCAGravityRight;
		
		CATransform3D transform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
		transform.m34 = 1.0f / 2500.0f;
		
		flipAnimationLayer.transform = transform;
		transform.m34 = 1.0f / 1500.0f;
		
	
		
			
		currentAngle = startFlipAngle = 0;
		endFlipAngle = -M_PI;
	} else {
		
		backLayer.contentsGravity = kCAGravityLeft;
		backLayer.contents = (id) [newImage CGImage];
		
		frontLayer.contents = (id) [currentImage CGImage];
		frontLayer.contentsGravity = kCAGravityRight;
		
		CATransform3D transform = CATransform3DMakeRotation(-M_PI / 1.1 , 0.0, 1.0, 0.0);
		transform.m34 = -1.0f / 2500.0f;
		
		flipAnimationLayer.transform = transform;
		transform.m34 = -1.0f / 1500.0f;
		

		
	
		
		currentAngle = startFlipAngle = -M_PI ;
		endFlipAngle = 0;
	}
        currentImage=nil;
        newImage=nil;
        rightLayer=nil;
        leftLayer=nil;
    
        backLayer=nil;
        frontLayer=nil;
        rightLayer=nil;
        leftLayer=nil;
        blankBackLayerForLayerLeft=nil;
        blankBackLayerForLayerLeft2=nil;
        blankBackLayerForLayerRight=nil;
        blankBackLayerForLayerRight2=nil;
        blankFrontLayerForLayerRight=nil;
        blankFrontLayerForLayerRight2=nil;
        blankFrontLayerForLayerLeft=nil;
        blankFrontLayerForLayerLeft2=nil;

    
	}
}


- (void) cleanupFlip {
	[backgroundAnimationLayer removeFromSuperlayer];
   // [backgroundAnimationLayer release];
	[flipAnimationLayer removeFromSuperlayer];
   // [flipAnimationLayer release];
	if (pageDifference > 1) {
		[blankFlipAnimationLayerOnLeft1 removeFromSuperlayer];
		[blankFlipAnimationLayerOnRight1 removeFromSuperlayer];
 
		blankFlipAnimationLayerOnLeft1 = Nil;
		blankFlipAnimationLayerOnRight1 = Nil;
		if (pageDifference > 2) {
		
			[blankFlipAnimationLayerOnLeft2 removeFromSuperlayer];
			[blankFlipAnimationLayerOnRight2 removeFromSuperlayer];
      
			blankFlipAnimationLayerOnLeft2 = Nil;
			blankFlipAnimationLayerOnRight2 = Nil;
		}
	}

	backgroundAnimationLayer = Nil;
  
	flipAnimationLayer = Nil;
	
	animating = NO;
	
	if (setNewViewOnCompletion) {
		[self.currentView removeFromSuperview];
     
       		self.currentView = self.theNewView;
    
		self.theNewView = nil;
	} else {
      
		[self.theNewView removeFromSuperview];
      
		self.theNewView = nil;
	}
	
	setNewViewOnCompletion = NO;
	[self.currentView setHidden:FALSE];
	self.currentView.alpha = 1;
    
	[self setDisabled:FALSE];
	
}



- (void) setFlipProgress3:(NSDictionary*)dict{
	
	float progress =[[dict objectForKey:@"PROGRESS"] floatValue];
	BOOL setDelegate = [[dict objectForKey:@"DELEGATE"] boolValue];
	//BOOL animate = [[dict objectForKey:@"ANIMATE"] boolValue];
	
	
	float newAngle = startFlipAngle + progress * (endFlipAngle - startFlipAngle);
	float duration;
	duration = 0.5;
	
	CATransform3D endTransform = CATransform3DIdentity;
	endTransform.m34 = 1.0f / 2500.0f;
	endTransform = CATransform3DRotate(endTransform, newAngle, 0.0, 1.0, 0.0);	
	
	
	[blankFlipAnimationLayerOnLeft2 removeAllAnimations];
	
	[blankFlipAnimationLayerOnRight2 removeAllAnimations];
	
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:duration];
	blankFlipAnimationLayerOnLeft2.transform = endTransform;
	blankFlipAnimationLayerOnRight2.transform = endTransform;
	[UIView commitAnimations];
	
	if (setDelegate) {
		[self performSelector:@selector(cleanupFlip) withObject:Nil afterDelay:duration];
	}
}

- (void) setFlipProgress2:(NSDictionary*)dict{
	
	float progress =[[dict objectForKey:@"PROGRESS"] floatValue];
	BOOL setDelegate = [[dict objectForKey:@"DELEGATE"] boolValue];
	BOOL animate = [[dict objectForKey:@"ANIMATE"] boolValue];
	
	
	float newAngle = startFlipAngle + progress * (endFlipAngle - startFlipAngle);
	float duration ;//= animate ? 0.5 * fabs((newAngle - currentAngle) / (endFlipAngle - startFlipAngle)) : 0;
	
	duration = 0.5;
	
	CATransform3D endTransform = CATransform3DIdentity;
	endTransform.m34 = 1.0f / 2500.0f;
	endTransform = CATransform3DRotate(endTransform, newAngle, 0.0, 1.0, 0.0);	
	
	
	[blankFlipAnimationLayerOnLeft1 removeAllAnimations];
	
	[blankFlipAnimationLayerOnRight1 removeAllAnimations];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:duration];
	blankFlipAnimationLayerOnLeft1.transform = endTransform;	
	blankFlipAnimationLayerOnRight1.transform = endTransform;
	[UIView commitAnimations];
	
	
	if (pageDifference > 2) {
		
		NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
		[dictionary setObject:[NSString stringWithFormat:@"%f",progress] forKey:@"PROGRESS"];
		[dictionary setObject:[NSString stringWithFormat:@"%d",setDelegate] forKey:@"DELEGATE"];
		[dictionary setObject:[NSString stringWithFormat:@"%d",animate] forKey:@"ANIMATE"];	
		
		[self performSelector:@selector(setFlipProgress3:) withObject:dictionary afterDelay:0.12];
		
		[dictionary release];
		
	}else {
		if (setDelegate) {
			[self performSelector:@selector(cleanupFlip) withObject:Nil afterDelay:duration];
		}
	}	
	
}

- (void) setFlipProgress:(float) progress setDelegate:(BOOL) setDelegate animate:(BOOL) animate {
	self.userInteractionEnabled=NO;
	float newAngle = startFlipAngle + progress * (endFlipAngle - startFlipAngle);
	float duration = animate ? 0.5 * fabs((newAngle - currentAngle) / (endFlipAngle - startFlipAngle)) : 0;
	
	currentAngle = newAngle;
	
	CATransform3D endTransform = CATransform3DIdentity;
	endTransform.m34 = 1.0f / 2500.0f;
	endTransform = CATransform3DRotate(endTransform, newAngle, 0.0, 1.0, 0.0);	
	
	[flipAnimationLayer removeAllAnimations];
	
	// shadows
	CGFloat newShadowOpacity = progress;
	if (endFlipAngle > startFlipAngle) newShadowOpacity = 1.0 - progress;
	// shadows

	if (duration < 0.35) {
		duration = 0.35;
	}
	
	[UIView beginAnimations:@"FLIP1" context:nil];
	[UIView setAnimationDuration:duration];
	flipAnimationLayer.transform =  endTransform;
	
	// shadows
	frontLayerShadow.opacity = 1.0 - newShadowOpacity;
	backLayerShadow.opacity = newShadowOpacity;
	leftLayerShadow.opacity = 0.5 - newShadowOpacity;
	rightLayerShadow.opacity = newShadowOpacity - 0.5;
	// shadows
	[UIView commitAnimations];
	
	if (pageDifference > 1) {
		
		NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
		[dict setObject:[NSString stringWithFormat:@"%f",progress] forKey:@"PROGRESS"];
		[dict setObject:[NSString stringWithFormat:@"%d",setDelegate] forKey:@"DELEGATE"];
		[dict setObject:[NSString stringWithFormat:@"%d",animate] forKey:@"ANIMATE"];	
		
		[self performSelector:@selector(setFlipProgress2:) withObject:dict afterDelay:0.12];
		
		[dict release];
		
	}else {
		if (setDelegate) {
			[self performSelector:@selector(cleanupFlip) withObject:Nil afterDelay:duration];
		}
	}
	
	
}

- (void) flipPage {
	[self setFlipProgress:1.0 setDelegate:YES animate:YES];
}


#pragma mark -
#pragma mark Animation management


- (void)animationDidStop:(NSString *) animationID finished:(NSNumber *) finished context:(void *) context {
	[self cleanupFlip];
}


#pragma mark -
#pragma mark Properties

@synthesize currentView;


- (void) setCurrentView:(UIView *) value {
	if (currentView) {
		[currentView release];
	}
	
	currentView = [value retain];
}





- (void) setTheNewView:(UIView *) value {
	if (theNewView) {
		[theNewView release];
	}
	
	theNewView = [value retain];
}


@synthesize currentPage;


- (BOOL) doSetCurrentPage:(NSInteger) value {
	if (value == currentPage) {
		return FALSE;
	}
	
	flipDirection = value < currentPage ? AFKPageFlipperDirectionRight : AFKPageFlipperDirectionLeft;
	
	currentPage = value;
    self.theNewView = [self.dataSource viewForPage:value inFlipper:self];
   	
	
	[self addSubview:self.theNewView];
	
	return TRUE;
}	

- (void) setCurrentPage:(NSInteger) value {
	if (![self doSetCurrentPage:value]) {
		return;
	}
	
	setNewViewOnCompletion = YES;
	animating = NO;
	
	[[self theNewView] setHidden:TRUE];
	[[self theNewView] setAlpha:  0];
	
	
	[UIView beginAnimations:@"" context:Nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	[[self theNewView] setHidden:FALSE];
	[[self theNewView] setAlpha:1];
	
	[UIView commitAnimations];
	
	
} 


- (void) setCurrentPage:(NSInteger) value animated:(BOOL) animated {
	
	
	pageDifference = fabs(value - currentPage);
	
	if (![self doSetCurrentPage:value]) {
		return;
	}
	
	setNewViewOnCompletion = YES;
	animating = YES;
	
	if (animated) {
		[self setDisabled:TRUE];
		//[self initFlip];
		//[self setFlipProgress:0.01 setDelegate:NO animate:NO];
		
		if (pageDifference > 1) {
			NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
			[dictionary setObject:[NSString stringWithFormat:@"%f",0.01] forKey:@"PROGRESS"];
			[dictionary setObject:[NSString stringWithFormat:@"%d",NO] forKey:@"DELEGATE"];
			[dictionary setObject:[NSString stringWithFormat:@"%d",NO] forKey:@"ANIMATE"];	
			
			//multi-flip-for 2
			[self setFlipProgress2:dictionary];
			
			if (pageDifference > 2) {
				//multi flip-for more than 2
				[self setFlipProgress3:dictionary];
			}
			
			[dictionary release];
		}
		[self performSelector:@selector(flipPage) withObject:Nil afterDelay:0.000];
	} else {
		[self animationDidStop:Nil finished:[NSNumber numberWithBool:NO] context:Nil];
	}
	
}


@synthesize dataSource;


- (void) setDataSource:(NSObject <AFKPageFlipperDataSource>*) value {
	
	if (dataSource) {
		[dataSource release];
	}
	
	dataSource = [value retain];
	numberOfPages = [dataSource numberOfPagesForPageFlipper:self];
	self.currentPage = 2;
}
- (void) setDataSource:(NSObject <AFKPageFlipperDataSource>*) value WithPage:(NSInteger) page{
	if (dataSource) {
		[dataSource release];
	}
	
	dataSource = [value retain];
	numberOfPages = [dataSource numberOfPagesForPageFlipper:self];
    currentPage = 0;
	self.currentPage = page;
}

@synthesize disabled;


- (void) setDisabled:(BOOL) value {
	disabled = value;
	
	self.userInteractionEnabled = !value;
	
	for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
		recognizer.enabled = !value;
	}
}

#pragma mark -
#pragma mark Touch management


- (void) panned:(UIPanGestureRecognizer *) recognizer {
	static BOOL hasFailed;
	static BOOL initialized;
	
	static NSInteger oldPage;
	
	float translation = [recognizer translationInView:self].x;
	
	float progress = translation / self.bounds.size.width;
	
	if (flipDirection == AFKPageFlipperDirectionLeft) {
		progress = MIN(progress, 0);
	} else {
		progress = MAX(progress, 0);
	}
	
	pageDifference = 1;
	
	switch (recognizer.state) {
		case UIGestureRecognizerStateBegan:
			if (!animating) {
				hasFailed = FALSE;
				initialized = FALSE;
				animating = NO;
				setNewViewOnCompletion = NO;
			}
       //     [[AppDelegate instance].viewController.queue setSuspended:YES];
			break;
			
		case UIGestureRecognizerStateChanged:
			if (hasFailed) {
				return;
			}
			
			if (!initialized) {
				oldPage = self.currentPage;
				
				if (translation > 0) {
					if (self.currentPage > 1) {
						[self doSetCurrentPage:self.currentPage - 1];
					} else {
						hasFailed = TRUE;
						return;
					}
				} else {
					if (self.currentPage < numberOfPages) {
						[self doSetCurrentPage:self.currentPage + 1];
					} else {
						hasFailed = TRUE;
						return;
					}
				}
			
                
				hasFailed = NO;
				initialized = TRUE;
				animating = YES;
				setNewViewOnCompletion = NO;
				//NSDate* startDate;
               // startDate = [NSDate date];
				[self initFlip];
              //  NSLog(@"%f",  -[startDate timeIntervalSinceNow]);
			}
            if (self.currentPage==numberOfPages && translation<=-384) {
                hasFailed = YES;

                return;
            }
            else if(self.currentPage==1 &&  translation>=384)
            {
                hasFailed = YES;
                initialized=NO;
                [self setFlipProgress:0.0 setDelegate:YES animate:YES];
                currentPage = oldPage;
                return;
            }
			[self setFlipProgress:fabs(progress) setDelegate:NO animate:YES];
			break;
			
		case UIGestureRecognizerStateFailed:
			[self setDisabled:TRUE];
			[self setFlipProgress:0.0 setDelegate:YES animate:YES];
			currentPage = oldPage;
			break;
			
		case UIGestureRecognizerStateRecognized:
			if (initialized) {
				if (hasFailed) {
					[self setDisabled:TRUE];
					[self setFlipProgress:0.0 setDelegate:YES animate:YES];
					currentPage = oldPage;
					return;
				}
                if (fabs((translation + [recognizer velocityInView:self].x / 4) / self.bounds.size.width) > 0.1) {
                    if (self.currentPage==numberOfPages ) {
                        hasFailed = YES;
                        [self setDisabled:TRUE];
                        [self setFlipProgress:0.0 setDelegate:YES animate:YES];
                        currentPage = oldPage;
                        return;
                    }
                    else if(self.currentPage==1 )
                    {
                        hasFailed = YES;
                        initialized=NO;
                        [self setFlipProgress:0.0 setDelegate:YES animate:YES];
                        currentPage = oldPage;
                        return;
                    }
                    else if(progress==0)
                    {
                        hasFailed = YES;
                        initialized=NO;
                        [self setFlipProgress:0.0 setDelegate:YES animate:YES];
                        currentPage = oldPage;
                        return;

                    }
else
{
                    [self setDisabled:TRUE];
                    setNewViewOnCompletion = YES;
                    [self setFlipProgress:1.0 setDelegate:YES animate:YES];
}
                } else {
                    [self setFlipProgress:0.0 setDelegate:YES animate:YES];
                    currentPage = oldPage;
                }
			//	[self setDisabled:TRUE];
			//	setNewViewOnCompletion = YES;
			//	[self setFlipProgress:1.0 setDelegate:YES animate:YES];
			}
		//	[[AppDelegate instance].viewController.queue setSuspended:NO];
			break;
            case UIGestureRecognizerStateCancelled:
            [self setFlipProgress:0.0 setDelegate:YES animate:YES];
            currentPage = oldPage;
            break;
            case UIGestureRecognizerStatePossible:
            break;
	}
}


#pragma mark -
#pragma mark Frame management


- (void) setFrame:(CGRect) value {
	super.frame = value;
	
	numberOfPages = [dataSource numberOfPagesForPageFlipper:self];
	
	if (self.currentPage > numberOfPages) {
		self.currentPage = numberOfPages;
	}
	
}


#pragma mark -
#pragma mark Initialization and memory management


+ (Class) layerClass {
	return [CATransformLayer class];
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)] autorelease];
		[panRecognizer setMaximumNumberOfTouches:1];
		[self addGestureRecognizer:panRecognizer];
		
		flipIllusionPortrait = [[UIImage imageNamed:@"flip-illusion-oriented.jpg"] retain];
		flipIllusionLandscape = [[UIImage imageNamed:@"flip-illusion.png"] retain];
		
		animating = FALSE;
    }
    return self;
}


- (void)dealloc {
	self.dataSource = Nil;
	self.currentView = Nil;
	self.theNewView = Nil;
    [panRecognizer release];
    panRecognizer=nil;
    [frontLayerShadow release];
  	[backLayerShadow release];
	[leftLayerShadow release];
	[rightLayerShadow release];
    dataSource=nil;
    [currentView release];
	[theNewView release];
	
	// shadows
	[frontLayerShadow release];
	[backLayerShadow release];
	[leftLayerShadow release];
    [rightLayerShadow release];
	// shadows
    
    [backgroundAnimationLayer release];
	[flipAnimationLayer release];
	[blankFlipAnimationLayerOnLeft1 release];
	[blankFlipAnimationLayerOnRight1 release];
	
	[blankFlipAnimationLayerOnLeft2 release];
	[blankFlipAnimationLayerOnRight2 release];
	

	
    [flipIllusionPortrait release];
	[flipIllusionLandscape release];
    [super dealloc];
}

@end
