//
//  ViewController.m
//  dispatch_source
//
//  Created by admin on 2017/4/5.
//  Copyright © 2017年 N/A. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
{
    
    dispatch_source_t _timer;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self initTimer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTimer {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    /**
     何时开始执行第一个任务 (开始计时时间)
     dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
     */
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(3.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(_timer, start, interval, 0);
    // 设置回调
    dispatch_source_set_event_handler(_timer, ^{
#warning 是否需要重复计时(默认是需要的)
//        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self timerEnd];
            
        });
    });
    // 启动定时器 -(可以根据自己的需求,调用此方法)
    dispatch_resume(_timer);
}

- (void)timerEnd {
    NSLog(@"计时结束-可以开始自己的任务啦");
}
@end
