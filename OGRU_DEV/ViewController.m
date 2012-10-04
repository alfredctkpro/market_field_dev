//
//  ViewController.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController
{
    NSMutableDictionary* dic;
}
@synthesize btnRequest;
@synthesize btnLogin;
@synthesize bgImage;
@synthesize txtUsername;
@synthesize txtPassword;



- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        bgImage.frame=CGRectMake(143, 125, 481, 560);
        txtUsername.frame=CGRectMake(207, 306, 350, 45);
        txtPassword.frame=CGRectMake(207, 395, 350, 45);
        btnLogin.frame=CGRectMake(207, 479, 350, 49);
      //  btnRequest.frame=CGRectMake(209, 514, 350, 45);
    }
    else
    {
        
        bgImage.frame=CGRectMake(271, 15, 481, 560);
        txtUsername.frame=CGRectMake(335, 197, 350, 45);
        txtPassword.frame=CGRectMake(335, 285, 350, 45);
        btnLogin.frame=CGRectMake(335, 368, 350, 49);
    }
    NSString* path=[[NSBundle mainBundle]pathForResource:@"Property List" ofType:@"plist"];
    dic= [[NSMutableDictionary alloc]initWithContentsOfFile:path];

    UIImage *img = [[UIImage alloc]initWithContentsOfFile:
                    [[NSBundle mainBundle]pathForResource:@"COLOR" ofType:@"png"]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
  //  [img release];
    //self.view.backgroundColor=RGBCOLOR(31,31,31);
    txtPassword.secureTextEntry=YES;//設定成密碼格式
    txtUsername.frame = CGRectMake(txtUsername.frame.origin.x, txtUsername.frame.origin.y, txtUsername.frame.size.width, 45);
    if ([dic objectForKey:@"username"]!=nil && ![[dic objectForKey:@"username"] isEqualToString:@""]) {
        
        txtUsername.text=[dic objectForKey:@"username"];
    }
    //txtUsername.textColor=RGBCOLOR(31,31,31);
    //txtUsername.backgroundColor=RGBCOLOR(249,249,249);
    txtPassword.frame = CGRectMake(txtPassword.frame.origin.x, txtPassword.frame.origin.y, txtPassword.frame.size.width, 45);
    //txtPassword.textColor=RGBCOLOR(31,31,31);
    //txtPassword.backgroundColor=RGBCOLOR(249,249,249);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    
    [self setTxtUsername:nil];
    [self setTxtPassword:nil];
    [self setBtnLogin:nil];
    [self setBgImage:nil];
    [self setBtnRequest:nil];
    dic=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        bgImage.frame=CGRectMake(143, 125, 481, 560);
        txtUsername.frame=CGRectMake(207, 306, 350, 45);
        txtPassword.frame=CGRectMake(207, 395, 350, 45);
        btnLogin.frame=CGRectMake(207, 479, 350, 49);
        //  btnRequest.frame=CGRectMake(209, 514, 350, 45);
    }
    else
    {
        
        bgImage.frame=CGRectMake(271, 15, 481, 560);
        txtUsername.frame=CGRectMake(335, 197, 350, 45);
        txtPassword.frame=CGRectMake(335, 285, 350, 45);
        btnLogin.frame=CGRectMake(335, 368, 350, 49);
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (IBAction)pwdDone:(id)sender
{
    self.btnLogin.enabled=NO;
    [[[WebServiceHelper alloc]init] loginWithUsername:txtUsername.text
                               Password:txtPassword.text 
                               Complete:^(NSString* result) {
                                   
                                   if([result isEqualToString:@"TRUE"])
                                   {
                                       [dic setValue:txtUsername.text forKey:@"username"];
                                       NSString* path=[[NSBundle mainBundle]pathForResource:@"Property List" ofType:@"plist"];
                                       
                                       [dic writeToFile:path atomically: YES];
                                       
                                       [self performSegueWithIdentifier:@"GoToIndexPage" sender:sender];
                                        self.btnLogin.enabled=YES;
                                       
                                   }
                                   else   if([result isEqualToString:@"FALSE"]){
                                       
                                       //登入失敗做的事
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
                                                             
                                                                                       message:@"We didn't recognize the username or password you entered. Please try again."  //警告訊息內文的設定
                                                                                      delegate:self // 叫出AlertView之後，要給該ViewController去處理
                                                             
                                                                             cancelButtonTitle:@"OK"  //cancel按鈕文字的設定
                                                                             otherButtonTitles: nil]; // 其他按鈕的設定
                                       [alert show];
 self.btnLogin.enabled=YES;
                                   }
                               } 
                                  Error:^(NSError *error) {
                                      //發生error時做的事
                                      NSLog(@"%@",error.localizedDescription);
                                  }
     ];

}

- (IBAction)btnRequestClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ogru.com/blog/ogruappreq.aspx"]];
     
}
- (IBAction)btnLoginClick:(id)sender {
    [txtUsername resignFirstResponder];
    [txtPassword resignFirstResponder];
   //  [self performSegueWithIdentifier:@"GoToIndexPage" sender:sender];
    
    self.btnLogin.enabled=FALSE;
    [[[WebServiceHelper alloc]init] loginWithUsername:txtUsername.text 
                               Password:txtPassword.text 
                               Complete:^(NSString* result) {
                                   
                                     if([result isEqualToString:@"TRUE"])
                                   {
                                       [dic setValue:txtUsername.text forKey:@"username"];
                                       NSString* path=[[NSBundle mainBundle]pathForResource:@"Property List" ofType:@"plist"];
                                       
                                       [dic writeToFile:path atomically: YES];
                                       

                                       [self performSegueWithIdentifier:@"GoToIndexPage" sender:sender];
                                       self.btnLogin.enabled=YES;
                                   }
                                   else   if([result isEqualToString:@"FALSE"]){
                                       self.btnLogin.enabled=YES;
                                       //登入失敗做的事
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
                                                             
                                                                                       message:@"We didn't recognize the username or password you entered. Please try again."  //警告訊息內文的設定
                                                                                      delegate:self // 叫出AlertView之後，要給該ViewController去處理
                                                             
                                                                             cancelButtonTitle:@"OK"  //cancel按鈕文字的設定
                                                                             otherButtonTitles: nil]; // 其他按鈕的設定
                                       [alert show];
                                   }
                               } 
                               Error:^(NSError *error) {
                                   //發生error時做的事
                                   NSLog(@"%@",error.localizedDescription);
                               }
     ];
    
}

@end
