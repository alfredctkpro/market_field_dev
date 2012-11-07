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
{
    BOOL _isFinishLoad;
}
@synthesize messageModel,name,isFinishLoad=_isFinishLoad,delegate;

- (id) initWithMessageModel:(ArticleModel*)messagemodel WithName:(NSString *)n{
	if (self = [super init]) {

		self.messageModel = messagemodel;
        self.name=n ;
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        tapRecognizer.delegate=self;
    
		[theWebView addGestureRecognizer:tapRecognizer];


	}
	return self;
}

- (void)reAdjustLayout{

    _isFinishLoad=NO;

    theWebView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    NSString* dateColor=[[AppDelegate instance].configs objectForKey:@"ThemeColorHTML"];
               NSString* str=[self removeBR:messageModel.content];
    //NSString* str=messageModel.content;
    NSString*path= [[NSBundle mainBundle] pathForResource:@"jquery-1.8.2.min" ofType:@"js"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];


 
     if (currrentInterfaceOrientation == UIInterfaceOrientationPortrait || currrentInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
     {

         if ([self.name isEqualToString:@"5_1_1"])
         {
           
             float top=30;
             float right=30;
             float bottom=15;
             float left=30;
      

             if (messageModel.images.count>0) {
                 if (str.length>1100) {
                     str=[str substringWithRange:NSMakeRange(0, 1100)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>2000) {
                     str=[str substringWithRange:NSMakeRange(0, 2000)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"5_1_2"])
         {
             if (str.length>300) {
                 str=[str substringWithRange:NSMakeRange(0, 300)];
             }
             float top=15;
             float right=15;
             float bottom=15;
             float left=30;
             
             
       
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"5_1_3"])
         {
             if (str.length>300) {
                 str=[str substringWithRange:NSMakeRange(0, 300)];
             }
             float top=15;
             float right=30;
             float bottom=15;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
           
             
         }
         else if ([self.name isEqualToString:@"5_1_4"])
         {
             if (str.length>300) {
                 str=[str substringWithRange:NSMakeRange(0, 300)];
             }
             float top=15;
             float right=15;
             float bottom=30;
             float left=30;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"5_1_5"])
         {
             if (str.length>300) {
                 str=[str substringWithRange:NSMakeRange(0, 300)];
             }
             float top=15;
             float right=30;
             float bottom=30;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"5_2_1"])
         {
             
             float top=30;
             float right=15;
             float bottom=15;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>200) {
                     str=[str substringWithRange:NSMakeRange(0, 200)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>700) {
                     str=[str substringWithRange:NSMakeRange(0, 700)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"5_2_2"])
         {
             
             float top=15;
             float right=15;
             float bottom=30;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>200) {
                     str=[str substringWithRange:NSMakeRange(0, 200)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>700) {
                     str=[str substringWithRange:NSMakeRange(0, 700)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"5_2_3"])
         {
             if (str.length>300) {
                 str=[str substringWithRange:NSMakeRange(0, 300)];
             }
             float top=30;
             float right=30;
             float bottom=15;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"5_2_4"])
         {
             
             float top=15;
             float right=30;
             float bottom=15;
             float left=15;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>200) {
                     str=[str substringWithRange:NSMakeRange(0, 200)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>700) {
                     str=[str substringWithRange:NSMakeRange(0, 700)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"5_2_5"])
         {
             if (str.length>300) {
                 str=[str substringWithRange:NSMakeRange(0, 300)];
             }
             float top=15;
             float right=30;
             float bottom=30;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"4_1_1"])
         {
           
             float top=30;
             float right=30;
             float bottom=15;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>1100) {
                     str=[str substringWithRange:NSMakeRange(0, 1100)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>2000) {
                     str=[str substringWithRange:NSMakeRange(0, 2000)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"4_1_2"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=15;
             float right=15;
             float bottom=30;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"4_1_3"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=15;
             float right=30;
             float bottom=15;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"4_1_4"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=15;
             float right=30;
             float bottom=30;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"4_2_1"])
         {
             if (str.length>1100) {
                 str=[str substringWithRange:NSMakeRange(0, 1100)];
             }
             float top=30;
             float right=30;
             float bottom=15;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"4_2_3"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=15;
             float right=15;
             float bottom=15;
             float left=30;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"4_2_4"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=15;
             float right=15;
             float bottom=30;
             float left=30;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"4_2_2"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=15;
             float right=30;
             float bottom=30;
             float left=15;
             
             
             if (messageModel.images.count>0) {
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"3_1_1"])
         {
             
             float top=30;
             float right=15;
             float bottom=30;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>1100) {
                     str=[str substringWithRange:NSMakeRange(0, 1100)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>2000) {
                     str=[str substringWithRange:NSMakeRange(0, 2000)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"3_1_2"])
         {
             if (str.length>500) {
                 str=[str substringWithRange:NSMakeRange(0, 500)];
             }
             float top=30;
             float right=30;
             float bottom=15;
             float left=15;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"3_1_3"])
         {
             
             float top=15;
             float right=30;
             float bottom=30;
             float left=15;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>300) {
                     str=[str substringWithRange:NSMakeRange(0, 300)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>500) {
                     str=[str substringWithRange:NSMakeRange(0, 500)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"3_2_1"])
         {
             
             float top=30;
             float right=30;
             float bottom=15;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>1100) {
                     str=[str substringWithRange:NSMakeRange(0, 1100)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>2000) {
                     str=[str substringWithRange:NSMakeRange(0, 2000)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{-webkit-column-count:2;-webkit-column-gap:30px;text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"3_2_2"])
         {
             
             float top=15;
             float right=15;
             float bottom=30;
             float left=30;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>300) {
                     str=[str substringWithRange:NSMakeRange(0, 300)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>500) {
                     str=[str substringWithRange:NSMakeRange(0, 500)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"3_2_3"])
         {
             
             float top=15;
             float right=30;
             float bottom=30;
             float left=15;
             
             
             if (messageModel.images.count>0) {
                 if (str.length>300) {
                     str=[str substringWithRange:NSMakeRange(0, 300)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:335px;height:235px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
             else
             {
                 if (str.length>500) {
                     str=[str substringWithRange:NSMakeRange(0, 500)];
                 }
                 NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                 [theWebView loadHTMLString:desc baseURL:nil];
             }
         }
         else if ([self.name isEqualToString:@"2_1"])
         {
             if (str.length>2000) {
                 str=[str substringWithRange:NSMakeRange(0, 2000)];
             }
             float top=30;
             float right=30;
             float bottom=15;
             float left=30;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"2_2"])
         {
             if (str.length>2000) {
                 str=[str substringWithRange:NSMakeRange(0, 2000)];
             }
             float top=15;
             float right=30;
             float bottom=30;
             float left=30;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
         else if ([self.name isEqualToString:@"1_1"])
         {
             if (str.length>1000) {
                 str=[str substringWithRange:NSMakeRange(0, 1000)];
             }
             float top=30;
             float right=30;
             float bottom=30;
             float left=30;
             
             NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
             [theWebView loadHTMLString:desc baseURL:nil];
             
         }
       }
    else if (currrentInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || currrentInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        if (messageModel.images.count>0) {
            
            if (str.length>1100) {
                str=[str substringWithRange:NSMakeRange(0, 1100)];
            }
        }
        else
        {
            if (str.length>2000) {
                str=[str substringWithRange:NSMakeRange(0, 2000)];
            }
        }
        if ([self.name isEqualToString:@"5_1_1"])
        {
            
            float top=30;
            float right=15;
            float bottom=30;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:464px;height:322px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"5_1_2"])
        {
            
            float top=30;
            float right=15;
            float bottom=15;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"5_1_3"])
        {
            
            float top=15;
            float right=15;
            float bottom=30;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"5_1_4"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"5_1_5"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"5_2_1"])
        {
            
            float top=15;
            float right=15;
            float bottom=30;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"5_2_2"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"5_2_3"])
        {
            
            float top=30;
            float right=15;
            float bottom=15;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"5_2_4"])
        {
            
            float top=30;
            float right=15;
            float bottom=15;
            float left=30;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"5_2_5"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"4_1_1"])
        {
            
            float top=30;
            float right=15;
            float bottom=15;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"4_1_2"])
        {
            
            float top=15;
            float right=15;
            float bottom=30;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"4_1_3"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"4_1_4"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else  if ([self.name isEqualToString:@"4_2_1"])
        {
            
            float top=30;
            float right=15;
            float bottom=30;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:464px;height:322px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"4_2_2"])
        {
            
            float top=30;
            float right=15;
            float bottom=15;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"4_2_3"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"4_2_4"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else  if ([self.name isEqualToString:@"3_1_1"])
        {
            
            float top=30;
            float right=15;
            float bottom=30;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:464px;height:322px;margin-bottom:15px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"3_1_2"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=15;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"3_1_3"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"3_2_1"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=30;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:442px;height:306px;float:right;right:0px; \" src=\"%@\" /><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,[messageModel.images objectAtIndex:0], self.frame.size.width-(right+left)-446-15,self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"3_2_2"])
        {
            
            float top=15;
            float right=15;
            float bottom=30;
            float left=30;
            //text-align:left;
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"3_2_3"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=15;
            
            
            if (messageModel.images.count>0) {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><img style=\"border-style:solid;border-width:2px;border-color:#D2D2D2;width:216px;height:146px;float:right;right:0px; \" src=\"%@\" /><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left, self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),[messageModel.images objectAtIndex:0],messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
            else
            {
                NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
                [theWebView loadHTMLString:desc baseURL:nil];
            }
        }
        else if ([self.name isEqualToString:@"2_1"])
        {
            
            float top=30;
            float right=30;
            float bottom=15;
            float left=30;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"2_2"])
        {
            
            float top=15;
            float right=30;
            float bottom=30;
            float left=30;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
        else if ([self.name isEqualToString:@"1_1"])
        {
            
            float top=30;
            float right=30;
            float bottom=30;
            float left=30;
            
            NSString* desc= [[NSString alloc]initWithFormat:@"<html><head><meta charset=\"utf-8\" /><script type=\"text/javascript\" src=\"%@\"></script><script type=\"text/javascript\">(function($) {$.fn.ellipsis = function(){return this.each(function(){var el = $(this);if(el.css(\"overflow\") == \"hidden\"){var text = el.html();var multiline = el.hasClass('multiline');var t = $(this.cloneNode(true)).hide().css('position', 'absolute').css('overflow', 'visible').width(multiline ? el.width() : 'auto').height(multiline ? 'auto' : el.height());el.after(t);var el_height=el.height();function height() { return t.height() > el_height; };function width() { return t.width() > el.width(); };var func = multiline ? height : width;while (text.length > 0 && func()){text = text.substr(0, text.length - 20);t.html(text + \"...\");}el.html(t.html());t.remove();}});};})(jQuery);$(function(){$(\".multiline\").ellipsis();});</script><style type=\"text/css\">.content{text-align:justify;text-justify:inter-word;overflow:hidden;text-overflow:ellipsis;}a{color:gray;}</style></head><body style=\"margin: %fpx %fpx %fpx %fpx;background-color: trasparent;\"><div class=\"content multiline\" style=\"width: %fpx;height: %f px; \"><p style=\"font-family:HelveticaNeue-CondensedBold;font-size: 24px;margin-top: 0px;margin-bottom: 15px;color:#333333;text-align:left;\">%@</p><p style=\"font-family: HelveticaNeue;font-size: 14px;margin-top: 0px;margin-bottom: 15px;color:%@;\">%@</p><div style=\"font-family: HelveticaNeue-Light;font-size: 16px;color:#333333; \">%@</div></div></body></html>",fileURL,top,right,bottom,left,self.frame.size.width-(right+left),self.frame.size.height-(top+bottom),messageModel.title,dateColor,messageModel.date,str ];
            [theWebView loadHTMLString:desc baseURL:nil];
            
        }
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _isFinishLoad=YES;
    if (self.delegate !=nil) {
        [self.delegate titleAndTextViewDidFinishLoad:self];
    }

}

- (void) initializeFields {

    
	theWebView=[[UIWebView alloc]init];
    theWebView.opaque = NO;
  
    theWebView.backgroundColor = [UIColor clearColor];
    theWebView.scrollView.scrollEnabled=NO;
    theWebView.userInteractionEnabled=YES;
    theWebView.delegate=self;
    //[contentView addSubview:theWebView];
    
    
	[self addSubview:theWebView];
	
	//[self reAdjustLayout];
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

    theWebView=nil;

    self.messageModel=nil;

    self.name=nil;
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer
                                                    *)otherGestureRecognizer {
    return YES;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if(navigationType ==  UIWebViewNavigationTypeLinkClicked) {
		
		return NO;
	}
	else
		return YES;
}
-(NSString*)removeBR:(NSString*)input
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                  @"<br/><br/>" options:0 error:nil];
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:
                                   @"<br/>" options:0 error:nil];
    NSMutableString *str = [NSMutableString stringWithString:
                            input];
    [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"<br><br>"];
    [regex2 replaceMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
    regex=nil;
    regex2=nil;
    return str;
    
}

@end
