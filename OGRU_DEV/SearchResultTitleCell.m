//
//  SearchResultTitleCell.m
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import "SearchResultTitleCell.h"

@implementation SearchResultTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor =[UIColor whiteColor];
        lblCount=[[UILabel alloc]init];
        lblCount.textColor=[[AppDelegate instance]getThemeColor];
       	lblCount.font =[UIFont fontWithName:@"HelveticaNeue-Bold" size:34];
        

        
        lblText=[[UILabel alloc]init];
        lblText.textColor=RGBCOLOR(51, 51, 51);
       	lblText.font =[UIFont fontWithName:@"HelveticaNeue-Light" size:34];
        [self addSubview:lblCount];
        [self addSubview:lblText];
        
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        lblCount=[[UILabel alloc]init];
        lblCount.textColor=RGBCOLOR(1, 0, 128);
       	lblCount.font =[UIFont fontWithName:@"HelveticaNeue-Bold" size:34];
        
        
        
        lblText=[[UILabel alloc]init];
        lblText.textColor=RGBCOLOR(51, 51, 51);
       	lblText.font =[UIFont fontWithName:@"HelveticaNeue-Light" size:34];
        [self addSubview:lblCount];
        [self addSubview:lblText];

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCount:(NSString *)count
{
    CGSize textSize=[count sizeWithFont:lblCount.font];
    lblCount.frame=CGRectMake(0, 20, textSize.width, textSize.height);
    lblCount.text=count;
    if([count intValue]<=1)
    {
        lblText.text=@"Article Found";
    }
    else{
        lblText.text=@"Articles Found";
    }
    textSize=[lblText.text sizeWithFont:lblText.font];
    lblText.frame=CGRectMake(lblCount.frame.size.width+[@" " sizeWithFont:lblCount.font].width, 20, textSize.width, textSize.height);
}
- (void)dealloc
{
    lblCount=nil;
    lblText=nil;
}
@end
