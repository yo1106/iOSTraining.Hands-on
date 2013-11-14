//
//  TestQueue.m
//  BasicObjectiveC
//
//  Created by yukichang on 2013/11/08.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TestQueue.h"

@interface TestQueue()

@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation TestQueue

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
    NSObject *obj = _queue[0];
    [_queue removeObjectAtIndex:0];
    return obj;
}

- (NSInteger)size{
    return _queue.count;
}

@end
