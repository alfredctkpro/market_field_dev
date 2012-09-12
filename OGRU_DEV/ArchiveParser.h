//
//  ArchiveParser.h
//  OGRU_DEV
//
//  Created by yu chihchung on 2012-07-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArchiveParser, ArticleModel;
@protocol ArchiveParserDelegate <NSObject>

@optional
// Called by the parser when parsing is finished.
- (void)parserDidEndParsingData:(ArchiveParser *)parser;
// Called by the parser in the case of an error.
- (void)parser:(ArchiveParser *)parser didFailWithError:(NSError *)error;
// Called by the parser when one or more songs have been parsed. This method may be called multiple times.
- (void)parser:(ArchiveParser *)parser didParseIndex:(NSArray *)parsedArticles;

@end
@interface ArchiveParser : NSObject<NSXMLParserDelegate>
{
    __unsafe_unretained id <ArchiveParserDelegate> delegate;
    NSMutableArray *parsedArticless;
  //  NSMutableDictionary *parsedSet;
    // This time interval is used to measure the overall time the parser takes to download and parse XML.
    NSTimeInterval startTimeReference;
    NSTimeInterval downloadStartTimeReference;
    double parseDuration;
    double downloadDuration;
    double totalDuration;
    
    NSMutableString *currentString;
    ArticleModel *currentArticle;
    BOOL storingCharacters;
    NSDateFormatter *parseFormatter;
    NSMutableData *xmlData;
    
    dispatch_semaphore_t semaphore ;
    
    NSURLConnection *rssConnection;
    // The number of parsed articles is tracked so that the autorelease pool for the parsing thread can be periodically
    // emptied to keep the memory footprint under control.
    NSUInteger countOfParsedArticles;
}
@property  (nonatomic,assign) id <ArchiveParserDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *parsedArticless;
@property NSTimeInterval startTimeReference;
@property NSTimeInterval downloadStartTimeReference;
@property double parseDuration;
@property double downloadDuration;
@property double totalDuration;

@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) ArticleModel *currentArticle;
@property (nonatomic, retain) NSDateFormatter *parseFormatter;
@property (nonatomic, retain) NSMutableData *xmlData;
@property (nonatomic, retain) NSURLConnection *rssConnection;
- (void)startWithYear:(NSString*) year Month:(NSString*)month;
// Subclasses must implement this method. It will be invoked on a secondary thread to keep the application responsive.
// Although NSURLConnection is inherently asynchronous, the parsing can be quite CPU intensive on the device, so
// the user interface can be kept responsive by moving that work off the main thread. This does create additional
// complexity, as any code which interacts with the UI must then do so in a thread-safe manner.
- (void)downloadAndParse:(NSURL *)url;

// Subclasses should invoke these methods and let the superclass manage communication with the delegate.
// Each of these methods must be invoked on the main thread.
- (void)downloadStarted;
- (void)downloadEnded;
- (void)parseEnded;
- (void)parsedArticle:(ArticleModel *)article;
- (void)parseError:(NSError *)error;
- (void)addToParseDuration:(NSNumber *)duration;
@end
