//
//  ViewController.m
//  MKJLockView
//
//  Created by mintou on 2017/6/14.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "ViewController.h"
#import "MKJView.h"
#import "MKJSettingViewController.h"
#import "MKJTouchIDManager.h"
#import "MKJTouchIDViewController.h"


@interface ViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *settingButon;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIButton *touchIDButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.r whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)setting:(id)sender {
    MKJSettingViewController *settingVC = [[MKJSettingViewController alloc] init];
    settingVC.type = 1;
    [self presentViewController:settingVC animated:YES completion:^{
        
    }];
    NSLog(@"点击开始");
}
- (IBAction)verify:(id)sender {
    
    MKJSettingViewController *settingVC = [[MKJSettingViewController alloc] init];
    settingVC.type = 2;
    [self presentViewController:settingVC animated:YES completion:^{
        
    }];
    NSLog(@"点击验证");
}
- (IBAction)touchIDCLick:(id)sender {
    if ([[MKJTouchIDManager shareManager] isTouchIDEnableOrNotBySystem]) {
        
        MKJTouchIDViewController *mkjTouchID = [[MKJTouchIDViewController alloc] init];
        [self presentViewController:mkjTouchID animated:YES completion:^{
            [[MKJTouchIDManager shareManager] startVerifyTouchID:^{
                NSLog(@"验证成功");
                [self dismissViewControllerAnimated:YES completion:nil];
            } failure:^{
                NSLog(@"验证失败");
                [self showAlert];
                
            }];
        }];
    }
    else
    {
        [[MKJTouchIDManager shareManager] showAlert];
    }
}

- (void)showAlert
{
    NSString * title = @"指纹解锁";
    NSString * msg = @"认证失败";
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
