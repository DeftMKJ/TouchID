//
//  MKJTouchIDManager.m
//  MKJLockView
//
//  Created by mintou on 2017/6/20.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTouchIDManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@implementation MKJTouchIDManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static MKJTouchIDManager *touchIDManager;
    dispatch_once(&onceToken, ^{
        touchIDManager = [[self alloc] init];
    });
    return touchIDManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        if(appName.length <= 0)
            appName = @"M珂璟";
        
        _appName = [[NSString alloc] initWithString:appName];
    }
    return self;
}

- (BOOL)isTouchIDEnableOrNotBySystem
{
#ifdef __IPHONE_8_0
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError])
    {
        /**
         可以验证指纹  手机支持而且手机开启指纹模式
         */
        return YES;
    }
    else
    {
        /**
         无法验证指纹  手机不支持或者用户未开启指纹模式
         */
        return NO;
    }
#else
    /**
     无法验证指纹
     */
    return NO;
#endif  /* __IPHONE_8_0 */
}

- (void)startVerifyTouchID:(void (^)(void))completeBlock failure:(void (^)(void))failureBlock
{
    NSString *touchIDReason = [NSString stringWithFormat:@"我要解锁%@",_appName];
    
#ifdef __IPHONE_8_0
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    
    // Hide "Enter Password" button
    myContext.localizedFallbackTitle = @"";
    
    // show the authentication UI
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError])
    {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:touchIDReason
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        /**
                                         指纹校验 成功
                                         */
                                        [self verifySucceed:completeBlock];
                                    });
                                    
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        /**
                                         指纹校验 失败
                                         */
                                        [self authenticatedFailedWithError:error failure:failureBlock];
                                    });
                                    
                                }
                            }];
    }
    else
    {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self evaluatePolicyFailedWithError:nil];
        });
        
    }
    
#endif  /* __IPHONE_8_0 */
}


- (void)verifySucceed:(void(^)(void))completeBlock
{
    if (completeBlock) {
        completeBlock();
    }
}

- (void)authenticatedFailedWithError:(NSError *)error failure:(void(^)(void))failureBlock
{
    
    if (error.code == -1)
    {
        /**
         震动
         */
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if (failureBlock) {
        failureBlock();
    }
}

- (void)evaluatePolicyFailedWithError:(void(^)(void))completeBlock
{
    NSLog(@"验证失败");
}

- (void)showAlert
{
    NSString * title = [NSString stringWithFormat:@"此设备不支持%@指纹", _appName];
    NSString * msg = [NSString stringWithFormat:@"请买一个新的iphone%@", _appName];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message: msg delegate: nil cancelButtonTitle: @"知道了" otherButtonTitles: nil, nil];
    
    [alertView show];
}

@end











