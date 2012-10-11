//
//  IndexParser.m
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IndexParser.h"
#import "ArticleModel.h"

static NSUInteger kCountForNotification = 60;

@implementation IndexParser

@synthesize  parsedArticless, startTimeReference, downloadStartTimeReference, parseDuration, downloadDuration, totalDuration;
@synthesize delegate;
@synthesize currentString, currentArticle, parseFormatter, xmlData, rssConnection;
- (void)start {
    self.startTimeReference = [NSDate timeIntervalSinceReferenceDate];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    self.parsedArticless = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:[[AppDelegate instance].configs objectForKey:@"IndexURL"]];
   
  //  url=[[NSURL alloc]initFileURLWithPath: [[NSBundle mainBundle]pathForResource:@"index" ofType:@"xml"]];
    [NSThread detachNewThreadSelector:@selector(downloadAndParse:) toTarget:self withObject:url];
}

- (void)downloadAndParse:(NSURL *)url {
//    @autoreleasepool {
        
        semaphore =  dispatch_semaphore_create(0);
        self.parseFormatter = [[NSDateFormatter alloc] init] ;
        [parseFormatter setDateStyle:NSDateFormatterLongStyle];
        [parseFormatter setTimeStyle:NSDateFormatterNoStyle];
        // necessary because iTunes RSS feed is not localized, so if the device region has been set to other than US
        // the date formatter must be set to US locale in order to parse the dates
        [parseFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"US"] ];
        self.xmlData = [NSMutableData data];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
        // create the connection with the request and start loading the data
        rssConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        [self performSelectorOnMainThread:@selector(downloadStarted) withObject:nil waitUntilDone:NO];
        if (rssConnection != nil) {
            while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
            }
        }
        self.rssConnection = nil;
        self.parseFormatter = nil;
        self.currentArticle = nil;
//    }
}


- (void)downloadStarted {
    NSAssert2([NSThread isMainThread], @"%s at line %d called on secondary thread", __FUNCTION__, __LINE__);
    self.downloadStartTimeReference = [NSDate timeIntervalSinceReferenceDate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)downloadEnded {
    NSAssert2([NSThread isMainThread], @"%s at line %d called on secondary thread", __FUNCTION__, __LINE__);
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - self.downloadStartTimeReference;
    downloadDuration += duration;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)parseEnded {
    NSAssert2([NSThread isMainThread], @"%s at line %d called on secondary thread", __FUNCTION__, __LINE__);
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:didParseIndex:)] && [parsedArticless count] > 0) {
        [self.delegate parser:self didParseIndex:parsedArticless];
    }
    [self.parsedArticless removeAllObjects];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parserDidEndParsingData:)]) {
        [self.delegate parserDidEndParsingData:self];
    }
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - self.startTimeReference;
    totalDuration = duration;
 //   NSLog(@"downloadDuration:%f, parseDuration:%f, totalDuration:%f", downloadDuration, parseDuration, totalDuration);
 //   WriteStatisticToDatabase([[self class] parserType], downloadDuration, parseDuration, totalDuration);
}

- (void)parsedArticle:(ArticleModel *)article{
    NSAssert2([NSThread isMainThread], @"%s at line %d called on secondary thread", __FUNCTION__, __LINE__);
    [self.parsedArticless addObject:article];
    if (self.parsedArticless.count >= kCountForNotification) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:didParseIndex:)]) {
            [self.delegate parser:self didParseIndex:parsedArticless];
        }
        [self.parsedArticless removeAllObjects];
    }
}

- (void)parseError:(NSError *)error {
    NSAssert2([NSThread isMainThread], @"%s at line %d called on secondary thread", __FUNCTION__, __LINE__);
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:didFailWithError:)]) {
        [self.delegate parser:self didFailWithError:error];
    }
}

- (void)addToParseDuration:(NSNumber *)duration {
    NSAssert2([NSThread isMainThread], @"%s at line %d called on secondary thread", __FUNCTION__, __LINE__);
    parseDuration += [duration doubleValue];
}
#pragma mark NSURLConnection Delegate methods

/*
 Disable caching so that each time we run this app we are starting with a clean slate. You may not want to do this in your application.
 */
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

// Forward errors to the delegate.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    dispatch_semaphore_signal(semaphore);
    [self performSelectorOnMainThread:@selector(parseError:) withObject:error waitUntilDone:NO];
}

// Called when a chunk of data has been downloaded.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the downloaded chunk of data.
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self performSelectorOnMainThread:@selector(downloadEnded) withObject:nil waitUntilDone:NO];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    parser.delegate = self;
    self.currentString = [NSMutableString string];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    [parser parse];
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    [self performSelectorOnMainThread:@selector(addToParseDuration:) withObject:[NSNumber numberWithDouble:duration] waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(parseEnded) withObject:nil waitUntilDone:NO];

    self.currentString = nil;
    self.xmlData = nil;
    // Set the condition which ends the run loop.
   dispatch_semaphore_signal(semaphore); 
}
#pragma mark Parsing support methods

static const NSUInteger kAutoreleasePoolPurgeFrequency = 20;

- (void)finishedCurrentSong {
    [self performSelectorOnMainThread:@selector(parsedArticle:) withObject:currentArticle waitUntilDone:NO];
    // performSelectorOnMainThread: will retain the object until the selector has been performed
    // setting the local reference to nil ensures that the local reference will be released
    self.currentArticle = nil;
    countOfParsedArticles++;
    // Periodically purge the autorelease pool. The frequency of this action may need to be tuned according to the 
    // size of the objects being parsed. The goal is to keep the autorelease pool from growing too large, but 
    // taking this action too frequently would be wasteful and reduce performance.
    if (countOfParsedArticles == kAutoreleasePoolPurgeFrequency) {
       // [downloadAndParsePool release];
      //  self.downloadAndParsePool = [[NSAutoreleasePool alloc] init];
        countOfParsedArticles = 0;
    }
}

#pragma mark NSXMLParser Parsing Callbacks

// Constants for the XML element names that will be considered during the parse. 
// Declaring these as static constants reduces the number of objects created during the run
// and is less prone to programmer error.
static NSString *kName_Item = @"article";
static NSString *kName_Id = @"id";
static NSString *kName_Title = @"title";
static NSString *kName_Date = @"date";
static NSString* kName_Image=@"thumbnail";
static NSString *kName_Contentt = @"content";


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kName_Item]) {
        self.currentArticle = [[ArticleModel alloc] init] ;
        self.currentArticle.images=[[NSMutableArray alloc]init];
    } else if ([elementName isEqualToString:kName_Title] || [elementName isEqualToString:kName_Id] || [elementName isEqualToString:kName_Date] || [elementName isEqualToString:kName_Image] || [elementName isEqualToString:kName_Contentt]) {
        [currentString setString:@""];
        storingCharacters = YES;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kName_Item]) {
        [self finishedCurrentSong];
    } else if ([elementName isEqualToString:kName_Title]) {
        currentArticle.title = currentString;
    } else if ([elementName isEqualToString:kName_Id]) {
        currentArticle.articleId = currentString;
    } else if ([elementName isEqualToString:kName_Date]) {
        currentArticle.date = currentString;
    } else if ([elementName isEqualToString:kName_Image]) {
        if (currentString!=nil) {
         
             [currentArticle.images addObject:[[NSString alloc]initWithString:currentString]];
        
        }
       
    } else if ([elementName isEqualToString:kName_Contentt]) {
        currentArticle.content = currentString;
    }
    storingCharacters = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (storingCharacters) [currentString appendString:string];
}

/*
 A production application should include robust error handling as part of its parsing implementation.
 The specifics of how errors are handled depends on the application.
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Handle errors as appropriate for your application.
}

-(void)dealloc
{
    self.delegate=nil;
    self.parsedArticless=nil;
    self.currentString=nil;
    self.currentArticle=nil;
  
    self.parseFormatter=nil;
    self.xmlData=nil;
    self.rssConnection=nil;
}

@end
