//
//  NSThreadAndNSTimerController.m
//  TimerDemo
//
//  Created by  czk on 17/2/15.
//  Copyright © 2017年 fanxc. All rights reserved.
//

#import "NSThreadAndNSTimerController.h"

@interface NSThreadAndNSTimerController ()

@property (weak, nonatomic) IBOutlet UILabel *timerLbl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation NSThreadAndNSTimerController

static NSInteger Count = 100;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerLbl.text = [NSString stringWithFormat:@"%zi",Count];
    [self threadTimerMethod];
}

/**
 NSThread
 */
- (void)threadTimerMethod
{
    NSLog(@"主线程 %@", [NSThread currentThread]);
    
    //创建并执行新的线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:nil];
    [thread start];
}

- (void)newThread
{
    @autoreleasepool
    {
        //在当前Run Loop中添加timer，模式是默认的NSDefaultRunLoopMode
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer_callback) userInfo:nil repeats:YES];
        //开始执行新线程的Run Loop
        [[NSRunLoop currentRunLoop] run];
    }
}

//timer的回调方法
- (void)timer_callback
{
    Count--;
    self.timerLbl.text = [NSString stringWithFormat:@"%zi",Count];
    NSLog(@"Timer %@", [NSThread currentThread]);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    Count = 100;
}


@end
