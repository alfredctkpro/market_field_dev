//
//  ArchiveController.m
//  OGRU_DEV
//
//  Created by Yup on 2012-07-29.
//
//

#import "ArchiveController.h"

@interface ArchiveController ()

@end

@implementation ArchiveController
@synthesize archiveView;
@synthesize bgView;
@synthesize monthTableView;
@synthesize dayTableView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    if([self.monthTableView indexPathForSelectedRow]==nil)
    {
        
        [[self monthTableView]selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self tableView:self.monthTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        self.lblLoading.center=self.dayTableView.center;
        self.aivLoading.center=self.dayTableView.center;
        self.aivLoading.frame=CGRectMake(self.aivLoading.frame.origin.x,self.aivLoading.frame.origin.y+self.lblLoading.frame.size.height , self.aivLoading.frame.size.width, self.aivLoading.frame.size.height);
        self.lblLoading.hidden=YES;
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setMonthTableView:nil];
    [self setDayTableView:nil];
  
    [self setArchiveView:nil];
    [self setBgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.monthTableView)
    {
        NSCalendar* calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setYear:2008];
        [components setMonth:7];
        [components setDay:1];
        
        
        NSDate* fromDate=[calendar dateFromComponents:components];
        NSDateComponents* components2=[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:[NSDate date]];
        [components2 setDay:1];
        [components2 setHour:0];
        [components2 setMinute:0];
        [components2 setSecond:0];
        NSDate* toDate=[calendar dateFromComponents:components2];
        
        NSDateComponents* result=[calendar components:NSMonthCalendarUnit fromDate:fromDate toDate:toDate options:0];
       
        return result.month+1;
    }
    else
    {
        return [AppDelegate instance].Archiverticles.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.monthTableView) {
        NSDate *today = [NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.month = -1*indexPath.row;
        NSDate *nextMonth = [gregorian dateByAddingComponents:components toDate:today options:0];
        
        
        NSDateComponents *nextMonthComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:nextMonth];
        
        
        NSDate *nextMonthDay = [gregorian dateFromComponents:nextMonthComponents];
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY MMMM"];
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        NSString *dateString = [dateFormat stringFromDate:nextMonthDay];
        
        NSString *CellIdentifier = @"monthCell";
        MonthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text=dateString;
        cell.tag=nextMonthComponents.year*100+nextMonthComponents.month;
        return cell;
    }else 
    {
        
        NSString *CellIdentifier = @"dayCell";
        DayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[DayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        NSString* dayString=[(ArticleModel*)[[AppDelegate instance].Archiverticles objectAtIndex:indexPath.row]date];
    
        cell.lblDay.text=[[dayString componentsSeparatedByString:@"\n"]objectAtIndex:0];
        cell.lblDayOfWeek.text=[[dayString componentsSeparatedByString:@"\n"]objectAtIndex:1];
        if (cell.lblDay.text ==nil) {
            cell.borderView.frame=CGRectMake(50, 0, 336-50, 1);
        }
        else
        {
            cell.borderView.frame=CGRectMake(0, 0, 336, 1);
        }
        NSString* title=[(ArticleModel*)[[AppDelegate instance].Archiverticles objectAtIndex:indexPath.row]title];
        cell.lblTitle.text=title;
       
        return cell;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.monthTableView) {
        tableView.allowsSelection=NO;
        [[AppDelegate instance].Archiverticles removeAllObjects];
        [self.dayTableView reloadData];
        ArchiveParser* parser=[[ArchiveParser alloc]init];
         parser.delegate=self;
        [parser startWithYear:[[NSString alloc]initWithFormat:@"%i",[tableView cellForRowAtIndexPath:indexPath].tag/100] Month:[[NSString alloc]initWithFormat:@"%i",[tableView cellForRowAtIndexPath:indexPath].tag%100]];
        [self.aivLoading startAnimating];
        self.lblLoading.hidden=NO;

    }
    else if(tableView==self.dayTableView)
    {
          [[AppDelegate instance]showViewInFullScreen:nil withModel:[[AppDelegate instance].Archiverticles objectAtIndex:indexPath.row] Mode:@"archive"];
    }
}

- (void)parserDidEndParsingData:(ArchiveParser *)parser
{
    [self.aivLoading stopAnimating];
    self.lblLoading.hidden=YES;
    [self.dayTableView reloadData];
    self.monthTableView.allowsSelection=YES;
}
// Called by the parser in the case of an error.
- (void)parser:(ArchiveParser *)parser didFailWithError:(NSError *)error
{
    self.monthTableView.allowsSelection=YES;
}
// Called by the parser when one or more songs have been parsed. This method may be called multiple times.
- (void)parser:(ArchiveParser *)parser didParseIndex:(NSArray *)parsedArticles
{
    if ([AppDelegate instance].Archiverticles==nil) {
        [AppDelegate instance].Archiverticles=[[NSMutableArray alloc]init];
    }
    [[AppDelegate instance].Archiverticles addObjectsFromArray: parsedArticles];
   
}
- (IBAction)closeArchive:(id)sender {
    [[[AppDelegate instance] viewController]hideArchiveViewAnimate:YES];
}
@end
