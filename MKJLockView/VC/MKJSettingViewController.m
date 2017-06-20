//
//  MKJSettingViewController.m
//  MKJLockView
//
//  Created by mintou on 2017/6/15.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJSettingViewController.h"
#import "MKJView.h"
#import <RQShineLabel.h>
#import <Masonry.h>

@interface MKJSettingViewController () <KKGestureLockViewDelegate>

@property (nonatomic, strong) KKGestureLockView *gestureView;

@property (nonatomic, strong) KKGestureLockView *topGestureView;

@property (nonatomic, strong) MKJView *closeView;

@property (nonatomic, strong) RQShineLabel *shineLabel;

@property (nonatomic, assign) NSInteger count; // 记录设置的数量

@property (nonatomic, copy) NSString *passCodeString;

@end

@implementation MKJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = 0;
    self.passCodeString = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (id)[UIImage imageNamed:@"3.jpg"].CGImage;
    
    _topGestureView = [[KKGestureLockView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 40, 50, 80, 80) isDotShow:YES];
    _topGestureView.userInteractionEnabled = NO;
    _topGestureView.contentInsets = UIEdgeInsetsMake(5,5,5,5);
    _topGestureView.buttonSize = CGSizeMake(8, 8);
    _topGestureView.lineWidth = 0;
    _topGestureView.nodeWidth = 8;
    _topGestureView.isShowInner = NO;
    [self.view addSubview:_topGestureView];
    
    
    _gestureView = [[KKGestureLockView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, kScreenWidth)];
    _gestureView.contentInsets = UIEdgeInsetsMake(0, 50, 100, 50);
    _gestureView.buttonSize = CGSizeMake((kScreenWidth-4*50)/3,(kScreenWidth-4*50)/3);
    _gestureView.delegate = self;
//    _gestureView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_gestureView];
    
    
    _closeView = [[MKJView alloc] initWithFrame:CGRectMake(20, 40, 24, 24)];
    _closeView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    [self.view addSubview:_closeView];
    [self.closeView addGestureRecognizer:tap];
    
    self.shineLabel = [[RQShineLabel alloc] initWithFrame:CGRectMake(16, 100, 100, 200)];
    self.shineLabel.numberOfLines = 0;
    self.shineLabel.text = self.type == 1 ? @"绘制手势密码" : @"验证手势密码";
    self.shineLabel.textAlignment = NSTextAlignmentCenter;
    self.shineLabel.shineDuration = 1.0f;
    self.shineLabel.fadeoutDuration = 0.5;
    self.shineLabel.textColor = [UIColor whiteColor];
    self.shineLabel.backgroundColor = [UIColor clearColor];
    [self.shineLabel sizeToFit];
    [self.view addSubview:self.shineLabel];
    [self.shineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.gestureView.mas_top).with.offset(-20);
    }];
}

- (void)close:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
    __weak typeof(self)weakSelf = self;
    self.gestureView.userInteractionEnabled  = NO;
    
    if (self.type == 1) {
        if (self.count == 0) {
            self.count ++;
            [_topGestureView setGestureWithPasscode:passcode];
            if (self.shineLabel.isVisible) {
                [self.shineLabel fadeOutWithCompletion:^{
                    self.shineLabel.textColor = [UIColor whiteColor];
                    self.shineLabel.text = @"再次设置确认\nJust gonna stand there and watch me burn\nBut that's alright because I like the way it hurts\nJust gonna stand there and hear me cry";
                    [self.shineLabel shineWithCompletion:^{
                        weakSelf.gestureView.userInteractionEnabled = YES;
                    }];
                }];
            }
            else
            {
                self.shineLabel.textColor = [UIColor whiteColor];
                self.shineLabel.text = @"再次设置确认\nJust gonna stand there and watch me burn\nBut that's alright because I like the way it hurts\nJust gonna stand there and hear me cry";
                [self.shineLabel shineWithCompletion:^{
                    weakSelf.gestureView.userInteractionEnabled = YES;
                }];
            }
            self.passCodeString = passcode;
            
        }
        else if (self.count == 1)
        {
            self.count ++;
            if ([passcode isEqualToString:self.passCodeString]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.passCodeString forKey:@"GESTURE_CODE"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [_topGestureView setGestureWithPasscode:passcode];
                if (self.shineLabel.isVisible) {
                    [self.shineLabel fadeOutWithCompletion:^{
                        self.shineLabel.textColor = [UIColor whiteColor];
                        self.shineLabel.text = @"设置成功\n在这温暖的房间\n我于是慢慢发现\n相聚其实就是一种缘\n多值得纪念";
                        [self.shineLabel shineWithCompletion:^{
                            weakSelf.gestureView.userInteractionEnabled = NO;
                            [weakSelf close:nil];
                        }];
                    }];
                }
                else
                {
                    [self.shineLabel shineWithCompletion:^{
                        weakSelf.gestureView.userInteractionEnabled = YES;
                        [weakSelf close:nil];
                    }];
                }
            }
            else
            {
                self.count = 0;
                self.passCodeString = @"";
                if (self.shineLabel.isVisible) {
                    [self.shineLabel fadeOutWithCompletion:^{
                        self.shineLabel.text = @"重新设置\n我们从不开口那个言语\n那一句我爱你\n永远像少了勇气\n别人都说\n我和你之间的关系\n没有人相信只有关心";
                        self.shineLabel.textColor = [UIColor redColor];
                        [self.shineLabel shineWithCompletion:^{
                            weakSelf.gestureView.userInteractionEnabled = YES;
                        }];
                    }];
                }
                else
                {
                    [self.shineLabel shineWithCompletion:^{
                        weakSelf.gestureView.userInteractionEnabled = YES;
                    }];
                }
            }
        }
    }
    else
    {
        [self.topGestureView setGestureWithPasscode:passcode];
        NSString *localPassword = [[NSUserDefaults standardUserDefaults] valueForKey:@"GESTURE_CODE"];
        if ([localPassword isEqualToString:passcode]) {
            if (self.shineLabel.isVisible) {
                [self.shineLabel fadeOutWithCompletion:^{
                    self.shineLabel.textColor = [UIColor redColor];
                    self.shineLabel.text = @"验证成功\n曾经有那一刻\n回头竟然认不得需要从记忆再摸索的人\n和他们关心的 的地方\n和那些走过的请等一等\n梦为努力浇了水";
                    [self.shineLabel shineWithCompletion:^{
                        weakSelf.gestureView.userInteractionEnabled = NO;
                        [weakSelf close:nil];
                    }];
                }];
            }
            else
            {
                self.shineLabel.textColor = [UIColor redColor];
                self.shineLabel.text = @"验证成功\n曾经有那一刻\n回头竟然认不得需要从记忆再摸索的人\n和他们关心的 的地方\n和那些走过的请等一等\n梦为努力浇了水";
                [self.shineLabel shineWithCompletion:^{
                    weakSelf.gestureView.userInteractionEnabled = NO;
                    [weakSelf close:nil];
                }];
            }
        }
        else
        {
            if (self.shineLabel.isVisible) {
                [self.shineLabel fadeOutWithCompletion:^{
                    self.shineLabel.textColor = [UIColor redColor];
                    self.shineLabel.text = @"验证失败\n动情是容易的 因为不会太久\n远远的 仿佛可以触摸\n留恋是不幸的 因为曾经拥有\n夜夜被思念缠扰着";
                    [self.shineLabel shineWithCompletion:^{
                        weakSelf.gestureView.userInteractionEnabled = YES;
                    }];
                }];
            }
            else
            {
                self.shineLabel.textColor = [UIColor redColor];
                self.shineLabel.text = @"验证失败\n动情是容易的 因为不会太久\n远远的 仿佛可以触摸\n留恋是不幸的 因为曾经拥有\n夜夜被思念缠扰着";
                [self.shineLabel shineWithCompletion:^{
                    weakSelf.gestureView.userInteractionEnabled = YES;
                }];
            }
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealloc-->%s",object_getClassName(self));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
