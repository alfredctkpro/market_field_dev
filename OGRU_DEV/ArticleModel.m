//
//  Article.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
@synthesize articleId,title,date,images,content;
- (void)dealloc
{
    self.articleId=nil;
    self.title=nil;
    self.date=nil;
    self.images=nil;
    self.content=nil;
  
}
@end
