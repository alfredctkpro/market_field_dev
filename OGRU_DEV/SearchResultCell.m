//
//  SearchResultCell.m
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import "SearchResultCell.h"

@implementation SearchResultCell
{
    UIView* borderView;
}
@synthesize lblDate,lblTitle;
- (void)dealloc
{
    borderView=nil;
    lblTitle=nil;
    lblTitle=nil;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *bgColorView = [[UIView alloc] init];
        
        [bgColorView setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgroundView:bgColorView];
        lblDate=[[UILabel alloc]init];
        lblDate.frame=CGRectMake(0,5.33,self.frame.size.width,22);
        lblDate.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin;
        lblDate.textColor=RGBCOLOR(11,64,2);
        //lblDate.backgroundColor=[UIColor redColor];
        lblTitle=[[UILabel alloc]init];
        lblTitle.frame=CGRectMake(0,self.frame.size.height/2-5.33,self.frame.size.width,22);
        lblTitle.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        borderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1  )];
        borderView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
        borderView.backgroundColor=RGBCOLOR(217, 217, 217);
        
        [self    addSubview:borderView];
        [self addSubview:lblDate];
        [self addSubview:lblTitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected)
    {
        borderView.backgroundColor=RGBCOLOR(11, 64, 2);
    }
    // Configure the view for the selected state
}

@end
