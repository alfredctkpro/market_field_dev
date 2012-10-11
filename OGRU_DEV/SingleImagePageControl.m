//
//  SingleImagePageControl.m
//  MarketField
//
//  Created by yup on 10/8/12.
//
//

#import "SingleImagePageControl.h"

@implementation SingleImagePageControl

- (void)dealloc
{
    activeImage=nil;
    inactiveImage=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        activeImage = [UIImage imageNamed:@"daily_single_image_active.png"];
        inactiveImage = [UIImage imageNamed:@"daily_single_image_inactive.png"];
        
        
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    activeImage = [UIImage imageNamed:@"daily_single_image_active.png"];
    inactiveImage = [UIImage imageNamed:@"daily_single_image_inactive.png"];
    
    return self;
}

-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        dot.frame=CGRectMake(dot.frame.origin.x, dot.frame.origin.y, 7, 7);
        if (i == self.currentPage) dot.image = activeImage;
        else dot.image = inactiveImage;
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
