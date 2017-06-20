

#import <UIKit/UIKit.h>

// 默认手势位子
const static CGFloat kTrackedLocationInvalidInContentView = -1.0;

NS_ASSUME_NONNULL_BEGIN
@interface KKGestureLineView : UIView
@property (nonatomic, strong) NSMutableArray *selectedButtons; // 选中的按钮
@property (nonatomic, assign) CGPoint trackedLocationInContentView; // 手势滑动的坐标
@property (nonatomic, strong) UIColor *lineColor; // 轨迹的颜色
@property (nonatomic, assign) CGFloat lineWidth; // 轨迹的宽度
@property (nonatomic, assign) BOOL isErrorState; // 错误状态
@end
NS_ASSUME_NONNULL_END
