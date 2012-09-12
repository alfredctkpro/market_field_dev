/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  TitleAndTextView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "TitleAndTextView.h"
#import "MessageModel.h"

@implementation TitleAndTextView

@synthesize messageModel,userImageView,name;

- (id) initWithMessageModel:(ArticleModel*)messagemodel WithName:(NSString *)n{
	if (self = [super init]) {

		self.messageModel = messagemodel;
        self.name=n ;
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];


	}
	return self;
}
- (void)reAdjustLayout{
  //  userNameLabel.backgroundColor=RGBACOLOR(0, 245, 184,0.8);
  //  messageLabel.backgroundColor=RGBACOLOR(255, 112, 219,0.8);
  //  messageLabel2.backgroundColor=RGBACOLOR(245, 184, 0, 0.8);
    if (theWebView.superview!=nil) {
        [theWebView removeFromSuperview];
    }
     [contentView setFrame:CGRectMake(0.5, 0.5, self.frame.size.width-1, self.frame.size.height - 1)];
     if (currrentInterfaceOrientation == UIInterfaceOrientationPortrait || currrentInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
     {
    
         if ([self.name isEqualToString:@"5_1_1"]||[self.name isEqualToString:@"4_1_1"]||[self.name isEqualToString:@"4_2_1"]||[self.name isEqualToString:@"3_2_1"]||[self.name isEqualToString:@"2_1"]||[self.name isEqualToString:@"2_2"]||[self.name isEqualToString:@"1_1"])
             //img2c 30,30
         {
             theWebView.frame=CGRectMake(14.5, 14.5, contentView.frame.size.width, contentView.frame.size.height-15);
             theWebView.scrollView.scrollEnabled=NO;
             [contentView addSubview:theWebView];
             NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                           @"<br/><br/>" options:0 error:nil];
             NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:
                                            @"<br/>" options:0 error:nil];
             NSMutableString *str = [NSMutableString stringWithString:
                                     messageModel.content];
             [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"<br><br>"];
             [regex2 replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;}</style></head><body style=\"margin: 15px 15px 0px 15px;\"><div class=\"content\" style=\"height:450px;width: 708px \"><img style=\"width:339px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:#0b4002;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",[messageModel.images objectAtIndex:0],messageModel.title,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
                   }
         else if ([self.name isEqualToString:@"5_1_2"]||[self.name isEqualToString:@"5_1_4"]||[self.name isEqualToString:@"4_2_3"]||[self.name isEqualToString:@"4_2_4"])
              //text 30,15
         {
            
             if (userImageView.superview!=nil) {
                 [userImageView removeFromSuperview];
                  [aiv removeFromSuperview];
             }
             if (messageLabel2.superview!=nil) {
                 [messageLabel2 removeFromSuperview  ];
             }
              userNameLabel.frame=CGRectMake(30, 15, 340, 21);
             int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
             
             if (userNameLabel.text.length > titleSplit) {
                 userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                 userNameLabel.numberOfLines=0;
             }
             [userNameLabel sizeToFit];
             
             [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
             [timeStampLabel sizeToFit];
             [messageLabel setFrame:CGRectMake(userNameLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
          
                       
             [messageLabel setText:messageModel.content];
             
             
             
             int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
             if (messageModel.content.length> messageSplit) {
                 NSRange range = NSMakeRange (0, messageSplit);
                 messageLabel.text=[messageModel.content substringWithRange:range]  ;
            }
             
                        

         }
         else if ([self.name isEqualToString:@"5_1_3"]||[self.name isEqualToString:@"5_1_5"]||[self.name isEqualToString:@"5_2_5"]||[self.name isEqualToString:@"4_1_3"]||[self.name isEqualToString:@"4_1_4"])
                //text 15,15
         {
          
             if (userImageView.superview!=nil) {
                 [userImageView removeFromSuperview];
                 [aiv removeFromSuperview];
             }
             if (messageLabel2.superview!=nil) {
                 [messageLabel2 removeFromSuperview  ];
             }
             userNameLabel.frame=CGRectMake(15, 15, 340, 21);
             int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
             
             if (userNameLabel.text.length > titleSplit) {
                 userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                 userNameLabel.numberOfLines=0;
             }
             [userNameLabel sizeToFit];
             
             [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
             [timeStampLabel sizeToFit];
             [messageLabel setFrame:CGRectMake(userNameLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
             
             
             [messageLabel setText:messageModel.content];
             
             
             
             int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
             if (messageModel.content.length> messageSplit) {
                 NSRange range = NSMakeRange (0, messageSplit);
                 messageLabel.text=[messageModel.content substringWithRange:range]  ;
             }
             
         }
         else if ([self.name isEqualToString:@"5_2_3"]||[self.name isEqualToString:@"3_1_2"])
                //text 15,30
         {
          
             if (userImageView.superview!=nil) {
                 [userImageView removeFromSuperview];
                 [aiv removeFromSuperview];
             }
             if (messageLabel2.superview!=nil) {
                 [messageLabel2 removeFromSuperview  ];
             }
             userNameLabel.frame=CGRectMake(15, 30, 340, 21);
             int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
             
             if (userNameLabel.text.length > titleSplit) {
                 userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                 userNameLabel.numberOfLines=0;
             }
             [userNameLabel sizeToFit];
             
             [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
             [timeStampLabel sizeToFit];
             [messageLabel setFrame:CGRectMake(userNameLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
             
             
             [messageLabel setText:messageModel.content];
             
             
             
             int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
             if (messageModel.content.length> messageSplit) {
                 NSRange range = NSMakeRange (0, messageSplit);
                 messageLabel.text=[messageModel.content substringWithRange:range]  ;
             }
             
         }

         else if ([self.name isEqualToString:@"5_2_1"]||[self.name isEqualToString:@"3_1_1"])
         //img 30,30
         {
               userImageView.frame=CGRectMake(30, 30, 340, 234);
             
             if (messageModel.images.count>0) {
                 if (userImageView.superview==nil) {
                     [contentView addSubview:userImageView];
                     aiv.frame=userImageView.frame;
                     [contentView addSubview:aiv];
                     userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                     userImageView.layer.borderWidth=1.0f;
                     
                 }
               
                 userNameLabel.frame=CGRectMake(userImageView.frame.origin.x,userImageView.frame.origin.y+userImageView.frame.size.height+20, 340, 21);
             }
             else
             {
                 userNameLabel.frame=CGRectMake(30, 30, 340, 21);
             }
             int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
             
             if (userNameLabel.text.length > titleSplit) {
                 userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                 userNameLabel.numberOfLines=0;
             }
             [userNameLabel sizeToFit];
             
             [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
             [timeStampLabel sizeToFit];
             [messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
           
             if(messageLabel2.superview!=nil)
             {
                 [messageLabel2 removeFromSuperview];
             }
             
             [messageLabel setText:messageModel.content];
             
             
             
             int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
             if (messageModel.content.length> messageSplit) {
                 NSRange range = NSMakeRange (0, messageSplit);
                 messageLabel.text=[messageModel.content substringWithRange:range]  ;
               
                 
             }
             
             //    [messageLabel sizeToFit];
             
             // [messageLabel2 sizeToFit];
         }
         else if ([self.name isEqualToString:@"5_2_2"]||[self.name isEqualToString:@"4_1_2"]||[self.name isEqualToString:@"3_2_2"])
         //img 30,15
         {
             
             userImageView.frame=CGRectMake(30, 15, 340, 234);
             if (messageModel.images.count>0) {
                 if (userImageView.superview==nil) {
                     [contentView addSubview:userImageView];
                     aiv.frame=userImageView.frame;
                     [contentView addSubview:aiv];
                     userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                     userImageView.layer.borderWidth=1.0f;
                     
                 }
                 
                 userNameLabel.frame=CGRectMake(userImageView.frame.origin.x,userImageView.frame.origin.y+userImageView.frame.size.height+20, 340, 21);
             }
             else
             {
                 userNameLabel.frame=CGRectMake(30, 30, 340, 21);
             }
             int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
             
             if (userNameLabel.text.length > titleSplit) {
                 userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                 userNameLabel.numberOfLines=0;
             }
             [userNameLabel sizeToFit];
             
             [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
             [timeStampLabel sizeToFit];
             [messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
             
             if(messageLabel2.superview!=nil)
             {
                 [messageLabel2 removeFromSuperview];
             }
             
             [messageLabel setText:messageModel.content];
             
             
             
             int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
             if (messageModel.content.length> messageSplit) {
                 NSRange range = NSMakeRange (0, messageSplit);
                 messageLabel.text=[messageModel.content substringWithRange:range]  ;
                 
                 
             }
             
             //    [messageLabel sizeToFit];
             
             // [messageLabel2 sizeToFit];
         }
         else if ([self.name isEqualToString:@"5_2_4"]||[self.name isEqualToString:@"4_2_2"]||[self.name isEqualToString:@"3_1_3"]||[self.name isEqualToString:@"3_2_3"])
           //img 15,15
         {
           
             userImageView.frame=CGRectMake(15, 15, 340, 234);
             if (messageModel.images.count>0) {
                 if (userImageView.superview==nil) {
                     [contentView addSubview:userImageView];
                     aiv.frame=userImageView.frame;
                     [contentView addSubview:aiv];
                     
                     userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                     userImageView.layer.borderWidth=1.0f;
                 }
                 
                 userNameLabel.frame=CGRectMake(userImageView.frame.origin.x,userImageView.frame.origin.y+userImageView.frame.size.height+20, 340, 21);
             }
             else
             {
                 userNameLabel.frame=CGRectMake(30, 30, 340, 21);
             }
             int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
             
             if (userNameLabel.text.length > titleSplit) {
                 userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                 userNameLabel.numberOfLines=0;
             }
             [userNameLabel sizeToFit];
             
             [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
             [timeStampLabel sizeToFit];
             [messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
             
             if(messageLabel2.superview!=nil)
             {
                 [messageLabel2 removeFromSuperview];
             }
             
             [messageLabel setText:messageModel.content];
             
             
             
             int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
             if (messageModel.content.length> messageSplit) {
                 NSRange range = NSMakeRange (0, messageSplit);
                 messageLabel.text=[messageModel.content substringWithRange:range]  ;
                 
                 
             }
             
             //    [messageLabel sizeToFit];
             
             // [messageLabel2 sizeToFit];
         }
      
         else
         {
          //  for (UIView* u in contentView.subviews) {
         //            [u removeFromSuperview];
          //   }
          //  UILabel* label=[[UILabel alloc]init];
         //   label.frame=CGRectMake(0, 0, 100, 21);
          //  label.text=name;
          //  [contentView addSubview:label];
         }
}
    else if (currrentInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || currrentInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        if ([self.name isEqualToString:@"5_1_1"]||[self.name isEqualToString:@"4_2_1"]||[self.name isEqualToString:@"3_1_1"])
              //imgb 30,30 Landscape
        {
            userImageView.frame=CGRectMake(30, 30, 468, 320);
          
            if (messageModel.images.count>0) {
                if (userImageView.superview==nil) {
                    [contentView addSubview:userImageView];
                    aiv.frame=userImageView.frame;
                    [contentView addSubview:aiv];
                    userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                    userImageView.layer.borderWidth=1.0f;
                    
                }
                
                userNameLabel.frame=CGRectMake(userImageView.frame.origin.x,userImageView.frame.origin.y+userImageView.frame.size.height+20, 465, 21);
            }
            else
            {
                userNameLabel.frame=CGRectMake(30, 30, 465, 21);
            }
            int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
            
            if (userNameLabel.text.length > titleSplit) {
                userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                userNameLabel.numberOfLines=0;
            }
            [userNameLabel sizeToFit];
            
            [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
            [timeStampLabel sizeToFit];
            [messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 465, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
                       
            if(messageLabel2.superview!=nil)
            {
                [messageLabel2 removeFromSuperview];
            }
            
          
            
            
            
            int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
            if (messageModel.content.length> messageSplit) {
                NSRange range = NSMakeRange (0, messageSplit);
                messageLabel.text=[messageModel.content substringWithRange:range]  ;
                
                
            }
            
                [messageLabel sizeToFit];
            
            
        }
        else if ([self.name isEqualToString:@"5_1_2"]||[self.name isEqualToString:@"5_2_5"]||[self.name isEqualToString:@"4_2_2"]||[self.name isEqualToString:@"3_1_2"])
             //text 15,30 Landscape
        {
           
            if (userImageView.superview!=nil) {
                [userImageView removeFromSuperview];
                [aiv removeFromSuperview];
            }
            userNameLabel.frame=CGRectMake(15, 30, self.frame.size.width-30, 21);
            int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
            
            if (userNameLabel.text.length > titleSplit) {
                userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                userNameLabel.numberOfLines=0;
            }
            [userNameLabel sizeToFit];
            
            [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+10, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
            [timeStampLabel sizeToFit];
            [messageLabel setFrame:CGRectMake(userNameLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+10), self.frame.size.width-30, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+10))];
            
            
            [messageLabel setText:messageModel.content];
            
            
            
            int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
            if (messageModel.content.length> messageSplit) {
                NSRange range = NSMakeRange (0, messageSplit);
                messageLabel.text=[messageModel.content substringWithRange:range]  ;
            }
            
        }
        else if ([self.name isEqualToString:@"5_1_3"]||[self.name isEqualToString:@"5_1_5"])
            //text 15,15 Landscape
        {
            
            if (userImageView.superview!=nil) {
                [userImageView removeFromSuperview];
                [aiv removeFromSuperview];
            }
            userNameLabel.frame=CGRectMake(15, 15, 220, 21);
            int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
            
            if (userNameLabel.text.length > titleSplit) {
                userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                userNameLabel.numberOfLines=0;
            }
            [userNameLabel sizeToFit];
            
            [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
            [timeStampLabel sizeToFit];
            [messageLabel setFrame:CGRectMake(userNameLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 220, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
            
            
            [messageLabel setText:messageModel.content];
            
            
            
            int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
            if (messageModel.content.length> messageSplit) {
                NSRange range = NSMakeRange (0, messageSplit);
                messageLabel.text=[messageModel.content substringWithRange:range]  ;
            }
            
        }
       else if ([self.name isEqualToString:@"5_1_4"]||[self.name isEqualToString:@"4_2_3"])
            //img 15,30 Landscape
        {
            
            userImageView.frame=CGRectMake(15, 30, 220, 140);
            if (messageModel.images.count>0) {
                if (userImageView.superview==nil) {
                    [contentView addSubview:userImageView];
                    aiv.frame=userImageView.frame;
                    [contentView addSubview:aiv];
                    
                    userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                    userImageView.layer.borderWidth=1.0f;
                }
                
                userNameLabel.frame=CGRectMake(userImageView.frame.origin.x,userImageView.frame.origin.y+userImageView.frame.size.height+15, 220, 21);
            }
            else
            {
                userNameLabel.frame=CGRectMake(30, 30, 220, 21);
            }
            int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
            
            if (userNameLabel.text.length > titleSplit) {
                userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                userNameLabel.numberOfLines=0;
            }
            [userNameLabel sizeToFit];
            
            [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
            [timeStampLabel sizeToFit];
            [messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), 220, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
            
            if(messageLabel2.superview!=nil)
            {
                [messageLabel2 removeFromSuperview];
            }
            
            [messageLabel setText:messageModel.content];
            
            
            
            int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
            if (messageModel.content.length> messageSplit) {
                NSRange range = NSMakeRange (0, messageSplit);
                messageLabel.text=[messageModel.content substringWithRange:range]  ;
                
                
            }
            
            //    [messageLabel sizeToFit];
            
            // [messageLabel2 sizeToFit];
        }
       else if ([self.name isEqualToString:@"5_2_4"])
           //text 30,30 Landscape
       {
           
           if (userImageView.superview!=nil) {
               [userImageView removeFromSuperview];
               [aiv removeFromSuperview];
           }
           userNameLabel.frame=CGRectMake(30, 30, 220, 21);
           int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
           
           if (userNameLabel.text.length > titleSplit) {
               userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
               userNameLabel.numberOfLines=0;
           }
           [userNameLabel sizeToFit];
           
           [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+20, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
           [timeStampLabel sizeToFit];
           [messageLabel setFrame:CGRectMake(userNameLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 220, self.frame.size.height-15 - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20))];
           
           
           [messageLabel setText:messageModel.content];
           
           
           
           int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
           if (messageModel.content.length> messageSplit) {
               NSRange range = NSMakeRange (0, messageSplit);
               messageLabel.text=[messageModel.content substringWithRange:range]  ;
           }
           
           
           
       }
       else if ([self.name isEqualToString:@"5_2_2"]||[self.name isEqualToString:@"4_1_4"]||[self.name isEqualToString:@"4_2_4"]||[self.name isEqualToString:@"3_1_3"]||[self.name isEqualToString:@"3_2_3"])
            //img2r 15,15 Landscape
        {
            
            userImageView.frame=CGRectMake(260, 15, 220, 150);
            if (messageModel.images.count>0) {
                if (userImageView.superview==nil) {
                    [contentView addSubview:userImageView];
                    aiv.frame=userImageView.frame;
                    [contentView addSubview:aiv];
                    userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                    userImageView.layer.borderWidth=1.0f;
                }
                
                userNameLabel.frame=CGRectMake(15,15, 230, 21);
                messageLabel.frame=CGRectMake(15,15, 230, 21);
            }
            else
            {
                userNameLabel.frame=CGRectMake(15, 15, 465, 21);
                 messageLabel.frame=CGRectMake(15,15, 465, 21);
                
            }
            int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
            
            if (userNameLabel.text.length > titleSplit) {
                userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                userNameLabel.numberOfLines=0;
            }
            [userNameLabel sizeToFit];
            
            [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
            [timeStampLabel sizeToFit];
            if (messageModel.images.count>0)
            {
                [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, (userImageView.frame.origin.y + userImageView.frame.size.height)-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
                messageLabel2.frame=CGRectMake(15 ,(userImageView.frame.origin.y + userImageView.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-30);
            }
            else
            {
                [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, 150-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
                messageLabel2.frame=CGRectMake(15 ,(messageLabel.frame.origin.y + messageLabel.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-30);
            }
            if(messageLabel2.superview==nil)
            {
                [contentView addSubview:messageLabel2];
            }
            
            [messageLabel setText:messageModel.content];
            
            
            
            int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
            if (messageModel.content.length> messageSplit) {
                NSRange range = NSMakeRange (0, messageSplit);
                messageLabel.text=[messageModel.content substringWithRange:range]  ;
                NSRange range2 = NSMakeRange (messageSplit, messageModel.content.length-messageSplit);
                NSString* message2=[messageModel.content substringWithRange:range2]  ;
                message2= [message2 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                int messageSplit2=[AppDelegate getSplitIndexWithString:message2 frame:messageLabel2.frame andFont:messageLabel2.font];
                NSRange range3 = NSMakeRange (0, messageSplit2);
                messageLabel2.text=[message2 substringWithRange:range3]  ;
                
            }
            
            //    [messageLabel sizeToFit];
            
            // [messageLabel2 sizeToFit];
        }
       else if ([self.name isEqualToString:@"5_2_3"]||[self.name isEqualToString:@"4_1_3"])
           //img2r 15,30 Landscape
       {
           
           userImageView.frame=CGRectMake(260, 30, 220, 150);
           if (messageModel.images.count>0) {
               if (userImageView.superview==nil) {
                   [contentView addSubview:userImageView];
                   aiv.frame=userImageView.frame;
                   [contentView addSubview:aiv];
                   userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                   userImageView.layer.borderWidth=1.0f;
               }
               
               userNameLabel.frame=CGRectMake(15,30, 230, 21);
                messageLabel.frame=CGRectMake(15,30, 230, 21);
           }
           else
           {
               userNameLabel.frame=CGRectMake(15, 30, 465, 21);
                messageLabel.frame=CGRectMake(15,30, 465, 21);
           }
           int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
           
           if (userNameLabel.text.length > titleSplit) {
               userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
               userNameLabel.numberOfLines=0;
           }
           [userNameLabel sizeToFit];
           
           [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
           [timeStampLabel sizeToFit];
           if (messageModel.images.count>0)
           {
               [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, (userImageView.frame.origin.y + userImageView.frame.size.height)-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
               messageLabel2.frame=CGRectMake(15 ,(userImageView.frame.origin.y + userImageView.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-15);
           }
           else
           {
               [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, 150-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
               messageLabel2.frame=CGRectMake(15 ,(messageLabel.frame.origin.y + messageLabel.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-15);
           }
           if(messageLabel2.superview==nil)
           {
               [contentView addSubview:messageLabel2];
           }
           
           [messageLabel setText:messageModel.content];
           
           
           
           int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
           if (messageModel.content.length> messageSplit) {
               NSRange range = NSMakeRange (0, messageSplit);
               messageLabel.text=[messageModel.content substringWithRange:range]  ;
               NSRange range2 = NSMakeRange (messageSplit, messageModel.content.length-messageSplit);
               NSString* message2=[messageModel.content substringWithRange:range2]  ;
               message2= [message2 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
               int messageSplit2=[AppDelegate getSplitIndexWithString:message2 frame:messageLabel2.frame andFont:messageLabel2.font];
               NSRange range3 = NSMakeRange (0, messageSplit2);
               messageLabel2.text=[message2 substringWithRange:range3]  ;
               
           }
           
           //    [messageLabel sizeToFit];
           
           // [messageLabel2 sizeToFit];
       }
       else if ([self.name isEqualToString:@"5_2_1"]||[self.name isEqualToString:@"4_1_2"]||[self.name isEqualToString:@"3_2_2"]||[self.name isEqualToString:@"2_2"])
           //img2r 30,15 Landscape
       {
           
           userImageView.frame=CGRectMake(275, 15, 220, 150);
           if (messageModel.images.count>0) {
               if (userImageView.superview==nil) {
                   [contentView addSubview:userImageView];
                   aiv.frame=userImageView.frame;
                   [contentView addSubview:aiv];
                   userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                   userImageView.layer.borderWidth=1.0f;
               }
               
               userNameLabel.frame=CGRectMake(30,15, 230, 21);
                messageLabel.frame=CGRectMake(30,15, 230, 21);
           }
           else
           {
               userNameLabel.frame=CGRectMake(30, 15, 465, 21);
                messageLabel.frame=CGRectMake(30,15, 465, 21);
           }
           int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
           
           if (userNameLabel.text.length > titleSplit) {
               userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
               userNameLabel.numberOfLines=0;
           }
           [userNameLabel sizeToFit];
           
           [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
           [timeStampLabel sizeToFit];
           if (messageModel.images.count>0)
           {
               [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, (userImageView.frame.origin.y + userImageView.frame.size.height)-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
               messageLabel2.frame=CGRectMake(30 ,(userImageView.frame.origin.y + userImageView.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-30);
           }
           else
           {
               [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, 150-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
               messageLabel2.frame=CGRectMake(30 ,(messageLabel.frame.origin.y + messageLabel.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-30);
           }
           if(messageLabel2.superview==nil)
           {
               [contentView addSubview:messageLabel2];
           }
           
           [messageLabel setText:messageModel.content];
           
           
           
           int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
           if (messageModel.content.length> messageSplit) {
               NSRange range = NSMakeRange (0, messageSplit);
               messageLabel.text=[messageModel.content substringWithRange:range]  ;
               NSRange range2 = NSMakeRange (messageSplit, messageModel.content.length-messageSplit);
               NSString* message2=[messageModel.content substringWithRange:range2]  ;
               message2= [message2 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
               int messageSplit2=[AppDelegate getSplitIndexWithString:message2 frame:messageLabel2.frame andFont:messageLabel2.font];
               NSRange range3 = NSMakeRange (0, messageSplit2);
               messageLabel2.text=[message2 substringWithRange:range3]  ;
               
           }
           
           //    [messageLabel sizeToFit];
           
           // [messageLabel2 sizeToFit];
       }
       else if ([self.name isEqualToString:@"4_1_1"]||[self.name isEqualToString:@"2_1"]||[self.name isEqualToString:@"1_1"])
           //img2r 30,30 Landscape
       {
           
           userImageView.frame=CGRectMake(275, 30, 220, 150);
           if (messageModel.images.count>0) {
               if (userImageView.superview==nil) {
                   [contentView addSubview:userImageView];
                   aiv.frame=userImageView.frame;
                   [contentView addSubview:aiv];
                   userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                   userImageView.layer.borderWidth=1.0f;
               }
               
               userNameLabel.frame=CGRectMake(30,30, 230, 21);
                messageLabel.frame=CGRectMake(30,30, 230, 21);
           }
           else
           {
               userNameLabel.frame=CGRectMake(30, 30, 465, 21);
                messageLabel.frame=CGRectMake(30,30, 465, 21);
           }
           int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
           
           if (userNameLabel.text.length > titleSplit) {
               userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
               userNameLabel.numberOfLines=0;
           }
           [userNameLabel sizeToFit];
           
           [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
           [timeStampLabel sizeToFit];
            if (messageModel.images.count>0)
            {
           [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, (userImageView.frame.origin.y + userImageView.frame.size.height)-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
                
            messageLabel2.frame=CGRectMake(30 ,(userImageView.frame.origin.y + userImageView.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-15);
            }
           else
           {
               [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15), messageLabel.frame.size.width, 150-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15))];
               messageLabel2.frame=CGRectMake(30 ,(messageLabel.frame.origin.y + messageLabel.frame.size.height), 465, self.frame.size.height-(messageLabel.frame.origin.y + messageLabel.frame.size.height)-15);
           }

           if(messageLabel2.superview==nil)
           {
               [contentView addSubview:messageLabel2];
           }
           
           [messageLabel setText:messageModel.content];
           
           
           
           int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
           if (messageModel.content.length> messageSplit) {
               NSRange range = NSMakeRange (0, messageSplit);
               messageLabel.text=[messageModel.content substringWithRange:range]  ;
               NSRange range2 = NSMakeRange (messageSplit, messageModel.content.length-messageSplit);
               NSString* message2=[messageModel.content substringWithRange:range2]  ;
               message2= [message2 stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
               int messageSplit2=[AppDelegate getSplitIndexWithString:message2 frame:messageLabel2.frame andFont:messageLabel2.font];
               NSRange range3 = NSMakeRange (0, messageSplit2);
               messageLabel2.text=[message2 substringWithRange:range3]  ;
               
           }
           
           //    [messageLabel sizeToFit];
           
           // [messageLabel2 sizeToFit];
       }
        else if([self.name isEqualToString:@"3_2_1"])
        {
            
            userImageView.frame=CGRectMake(547, 30, 445, 306);
            if (messageModel.images.count>0) {
                if (userImageView.superview==nil) {
                    [contentView addSubview:userImageView];
                    aiv.frame=userImageView.frame;
                    [contentView addSubview:aiv];
                    userImageView.layer.borderColor=RGBCOLOR(144, 144, 144).CGColor;
                    userImageView.layer.borderWidth=1.0f;
                }
                
                userNameLabel.frame=CGRectMake(30,30, 510, 21);
            }
            else
            {
                userNameLabel.frame=CGRectMake(30, 30, 510, 21);
            }
            int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
            
            if (userNameLabel.text.length > titleSplit) {
                userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
                userNameLabel.numberOfLines=0;
            }
            [userNameLabel sizeToFit];
            
            [timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+15, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
            [timeStampLabel sizeToFit];
            [messageLabel setFrame:CGRectMake(timeStampLabel.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15),465, self.frame.size.height-(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+15)-15)];
    
            if(messageLabel2.superview!=nil)
            {
                [messageLabel2 removeFromSuperview];
            }
            
            [messageLabel setText:messageModel.content];
            
            
            
            int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
            if (messageModel.content.length> messageSplit) {
                NSRange range = NSMakeRange (0, messageSplit);
                messageLabel.text=[messageModel.content substringWithRange:range]  ;
             
                
            }
            
            //    [messageLabel sizeToFit];
            
            // [messageLabel2 sizeToFit];
        }
        else
        {
       // for (UIView* u in contentView.subviews) {
      //      [u removeFromSuperview];
      //  }
       // UILabel* label=[[UILabel alloc]init];
       //label.frame=CGRectMake(0, 0, 100, 21);
       // label.text=name;
       // [contentView addSubview:label];
            
        }
    }
}
- (void)reAdjustLayout2{
    if(messageModel.images.count==0 )
    {
     
    
            [userImageView setFrame:CGRectMake(15 , 15-20, 340, 0)];
              
    }
    if(self.frame.origin.x>=340)
    {
        [userImageView setFrame:CGRectMake(15 , userImageView.frame.origin.y , userImageView.frame.size.width, userImageView.frame.size.height)];
    }
    else
    {
          [userImageView setFrame:CGRectMake(30 , userImageView.frame.origin.y , userImageView.frame.size.width, userImageView.frame.size.height)];
    }


	[contentView setFrame:CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height - 2)];
	
	CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 20), (contentView.frame.size.height-30));
	
	[userNameLabel sizeToFit];
  
	[timeStampLabel sizeToFit];
	[timeStampLabel setFrame:CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.origin.y + userNameLabel.frame.size.height+13, timeStampLabel.frame.size.width, timeStampLabel.frame.size.height)];
    [messageLabel2 removeFromSuperview];
	        if (currrentInterfaceOrientation == UIInterfaceOrientationPortrait || currrentInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            {
                	[messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), 340, contentViewArea.height - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height))];
                if (contentViewArea.width>700) {
                    messageLabel2.frame=CGRectMake(contentViewArea.width/2+15, 15, 340, contentViewArea.height-30);
                    [contentView addSubview:messageLabel2];
                    
                }
             
            }else
            {
                	[messageLabel setFrame:CGRectMake(userImageView.frame.origin.x ,(timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height+20), contentViewArea.width, contentViewArea.height - (timeStampLabel.frame.origin.y + timeStampLabel.frame.size.height))];
            }

		
		
	[messageLabel setText:messageModel.content];
	messageLabel.contentMode = UITextAlignmentLeft;
    messageLabel2.contentMode=UITextAlignmentLeft;
//		float widthOffset = (messageLabel.frame.size.width - textSize.width)/ 2;
//		float heightOffset = (messageLabel.frame.size.height - textSize.height)/2;
		//[messageLabel setContentInset:UIEdgeInsetsMake(heightOffset, widthOffset, heightOffset, widthOffset)];
    int titleSplit=[AppDelegate getSplitIndexWithString:userNameLabel.text frame:userNameLabel.frame andFont:userNameLabel.font];
    
    if (userNameLabel.text.length > titleSplit) {
        userNameLabel.lineBreakMode=UILineBreakModeWordWrap;
        userNameLabel.numberOfLines=0;
    }
    if (contentViewArea.width>700) {
        int messageSplit=[AppDelegate getSplitIndexWithString:messageModel.content frame:messageLabel.frame andFont:messageLabel.font];
        if (messageModel.content.length> messageSplit) {
             NSRange range = NSMakeRange (0, messageSplit);
            messageLabel.text=[messageModel.content substringWithRange:range]  ;
            NSRange range2 = NSMakeRange (messageSplit, messageModel.content.length-messageSplit);
            messageLabel2.text=[messageModel.content substringWithRange:range2]  ;
        }
    }
    

}
- (void)loadImage:(NSString*)strURL {
  
    UIImage* image = [[AppDelegate instance] indexImageWithURL:strURL];
    
            [self displayImage:image];
    
   
   // [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
}

- (void)displayImage:(UIImage *)image {
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView beginAnimations:nil context:nil];
    userImageView.alpha=0;
    [userImageView setImage:image]; //UIImageView
    [aiv stopAnimating];
  [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  userImageView.alpha=1;  

   [UIView commitAnimations];
}

- (void) initializeFields {
	contentView = [[UIView alloc] init];
            aiv=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(15, 15, 340, 234)];
    aiv.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
	[contentView setBackgroundColor:[UIColor whiteColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      userImageView = [[UIImageView alloc] init];
	theWebView=[[UIWebView alloc]init];
    if( messageModel.images.count>0 )
    {
     
      
       
    if (messageModel.images.count>0) {

        
        aiv.hidesWhenStopped=YES;
        [aiv startAnimating];
        
        
        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                            initWithTarget:self
                                            selector:@selector(loadImage:) 
                                            object:[messageModel.images objectAtIndex:0]];
        [queue addOperation:operation]; 
      
        
       // userImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[messageModel.images objectAtIndex:0]]]];
    }
  
	//userImageView.image = [UIImage imageNamed:messageModel.images];
	//[userImageView setFrame:CGRectMake(10, 10, 50, 50)];
 
	
    }
    else
    {

        
        [userImageView setFrame:CGRectMake(15 , 15-20, 340, 0)];
        if(self.frame.origin.x>=384)
        {
        }
        else
        {
             [userImageView setFrame:CGRectMake(30 , 15-20, 340, 0)];
        }
    }
	userNameLabel = [[UILabel alloc] init];
    	userNameLabel.font =[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24];


	[userNameLabel setText:[NSString stringWithFormat:@"%@",messageModel.title]];

   
	[userNameLabel setTextColor:RGBCOLOR(51,51,51)];

	[userNameLabel setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:userNameLabel];
	
	
	timeStampLabel = [[UILabel alloc] init];
	[timeStampLabel setText:messageModel.date];
	timeStampLabel.font =[UIFont fontWithName:@"HelveticaNeue" size:14];
	[timeStampLabel setTextColor:RGBCOLOR(11,64,2)];
	[timeStampLabel setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:timeStampLabel];
	
	messageLabel = [[UILabel alloc] init];
	messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
	messageLabel.textColor =  RGBCOLOR(51,51,51);
	messageLabel.highlightedTextColor = RGBCOLOR(33,33,33);
	messageLabel.contentMode = UIViewContentModeCenter;
	messageLabel.textAlignment = UITextAlignmentLeft;
	[messageLabel setBackgroundColor:[UIColor whiteColor]];
	messageLabel.numberOfLines = 0;
    
	[contentView addSubview:messageLabel];
	
    messageLabel2 = [[UILabel alloc] init];
	messageLabel2.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
	messageLabel2.textColor =  RGBCOLOR(51,51,51);
	messageLabel2.highlightedTextColor = RGBCOLOR(33,33,33);
	messageLabel2.contentMode = UIViewContentModeCenter;
	messageLabel2.textAlignment = UITextAlignmentLeft;
	[messageLabel2 setBackgroundColor:[UIColor whiteColor]];
	messageLabel2.numberOfLines = 0;
	[contentView addSubview:messageLabel2];
    
	[self addSubview:contentView];
	
	[self reAdjustLayout];
}

-(void)tapped:(UITapGestureRecognizer *)recognizer {
	[[AppDelegate instance] showViewInFullScreen:self withModel:self.messageModel Mode:@"index"];
}


-(void) setFrame:(CGRect)rect {
		self.originalRect = rect;
		[super setFrame:rect];
}
-(void)dealloc
{
 contentView=nil;
    theWebView=nil;
userNameLabel=nil;
	timeStampLabel=nil;
	 messageLabel=nil;
    messageLabel2=nil;
     aiv=nil;
    self.messageModel=nil;
    self.userImageView=nil;
    self.name=nil;
    
}



@end
