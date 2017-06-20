//
//  MKJTouchIDManager.h
//  MKJLockView
//
//  Created by mintou on 2017/6/20.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKJTouchIDManager : NSObject
{
    @private
    NSString * _appName;//应用程序名字
}

+ (instancetype)shareManager;

- (BOOL)isTouchIDEnableOrNotBySystem;

- (void)startVerifyTouchID:(void(^)(void))completeBlock failure:(void(^)(void))failureBlock;

- (void)showAlert;

@end
