//
//  ArchiveDayLabel.m
//  MatketField
//
//  Created by Yup on 2012-09-28.
//
//

#import "ArchiveDayLabel.h"

@implementation ArchiveDayLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.textColor=[[AppDelegate instance]getThemeColor];
        self.highlightedTextColor=[[AppDelegate instance]getThemeColor];
        
        
    }
    return self;

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
