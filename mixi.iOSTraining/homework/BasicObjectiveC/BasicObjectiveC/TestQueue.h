//
//  TestQueue.h
//  BasicObjectiveC
//
//  Created by yukichang on 2013/11/08.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestQueue : NSObject



- (void)push:(id)object;
- (id)pop;
- (NSInteger)size;

@end
