//
//  mySegue.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;
@interface FlipSegue : UIStoryboardSegue
@property (nonatomic, assign) AppDelegate *appDelegate;
@end
