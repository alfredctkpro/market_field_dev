//
//  FlipFullScreenView.h
//  OGRU_DEV
//
//  Created by Yup on 2012-08-16.
//
//

#import <UIKit/UIKit.h>
#import "AFKPageFlipper.h"
#import "FullScreenView.h"
@interface FlipFullScreenView : UIViewExtention<AFKPageFlipperDataSource>
{
    AFKPageFlipper *flipper;
}
-(id)initWithModel:(NSString*)model withMode:(NSString*)mode;

@property (nonatomic,assign) NSString* messageModel;
@property (nonatomic,assign) UIViewExtention* viewToOverLap;
@property (nonatomic,assign) UIView* fullScreenBG;
@property (nonatomic,retain) NSString* mode;
@end
