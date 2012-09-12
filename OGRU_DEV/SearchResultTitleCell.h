//
//  SearchResultTitleCell.h
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import <UIKit/UIKit.h>

@interface SearchResultTitleCell : UITableViewCell
{
    UILabel* lblCount;
    UILabel* lblText;
}
-(void)setCount:(NSString*)count;
@end
