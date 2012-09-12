//
//  WebServiceHelper.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebServiceHelper.h"

@implementation WebServiceHelper
@synthesize currentString;
- (id)init
{
    self = [super init];
    if (self) {
        currentString=[NSMutableString string];
    }
    return self;
}
- (void)dealloc
{
    [currentString release];
    [super dealloc];
}
+(void)loginWithUsername:(NSString *)username Password:(NSString *)password Complete:(void (^)(NSString*))complete Error:(void(^)(NSError* ))error
{

    NSURL *url=[NSURL URLWithString:@"http://ogru.com"];
    AFHTTPClient *httpClient=[[[AFHTTPClient alloc]initWithBaseURL:url] autorelease];
    //[httpClient defaultValueForHeader:@"Accept"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"UserID",
                            password,@"Pwd",
                            @"M",@"AppType",
                            nil];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"blog/validatelogin.aspx" parameters:params];
    
     AFXMLRequestOperation *operation=[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        WebServiceHelper* d=[[WebServiceHelper alloc]init];
        XMLParser.delegate=d;
     
        [XMLParser parse];
 
         complete(d.currentString);
         XMLParser.delegate=nil;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *_error, NSXMLParser *XMLParse) {
        error(_error);
    }];
    /*
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //呼叫json完成
        complete([[JSON valueForKeyPath:@"login_result"]boolValue]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *_error, id JSON) {
        //發生error
        error(_error);
    } ];
    */
    
    [operation start];

}
 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
        [currentString appendString:string];
         
 }
@end
