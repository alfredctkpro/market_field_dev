//
//  ViewController.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIButton *btnRequest;

- (IBAction)btnLoginClick:(id)sender;
- (IBAction)pwdDone:(id)sender;
- (IBAction)btnRequestClick:(id)sender;

@end
