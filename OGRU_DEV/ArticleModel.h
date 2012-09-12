//
//  Article.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
{
    NSString* articleId;
     NSString* title;
     NSString* date;
     NSMutableArray* images;
    NSString* content;
}
@property (nonatomic,copy) NSString* articleId;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* date;
@property (nonatomic,retain) NSMutableArray* images;
@property (nonatomic,copy) NSString* content;
@end
