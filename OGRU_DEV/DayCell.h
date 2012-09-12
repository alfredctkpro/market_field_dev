//
//  DayCell.h
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import <UIKit/UIKit.h>

@interface DayCell : UITableViewCell
@property (weak,nonatomic)IBOutlet UILabel* lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblDayOfWeek;
@property (weak,nonatomic)IBOutlet UILabel* lblTitle;
@property (strong, nonatomic) IBOutlet UIView *borderView;
@end
