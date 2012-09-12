//
//  ArchiveController.h
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import <UIKit/UIKit.h>
#import "DayCell.h"
#import "ArchiveParser.h"
#import "MonthCell.h"
#import "IndexViewController.h"
@interface ArchiveController : UIViewController<UITableViewDataSource,UITableViewDelegate,ArchiveParserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *monthTableView;
@property (weak, nonatomic) IBOutlet UITableView *dayTableView;

- (IBAction)closeArchive:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *archiveView;
@property (weak, nonatomic) IBOutlet UIButton *bgView;

@end
