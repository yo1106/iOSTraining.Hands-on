//
//  TestStack.h
//  BasicObjectiveC
//
//  Created by yukichang on 2013/11/09.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestStack : NSObject

@property (nonatomic, strong) NSMutableArray *queue;

- (void)push:(id)object;
- (id)pop;
- (NSInteger)size;


@end
