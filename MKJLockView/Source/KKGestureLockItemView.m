

#import "KKGestureLockItemView.h"

#define  kGestureNodeMaxWidth   30
#define  kGestureNodeWidthOffset  5
NSInteger const  kInnerNodeWidth =  18;

@interface KKGestureLockItemView()
@property (nonatomic, assign) KKGestureLockItemType drawType;
@property (nonatomic, strong) NSTimer   *timer;
@end

@implementation KKGestureLockItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        _drawType = KKGestureLockItemTypeNormal;
    }
    return self;
}


- (KKGestureLockItemType)getDrawType{
    return _drawType;
}

- (void)setItemViewType:(KKGestureLockItemType)type
{
    _drawType = type;
    [self setNeedsDisplay];
}

- (void)startAnimation{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.nodeWith > kInnerNodeWidth) {
        self.nodeWith = kInnerNodeWidth;
    }
    self.timer = [NSTimer  scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(uploadDisplay) userInfo:nil repeats:YES];
}

- (void)uploadDisplay{
    if (self.nodeWith < kGestureNodeMaxWidth) {
        self.nodeWith += kGestureNodeWidthOffset;
    }
    else{
        self.nodeWith -= kGestureNodeWidthOffset;
        if ([self.timer isValid]) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    /*
     * 1. CGContextSetStrokeColorWithColor 边缘线的颜色  CGContextSetFillColorWithColor 填充颜色
     * 2. CGContextSetLineWidth 边缘线的宽度
     * 3. CGContextAddArc 画一个圆 x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
     * 4. CGContextDrawPath  绘制路径，第一个参数是上下文，第二个参数是kCGPathFill--> 填充 kCGPathStroke-->路劲  kCGPathFillStroke--> 填充+路径
     * 5. CGContextStrokePath 类似上面的边框路径绘制
     * 6. CGContextFillPath 类似上面的填充绘制
     * 7. CGContextClearRect 清理上下文
     * 8. CGContextSaveGState 和 CGContextRestoreGState CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式
     * 9.  CGContextClip 裁剪上下文
     * 10. CGContextAddEllipseInRect 画椭圆
     * 11. CGContextAddQuadCurveToPoint 两点之间正余弦波动，双点控制
     * 12. CGContextDrawImage 这个会使图片上下点到
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context,self.bounds);
    CGContextSaveGState(context);
    //抗锯齿
    CGContextSetAllowsAntialiasing(context,TRUE);
    CGContextSetShouldAntialias(context,YES);
    CGContextSetShouldSmoothFonts(context,TRUE);
    
    CGFloat width_f = CGRectGetWidth(self.bounds);
    CGFloat height_f = CGRectGetHeight(self.bounds);
    
    NSInteger radius = width_f>height_f?height_f:width_f;
    radius = radius/2 * 2;
    CGPoint centerP = CGPointMake(width_f/2,height_f/2);
    NSInteger innerRadius = radius - 16;
    
    //
    CGFloat lineWidth = 1.f;
    CGRect bounds = CGRectMake(centerP.x-radius/2+lineWidth,centerP.y-radius/2+lineWidth,radius-2*lineWidth,radius-2*lineWidth);
    
    //
    CGFloat innerLineWidth = 4;
    innerRadius = self.nodeWith + 12;
    CGRect innerBounds = CGRectMake(centerP.x-innerRadius/2+innerLineWidth,centerP.y-innerRadius/2+innerLineWidth,innerRadius-2*innerLineWidth,innerRadius-2*innerLineWidth);
    switch (_drawType)
    {
        case KKGestureLockItemTypeNormal:
        {
            //画填充圆
            if (self.isDotShow) {
                //内圆无边框
                CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);//KKGesture_SelectColor
                NSInteger radius = width_f>height_f?height_f:width_f;
                radius = radius/2;
                CGContextAddArc(context, centerP.x, centerP.y, radius, 0, 2*M_PI, 0);
                CGContextDrawPath(context, kCGPathFill);
            }
            else{
                // 常态下就一个圆环 填充色为白色
                CGContextSetFillColorWithColor(context, UIColorFromRGBA(0xffffff,0.2).CGColor);
                NSInteger radius = width_f>height_f?height_f:width_f;
                radius = radius/2;
                CGContextAddArc(context, centerP.x, centerP.y, radius, 0, 2*M_PI, 0);
                CGContextDrawPath(context, kCGPathFill);
                // 描边
                CGContextSetStrokeColorWithColor(context,KKGesture_SelectColor.CGColor);
                CGContextSetLineWidth(context,lineWidth);
                CGContextAddEllipseInRect(context,bounds);
                CGContextStrokePath(context);
            }
        }
            break;
        case KKGestureLockItemTypeSelect:
        {
            //画边框
            BOOL isNeedTrack = YES;
            if (isNeedTrack) {
                
                UIColor  *borderColor =  KKGesture_Select_Line_Color;
                CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
                CGContextSetLineWidth(context,lineWidth);
                CGContextAddEllipseInRect(context,bounds);
                CGContextStrokePath(context);
                
                if(_isShowInner && !self.isDotShow)
                {
                    //画透明圆点 外圈
                    UIColor  *innerColor = UIColorFromRGBA(0xFB6A90,0.3);
                    CGContextSetStrokeColorWithColor(context,innerColor.CGColor);
                    CGContextSetLineWidth(context,innerLineWidth);
                    
                    CGContextAddEllipseInRect(context,innerBounds);
                    [innerColor set];
                    CGContextStrokePath(context);
                }
                
                if (self.isDotShow) {
                    //显示小白点
                    CGContextSetStrokeColorWithColor(context,KKGesture_SelectColor.CGColor);
                    CGContextSetFillColorWithColor(context,KKGesture_SelectColor.CGColor);
                    CGContextAddEllipseInRect(context,CGRectMake(centerP.x-_nodeWith/2,centerP.y-_nodeWith/2,_nodeWith,_nodeWith));
                    CGContextFillPath(context);
                }
                else{
                    // 内圈
                    CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
                    CGContextSetFillColorWithColor(context,[UIColor redColor].CGColor);
                    CGContextAddEllipseInRect(context,CGRectMake(centerP.x-_nodeWith/2,centerP.y-_nodeWith/2,_nodeWith,_nodeWith));
                    CGContextFillPath(context);
                }
            }
            else{
                //画默认填充圆
                if (self.isDotShow) {
                    //内圆无边框
                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                    NSInteger radius = width_f>height_f?height_f:width_f;
                    radius = radius/2;
                    CGContextAddArc(context, centerP.x, centerP.y, radius, 0, 2*M_PI, 0);
                    CGContextDrawPath(context, kCGPathFill);
                }
                else{
                    CGContextSetFillColorWithColor(context,[UIColor clearColor].CGColor);//UIColorFromRGBA(0x000000,0.2).CGColor
                    NSInteger radius = width_f>height_f?height_f:width_f;
                    radius = radius/2;
                    CGContextAddArc(context, centerP.x, centerP.y, radius, 0, 2*M_PI, 0);
                    CGContextDrawPath(context, kCGPathFill);
                    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
                    CGContextSetStrokeColorWithColor(context,KKGesture_SelectColor.CGColor);
                    CGContextSetLineWidth(context,lineWidth);
                    CGContextAddEllipseInRect(context,bounds);
                    CGContextStrokePath(context);
                }
            }
        }
            break;
        case KKGestureLockItemTypeError:
        {
            UIColor  *borderColor = KKGesture_Error_Line_Color;//UIColorFromRGBA(0xffffff,0.7);
            CGContextSetStrokeColorWithColor(context,borderColor.CGColor);
            CGContextSetLineWidth(context,lineWidth);
            CGContextAddEllipseInRect(context,bounds);
            CGContextStrokePath(context);
            
            if(_isShowInner)
            {
                UIColor  *innerColor = KKGesture_Error_Line_Color;//UIColorFromRGBA(0xfd698f,0.3); //KKGesture_SelectColor.CGColor
                CGContextSetStrokeColorWithColor(context,innerColor.CGColor);
                CGContextSetLineWidth(context,innerLineWidth);
                
                CGContextAddEllipseInRect(context,innerBounds);
                [innerColor set];
                CGContextStrokePath(context);
            }
            
            CGContextSetStrokeColorWithColor(context,KKGesture_Error_Line_Color.CGColor);
            CGContextSetFillColorWithColor(context,KKGesture_Error_Line_Color.CGColor);
            CGContextAddEllipseInRect(context,CGRectMake(centerP.x-_nodeWith/2,centerP.y-_nodeWith/2,_nodeWith,_nodeWith));
            CGContextFillPath(context);
        }
            break;
        default:
            break;
    }    
    CGContextRestoreGState(context);
}


@end
