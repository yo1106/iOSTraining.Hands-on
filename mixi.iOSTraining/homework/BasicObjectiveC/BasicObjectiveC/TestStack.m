//
//  TestStack.m
//  BasicObjectiveC
//
//  Created by yukichang on 2013/11/09.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TestStack.h"

@implementation TestStack

- (id)init{
    
    if(self == [super init]){
        _queue = [NSMutableArray array];
    }
    
    return  self;
}

- (void)push:(id)object{
    [_queue addObject:object];
}

- (id)pop{
    NSInteger index = _queue.count-1;
    NSObject *obj = _queue[index];
    [_queue removeObjectAtIndex:index];
    return obj;
}

- (NSInteger)size{
    return _queue.count;
}

@end
