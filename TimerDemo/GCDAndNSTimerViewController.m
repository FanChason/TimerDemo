//
//  GCDAndNSTimerViewController.m
//  TimerDemo
//
//  Created by  czk on 17/2/15.
//  Copyright © 2017年 fanxc. All rights reserved.
//

#import "GCDAndNSTimerViewController.h"

@interface GCDAndNSTimerViewController ()
{
    dispatch_source_t _timert;
}

@property (weak, nonatomic) IBOutlet UILabel *timerLbl;
//@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GCDAndNSTimerViewController

static NSInteger Count = 100;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerLbl.text = [NSString stringWithFormat:@"%zi",Count];
    
    [self gcdTimerMothod];
}

- (void)gcdTimerMothod
{
    NSLog(@"主线程 %@", [NSThread currentThread]);
    //间隔还是2秒
    uint64_t interval = 2 * NSEC_PER_SEC;
    //创建一个专门执行timer回调的GCD队列
    dispatch_queue_t queue = dispatch_queue_create("my queue", 0);
    //创建Timer
    _timert = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //使用dispatch_source_set_timer函数设置timer参数
    dispatch_source_set_timer(_timert, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    
    __weak __typeof(&*self)weakSelf = self;
    //设置回调
    dispatch_source_set_event_handler(_timert, ^()
                                      {
                                          Count--;
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              weakSelf.timerLbl.text = [NSString stringWithFormat:@"%zi",Count];
                                          });
                                          
                                          NSLog(@"Timer %@", [NSThread currentThread]);
                                      });
    //dispatch_source默认是Suspended状态，通过dispatch_resume函数开始它
    dispatch_resume(_timert);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_timert) {
        dispatch_cancel(_timert);
    }
    
    Count = 100;
}


@end
