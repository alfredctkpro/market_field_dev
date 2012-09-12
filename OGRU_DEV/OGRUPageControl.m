//
//  OGRUPageControl.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OGRUPageControl.h"

@implementation OGRUPageControl
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
        activeImage = [UIImage imageNamed:@"OG_landscape_02_DAILY_single_PaginationB.png"];
        inactiveImage = [UIImage imageNamed:@"OG_landscape_02_DAILY_single_PaginationW.png"];
        
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    activeImage = [UIImage imageNamed:@"OG_landscape_02_DAILY_single_PaginationB.png"];
    inactiveImage = [UIImage imageNamed:@"OG_landscape_02_DAILY_single_PaginationW.png"];
    
    return self;
}

-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
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
