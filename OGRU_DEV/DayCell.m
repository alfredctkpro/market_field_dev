//
//  DayCell.m
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import "DayCell.h"

@implementation DayCell
@synthesize borderView;
@synthesize lblDayOfWeek;
@synthesize lblDay,lblTitle;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
              UIView *bgColorView = [[UIView alloc] init];
        
        [bgColorView setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgroundView:bgColorView];
            
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
  
    if (selected) {
        borderView.backgroundColor=RGBCOLOR(11, 64, 2);
    }
  
    // Configure the view for the selected state
}
-(void)dealloc
{
    self.borderView=nil;
    self.lblDay=nil;
    self.lblDayOfWeek=nil;
    self.lblTitle=nil;
    
}
@end
