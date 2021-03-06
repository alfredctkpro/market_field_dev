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
//  Layout3.h
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import <Foundation/Foundation.h>
#import "LayoutViewExtention.h"
#import "TitleAndTextView.h"
@class UIViewExtention;

@interface Layout3_1 : LayoutViewExtention {
	TitleAndTextView* view1;
	TitleAndTextView* view2;
	TitleAndTextView* view3;
    UIView* borderLeftTop;
    UIView* borderLeftTop2;
    UIView* borderRightTop;
    UIView* borderLeftBottom;
}
@property (nonatomic,strong) TitleAndTextView* view1;
@property (nonatomic,strong) TitleAndTextView* view2;
@property (nonatomic,strong) TitleAndTextView* view3;

@end
