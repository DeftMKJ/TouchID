

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KKGestureLineView.h"
#import "KKGestureLockItemView.h"

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

@class KKGestureLockView;

@protocol KKGestureLockViewDelegate <NSObject>
@optional
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode;
@end

@interface KKGestureLockView : UIView

@property (nonatomic, strong, readonly) NSArray *buttons;

@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;


@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong, readonly) UIView *contentView;//the container of the gesture notes
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, weak) id<KKGestureLockViewDelegate> delegate;
@property (nonatomic, assign ) BOOL isDotShow;
@property (nonatomic, assign) CGSize buttonSize; // 按钮大小

@property (nonatomic,assign) CGFloat nodeWidth; // 宽度不给的话就是默认内圈大小，给的话就是小圈圈大小
@property (nonatomic, assign) BOOL isShowInner; // 默认显示内圈

- (instancetype)initWithFrame:(CGRect)frame isDotShow:(BOOL)isDotShow;

/*
 清空手势数据
 */
-(void)clearPasscode;

/*
 显示出错情况
 */
-(void)showErrorState;

/*
 设置手势
 */
- (void)setGestureWithPasscode:(NSString *)passcode;
@end
