//
//  OGRU_DEVTests.m
//  OGRU_DEVTests
//
//  Created by yu chihchung on 2012-06-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OGRU_DEVTests.h"

@implementation OGRU_DEVTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [WebServiceHelper loginWithUsername:@"admin"
                               Password:@"test"
                               Complete:^(BOOL result) {
                                   STAssertTrue(result,nil);
                                   dispatch_semaphore_signal(semaphore);
                               } 
                                  Error:^(NSError *error) {
                              dispatch_semaphore_signal(semaphore);
                                  }
     ];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    
    dispatch_release(semaphore);
    
}
- (void)testExample2
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [WebServiceHelper loginWithUsername:@"admin"
                               Password:@"admin"
                               Complete:^(BOOL result) {
                                   STAssertFalse(result,nil);
                                   dispatch_semaphore_signal(semaphore);
                               } 
                                  Error:^(NSError *error) {
                                      dispatch_semaphore_signal(semaphore);
                                  }
     ];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    
    dispatch_release(semaphore);
    
}
@end
