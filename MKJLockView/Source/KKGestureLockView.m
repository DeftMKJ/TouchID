

#import "KKGestureLockView.h"
const static NSUInteger kNumberOfNodes = 9;
const static NSUInteger kNodesPerRow = 3;
const static CGFloat kNodeDefaultWidth = 60;
const static CGFloat kNodeDefaultHeight = 60;
const static CGFloat kLineDefaultWidth = 3;


@interface KKGestureLockView (){
    struct {
        unsigned int didBeginWithPasscode :1;
        unsigned int didEndWithPasscode : 1;
        unsigned int didCanceled : 1;
    } _delegateFlags;
}

@property (nonatomic, strong) UIView *contentView;

//Implement nodes with buttons

@property (nonatomic, strong) NSArray *buttons; // 总数按钮
@property (nonatomic, strong) KKGestureLineView *gestureLineView; // 轨迹
@property (nonatomic, strong) NSMutableArray *selectedButtons; // 选中的按钮

@end

@implementation KKGestureLockView

#pragma mark -
#pragma mark Private Methods

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (KKGestureLockItemView *)_buttonContainsThePoint:(CGPoint)point{
    for (KKGestureLockItemView *button in self.buttons) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}

- (void)_lockViewInitialize{
    self.backgroundColor = [UIColor clearColor];
    
    self.lineColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.lineWidth = kLineDefaultWidth;
    
    self.isShowInner = YES;
    
    self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, self.contentInsets)];
//    self.contentView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.contentView];
    
    self.gestureLineView = [[KKGestureLineView alloc] initWithFrame:self.bounds];
    self.gestureLineView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.gestureLineView];
    
    self.buttonSize = CGSizeMake(kNodeDefaultWidth, kNodeDefaultHeight);

    self.numberOfGestureNodes = kNumberOfNodes;
    self.gestureNodesPerRow = kNodesPerRow;
    
}


#pragma mark -
#pragma mark UIView Overrides
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self _lockViewInitialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self _lockViewInitialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame isDotShow:(BOOL)isDotShow
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isDotShow = isDotShow;
        [self _lockViewInitialize];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _gestureLineView.lineColor = [UIColor redColor];
    _gestureLineView.lineWidth = self.isDotShow ? 0 : kLineDefaultWidth;
    
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    CGFloat horizontalNodeMargin = (self.contentView.bounds.size.width - self.buttonSize.width * self.gestureNodesPerRow)/(self.gestureNodesPerRow - 1);
    NSUInteger numberOfRows = ceilf((self.numberOfGestureNodes * 1.0 / self.gestureNodesPerRow));
    CGFloat verticalNodeMargin = (self.contentView.bounds.size.height - self.buttonSize.height *numberOfRows)/(numberOfRows - 1);
    
    for (int i = 0; i < self.numberOfGestureNodes ; i++) {
        int row = i / self.gestureNodesPerRow;
        int column = i % self.gestureNodesPerRow;
        KKGestureLockItemView *button = [self.buttons objectAtIndex:i];
        button.nodeWith =  _nodeWidth?_nodeWidth:18;
        button.isShowInner = _isShowInner;
        
        button.frame = CGRectMake(floorf((self.buttonSize.width + horizontalNodeMargin) * column), floorf((self.buttonSize.height + verticalNodeMargin) * row), self.buttonSize.width, self.buttonSize.height);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 获取开始的坐标
    UITouch *touch = [touches anyObject];
    CGPoint locationInContentView = [touch locationInView:self.contentView];
    // 根据坐标获取到对应的按钮
    KKGestureLockItemView *touchedButton = [self _buttonContainsThePoint:locationInContentView];
    // 如果开始的时候不是按钮区域不进行绘制
    if (touchedButton != nil) {
        // 触发到按钮进行动画
        [touchedButton setItemViewType:KKGestureLockItemTypeSelect];
        [touchedButton startAnimation];//开始动画
        
        // 添加到选择的数组
        [_gestureLineView.selectedButtons addObject:touchedButton];
        
        _gestureLineView.trackedLocationInContentView = locationInContentView;
        
        if (_delegateFlags.didBeginWithPasscode) {
            [self.delegate gestureLockView:self didBeginWithPasscode:[NSString stringWithFormat:@"%d",(int)touchedButton.tag]];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // 获取到坐标
    UITouch *touch = [touches anyObject];
    CGPoint locationInContentView = [touch locationInView:self.contentView];
    // 手势区域在规定坐标里面
    if (CGRectContainsPoint(self.contentView.bounds, locationInContentView)) {
        // 如果触发到了按钮区域，按钮进行动画
        KKGestureLockItemView *touchedButton = [self _buttonContainsThePoint:locationInContentView];
        if (touchedButton != nil && [_gestureLineView.selectedButtons indexOfObject:touchedButton]==NSNotFound) {
            [touchedButton setItemViewType:KKGestureLockItemTypeSelect];
            [touchedButton startAnimation];//开始动画
            
            [_gestureLineView.selectedButtons addObject:touchedButton];
            if ([_gestureLineView.selectedButtons count] == 1) {
                //If the touched button is the first button in the selected buttons,
                //It's the beginning of the passcode creation
                if (_delegateFlags.didBeginWithPasscode) {
                    [self.delegate gestureLockView:self didBeginWithPasscode:[NSString stringWithFormat:@"%d",(int)touchedButton.tag]];
                }
            }
        }
        // 不断绘制轨迹线
        _gestureLineView.trackedLocationInContentView = locationInContentView;
        [_gestureLineView setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{    
    if ([_gestureLineView.selectedButtons count] > 0) {
        if (_delegateFlags.didEndWithPasscode) {
            NSMutableArray *passcodeArray = [NSMutableArray array];
            for (UIButton *button in _gestureLineView.selectedButtons) {
                [passcodeArray addObject:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            
            [self.delegate gestureLockView:self didEndWithPasscode:[passcodeArray componentsJoinedByString:@","]];
        }
    }
    
    [self clearPasscode];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([_gestureLineView.selectedButtons count] > 0) {
        if (_delegateFlags.didCanceled) {
            NSMutableArray *passcodeArray = [NSMutableArray array];
            for (UIButton *button in _gestureLineView.selectedButtons) {
                [passcodeArray addObject:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            
            [self.delegate gestureLockView:self didCanceledWithPasscode:[passcodeArray componentsJoinedByString:@","]];
        }
    }
    
    for (KKGestureLockItemView *button in _gestureLineView.selectedButtons)
    {
        [button setItemViewType:KKGestureLockItemTypeNormal];
    }
    [_gestureLineView.selectedButtons removeAllObjects];
    _gestureLineView.trackedLocationInContentView = CGPointMake(kTrackedLocationInvalidInContentView, kTrackedLocationInvalidInContentView);
    [_gestureLineView setNeedsDisplay];
}

#pragma mark -
#pragma mark Accessors

- (void)setDelegate:(id<KKGestureLockViewDelegate>)delegate{
    _delegate = delegate;
    
    _delegateFlags.didBeginWithPasscode = [delegate respondsToSelector:@selector(gestureLockView:didBeginWithPasscode:)];
    _delegateFlags.didEndWithPasscode = [delegate respondsToSelector:@selector(gestureLockView:didEndWithPasscode:)];
//    _delegateFlags.didCanceled = [delegate respondsToSelector:@selector(gestureLockViewCanceled:)];
}

- (void)setNumberOfGestureNodes:(NSUInteger)numberOfGestureNodes{
    if (_numberOfGestureNodes != numberOfGestureNodes) {
        _numberOfGestureNodes = numberOfGestureNodes;
        
        if (self.buttons != nil && [self.buttons count] > 0) {
            for (UIButton *button in self.buttons) {
                [button removeFromSuperview];
            }
        }
        
        NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:numberOfGestureNodes];
        for (NSUInteger i = 0; i < numberOfGestureNodes; i++) {
            KKGestureLockItemView *button = [[KKGestureLockItemView alloc] initWithFrame:CGRectMake(0, 0, self.buttonSize.width, self.buttonSize.height)];
            button.isDotShow = self.isDotShow;
            button.tag = i;
            button.userInteractionEnabled = NO;
            button.backgroundColor = [UIColor clearColor];
            
            [buttonArray addObject:button];
            [self.contentView addSubview:button];;
        }
        self.buttons = [buttonArray copy];
    }
}

-(void)clearPasscode
{
    for (KKGestureLockItemView *button in self.buttons)
    {
        [button setItemViewType:KKGestureLockItemTypeNormal];
    }
    //轨迹是否展示
//    MTFGestureEntity *entity = [MTFUtils shared].curGestureEntity;
//    if (!entity.gestureTrack) {
//        _gestureLineView.lineWidth = 0;
//    }
    
    _gestureLineView.isErrorState = NO;
    [_gestureLineView.selectedButtons removeAllObjects];
    [_gestureLineView setNeedsDisplay];
}

-(void)showErrorState
{
    for (KKGestureLockItemView *button in self.buttons)
    {
        if([button getDrawType]==KKGestureLockItemTypeSelect)
        {
            [button setItemViewType:KKGestureLockItemTypeError];
            _gestureLineView.lineWidth = self.lineWidth;
        }
    }
    _gestureLineView.isErrorState = YES;
    [_gestureLineView setNeedsDisplay];
}

- (void)setGestureWithPasscode:(NSString *)passcode
{
    for (KKGestureLockItemView *button in self.buttons)
    {
        [button setItemViewType:KKGestureLockItemTypeNormal];
    }
    
    _gestureLineView.isErrorState = NO;
    [_gestureLineView.selectedButtons removeAllObjects];
    NSArray *passcodeArray = [passcode componentsSeparatedByString:@","];
    for(NSString *tag in passcodeArray)
    {
        NSInteger viewTag = [tag integerValue];
        if(viewTag>=0 && viewTag<[self.buttons count])
        {
            KKGestureLockItemView *button = self.buttons[viewTag];
            [button setItemViewType:KKGestureLockItemTypeSelect];
            [_gestureLineView.selectedButtons addObject:button];
        }
    }
    
    [_gestureLineView setNeedsDisplay];
}

@end
