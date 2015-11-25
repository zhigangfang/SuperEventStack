//
//  ViewController.m
//  SuperEventStack
//
//  Created by 房志刚 on 11/24/15.
//  Copyright © 2015 mf. All rights reserved.
//
//  ******  开发群：223778322  *********

#import "ViewController.h"
#import <sys/cdefs.h>

@interface ViewController () {
    BOOL optionFlag; //default false
}

@end

@implementation ViewController

#pragma mark - Lifecycle method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self _initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private method
- (void)_initView {
    
    UIButton *randomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    [randomBtn setBackgroundColor:[UIColor grayColor]];
    [randomBtn setTitle:@"下发随机事件" forState:UIControlStateNormal];
    [randomBtn addTarget:self action:@selector(_releaseRandomEvent:) forControlEvents:UIControlEventTouchUpInside];
    randomBtn.center = self.view.center;
    
    [self.view addSubview:randomBtn];
    
    
    UIButton *manualBtn = [[UIButton alloc] initWithFrame:CGRectMake(randomBtn.frame.origin.x, randomBtn.frame.origin.y+randomBtn.frame.size.height+30, 120, 50)];
    [manualBtn setBackgroundColor:[UIColor grayColor]];
    [manualBtn setTitle:@"下发人工事件" forState:UIControlStateNormal];
    [manualBtn addTarget:self action:@selector(_releaseManualEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:manualBtn];

}

//生成随机时间
- (int)_generateRandomNumber:(int)from to:(int)to {
    
    return (int)(from + (arc4random() % (to - from + 1)));
    
}



#pragma mark - Event method
- (void)_releaseRandomEvent:(UIButton *)sender {
    NSLog(@"随机事件已下发");
    optionFlag = NO;
    
    double delayInSeconds = [self _generateRandomNumber:5 to:30];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        optionFlag = YES;
        NSLog(@"随机事件下发后%f秒已执行", delayInSeconds);
        
    });
    
}

- (void)_releaseManualEvent:(UIButton *)sender {
   
    NSLog(@"人工事件已下发, 耐心等待！");
    
    while (!optionFlag) {
//        NSLog(@"runloop…");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        NSLog(@"runloop end.");
//        sleep(0.1);
    }
    
    optionFlag = NO;
    
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"人工事件已执行" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alerView show];
    
}




@end
