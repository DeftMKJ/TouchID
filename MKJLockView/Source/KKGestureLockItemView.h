

#import <UIKit/UIKit.h>
//颜色
#define UIColorFromRGBA(rgbValue, iAlpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:iAlpha]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0f)

#define KKGesture_NormalColor        UIColorFromRGB(0xc6c6c6)
#define KKGesture_SelectColor        UIColorFromRGB(0xFF5D52)
#define KKGesture_Select_Line_Color  UIColorFromRGB(0xFF5D52)
//UIColorFromRGBA(0xff632c,0.13)

#define KKGesture_ErrorColor        UIColorFromRGBA(0xFF5D52,0.34)
#define KKGesture_Error_Line_Color  UIColorFromRGB(0xffa19b)

#define KKGesture_ErrorBgColor  UIColorFromRGBA(0xFF5D52,0.34)
/*
 手势密码节点itemview
 */

typedef NS_ENUM(NSInteger, KKGestureLockItemType) {
    KKGestureLockItemTypeNormal = 0x20,
    KKGestureLockItemTypeSelect,
    KKGestureLockItemTypeError,
};

NS_ASSUME_NONNULL_BEGIN

@interface KKGestureLockItemView : UIView

@property (nonatomic ,assign) CGFloat nodeWith;
@property (nonatomic, assign) BOOL isShowInner;
@property (nonatomic, assign) BOOL isDotShow;


- (void)setItemViewType:(KKGestureLockItemType)type;
- (KKGestureLockItemType)getDrawType;

- (void)startAnimation;


@end

NS_ASSUME_NONNULL_END
