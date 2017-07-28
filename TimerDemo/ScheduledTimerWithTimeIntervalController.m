
//
//  ScheduledTimerWithTimeIntervalController.m
//  TimerDemo
//
//  Created by  czk on 17/2/15.
//  Copyright © 2017年 fanxc. All rights reserved.
//

#import "ScheduledTimerWithTimeIntervalController.h"

@interface ScheduledTimerWithTimeIntervalController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLbl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ScheduledTimerWithTimeIntervalController

static NSInteger Count = 100;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerLbl.text = [NSString stringWithFormat:@"%zi",Count];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeCount) userInfo:nil repeats:YES];
}

- (void)changeCount
{
    Count--;
    self.timerLbl.text = [NSString stringWithFormat:@"%zi",Count];
    
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
