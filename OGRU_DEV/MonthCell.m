//
//  MonthCell.m
//  OGRU_DEV
//
//  Created by Yup on 2012-08-16.
//
//

#import "MonthCell.h"

@implementation MonthCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.highlightedTextColor=RGBCOLOR(11, 64, 2);
        self.textLabel.textColor=RGBCOLOR(178, 178, 178);
        	self.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.textLabel.highlightedTextColor=RGBCOLOR(11, 64, 2);
        self.textLabel.textColor=RGBCOLOR(178, 178, 178);
        UIImageView* bgImageView=[[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"OG_portrait_03_ARCHIVE_active.png"]];
        [self setSelectedBackgroundView:bgImageView];
       
        self.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
