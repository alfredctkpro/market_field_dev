//
//  WebServiceHelper.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface WebServiceHelper : NSObject<NSXMLParserDelegate>
@property (nonatomic,strong)NSMutableString *currentString;
    

+(void)loginWithUsername:(NSString*)username Password:(NSString*)password Complete:(void (^)(NSString* result))complete Error:(void(^)(NSError* error))error;
@end
