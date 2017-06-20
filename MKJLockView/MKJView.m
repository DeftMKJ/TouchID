//
//  MKJView.m
//  MKJLockView
//
//  Created by mintou on 2017/6/15.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJView.h"


@implementation MKJView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    //// General Declarations
//    //// General Declarations
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    //// Gradient Declarations
//    CGFloat gradientLocations[] = {0, 0.32, 1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.greenColor.CGColor, (id)[MKJView mixColor1:[UIColor greenColor] color2:[UIColor whiteColor] ratio:0.5].CGColor, (id)UIColor.whiteColor.CGColor], gradientLocations);
//    
//    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 160, 80)];
//    CGContextSaveGState(context);
//    [rectanglePath addClip];
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(80, -0), CGPointMake(80, 80), 0);
//    CGContextRestoreGState(context);
//    
//    
//    //// Cleanup
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//
//
//}

//- (void)drawRect:(CGRect)rect
//{
//    //// General Declarations
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    //// Gradient Declarations
//    CGFloat gradientLocations[] = {0, 0.32, 1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.greenColor.CGColor, (id)[MKJView mixColor1:[UIColor greenColor] color2:[UIColor whiteColor] ratio:0.5].CGColor, (id)UIColor.whiteColor.CGColor], gradientLocations);
//    
//    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 160, 80)];
//    CGContextSaveGState(context);
//    [rectanglePath addClip];
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(80, -0), CGPointMake(80, 80), 0);
//    CGContextRestoreGState(context);
//    
//    
//    //// Star Drawing
//    UIBezierPath* starPath = UIBezierPath.bezierPath;
//    [starPath moveToPoint: CGPointMake(199, 15)];
//    [starPath addLineToPoint: CGPointMake(207.82, 27.86)];
//    [starPath addLineToPoint: CGPointMake(222.78, 32.27)];
//    [starPath addLineToPoint: CGPointMake(213.27, 44.64)];
//    [starPath addLineToPoint: CGPointMake(213.69, 60.23)];
//    [starPath addLineToPoint: CGPointMake(199, 55)];
//    [starPath addLineToPoint: CGPointMake(184.31, 60.23)];
//    [starPath addLineToPoint: CGPointMake(184.73, 44.64)];
//    [starPath addLineToPoint: CGPointMake(175.22, 32.27)];
//    [starPath addLineToPoint: CGPointMake(190.18, 27.86)];
//    [starPath closePath];
//    CGContextSaveGState(context);
//    [starPath addClip];
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(199, 15), CGPointMake(199, 60.23), 0);
//    CGContextRestoreGState(context);
//    
//    
//    //// Cleanup
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//
//}

//- (void)drawRect:(CGRect)rect
//{
//    
//    
//    //// 多边形_2 Drawing
//    UIBezierPath* _2Path = UIBezierPath.bezierPath;
//    [_2Path moveToPoint: CGPointMake(61.54, 36.59)];
//    [_2Path addLineToPoint: CGPointMake(6.04, 68.64)];
//    [_2Path addLineToPoint: CGPointMake(6.04, 4.54)];
//    [_2Path addLineToPoint: CGPointMake(61.54, 36.59)];
//    [_2Path closePath];
//    [_2Path moveToPoint: CGPointMake(10.78, 11.89)];
//    [_2Path addLineToPoint: CGPointMake(14.78, 1.89)];
//    [_2Path addLineToPoint: CGPointMake(-0.22, -0.11)];
//    [_2Path addLineToPoint: CGPointMake(0.78, 12.89)];
//    [_2Path addLineToPoint: CGPointMake(10.78, 11.89)];
//    [_2Path closePath];
//    [_2Path moveToPoint: CGPointMake(9.78, 7.89)];
//    [_2Path addLineToPoint: CGPointMake(9.78, 7.89)];
//    [_2Path addCurveToPoint: CGPointMake(13.78, 11.89) controlPoint1: CGPointMake(11.99, 7.89) controlPoint2: CGPointMake(13.78, 9.68)];
//    [_2Path addCurveToPoint: CGPointMake(9.78, 15.89) controlPoint1: CGPointMake(13.78, 14.1) controlPoint2: CGPointMake(11.99, 15.89)];
//    [_2Path addCurveToPoint: CGPointMake(5.78, 11.89) controlPoint1: CGPointMake(7.57, 15.89) controlPoint2: CGPointMake(5.78, 14.1)];
//    [_2Path addLineToPoint: CGPointMake(5.78, 11.89)];
//    [_2Path addCurveToPoint: CGPointMake(9.78, 7.89) controlPoint1: CGPointMake(5.78, 9.68) controlPoint2: CGPointMake(7.57, 7.89)];
//    [_2Path closePath];
//    [_2Path moveToPoint: CGPointMake(11.78, 62.89)];
//    [_2Path addLineToPoint: CGPointMake(1.78, 58.89)];
//    [_2Path addLineToPoint: CGPointMake(-0.22, 73.89)];
//    [_2Path addLineToPoint: CGPointMake(12.78, 72.89)];
//    [_2Path addLineToPoint: CGPointMake(11.78, 62.89)];
//    [_2Path closePath];
//    [_2Path moveToPoint: CGPointMake(9.78, 57.89)];
//    [_2Path addLineToPoint: CGPointMake(9.78, 57.89)];
//    [_2Path addCurveToPoint: CGPointMake(13.78, 61.89) controlPoint1: CGPointMake(11.99, 57.89) controlPoint2: CGPointMake(13.78, 59.68)];
//    [_2Path addCurveToPoint: CGPointMake(9.78, 65.89) controlPoint1: CGPointMake(13.78, 64.1) controlPoint2: CGPointMake(11.99, 65.89)];
//    [_2Path addCurveToPoint: CGPointMake(5.78, 61.89) controlPoint1: CGPointMake(7.57, 65.89) controlPoint2: CGPointMake(5.78, 64.1)];
//    [_2Path addLineToPoint: CGPointMake(5.78, 61.89)];
//    [_2Path addCurveToPoint: CGPointMake(9.78, 57.89) controlPoint1: CGPointMake(5.78, 59.68) controlPoint2: CGPointMake(7.57, 57.89)];
//    [_2Path closePath];
//    [_2Path moveToPoint: CGPointMake(53.47, 37.37)];
//    [_2Path addLineToPoint: CGPointMake(60.13, 45.84)];
//    [_2Path addLineToPoint: CGPointMake(69.36, 33.85)];
//    [_2Path addLineToPoint: CGPointMake(57.6, 28.21)];
//    [_2Path addLineToPoint: CGPointMake(53.47, 37.37)];
//    [_2Path closePath];
//    [_2Path moveToPoint: CGPointMake(57.3, 39.01)];
//    [_2Path addLineToPoint: CGPointMake(57.3, 39.01)];
//    [_2Path addCurveToPoint: CGPointMake(51.83, 40.47) controlPoint1: CGPointMake(56.19, 40.92) controlPoint2: CGPointMake(53.75, 41.58)];
//    [_2Path addCurveToPoint: CGPointMake(50.37, 35.01) controlPoint1: CGPointMake(49.92, 39.37) controlPoint2: CGPointMake(49.27, 36.92)];
//    [_2Path addCurveToPoint: CGPointMake(55.83, 33.54) controlPoint1: CGPointMake(51.47, 33.09) controlPoint2: CGPointMake(53.92, 32.44)];
//    [_2Path addLineToPoint: CGPointMake(55.83, 33.54)];
//    [_2Path addLineToPoint: CGPointMake(55.83, 33.54)];
//    [_2Path addCurveToPoint: CGPointMake(57.3, 39.01) controlPoint1: CGPointMake(57.75, 34.65) controlPoint2: CGPointMake(58.4, 37.09)];
//    [_2Path closePath];
//    _2Path.miterLimit = 4;
//    
//    [UIColor.blackColor setFill];
//    [_2Path fill];
//
//
//}

//- (void)drawRect:(CGRect)rect
//{
//    
//    //// General Declarations
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    //// Shadow Declarations
//    UIColor* shadow = [UIColor.blueColor colorWithAlphaComponent: 0.48];
//    CGSize shadowOffset = CGSizeMake(10.1, 6.1);
//    CGFloat shadowBlurRadius = 20;
//    
//    //// Image Declarations
//    UIImage* image = [UIImage imageNamed: @"image.png"];
//    
//    //// 形状_1 Drawing
//    UIBezierPath* _1Path = UIBezierPath.bezierPath;
//    [_1Path moveToPoint: CGPointMake(152.85, 199.9)];
//    [_1Path addLineToPoint: CGPointMake(152.85, 165.99)];
//    [_1Path addCurveToPoint: CGPointMake(214.43, 117.31) controlPoint1: CGPointMake(168.2, 162.43) controlPoint2: CGPointMake(193.78, 151.39)];
//    [_1Path addLineToPoint: CGPointMake(201.12, 109.23)];
//    [_1Path addCurveToPoint: CGPointMake(152.85, 149.9) controlPoint1: CGPointMake(184.8, 136.17) controlPoint2: CGPointMake(165.37, 146.18)];
//    [_1Path addLineToPoint: CGPointMake(152.85, 107.89)];
//    [_1Path addLineToPoint: CGPointMake(152.55, 107.95)];
//    [_1Path addCurveToPoint: CGPointMake(195.62, 44.09) controlPoint1: CGPointMake(182.08, 102.21) controlPoint2: CGPointMake(201.36, 73.62)];
//    [_1Path addCurveToPoint: CGPointMake(131.76, 1.01) controlPoint1: CGPointMake(189.88, 14.56) controlPoint2: CGPointMake(161.29, -4.73)];
//    [_1Path addCurveToPoint: CGPointMake(88.68, 64.87) controlPoint1: CGPointMake(102.23, 6.75) controlPoint2: CGPointMake(82.94, 35.34)];
//    [_1Path addCurveToPoint: CGPointMake(130.83, 107.76) controlPoint1: CGPointMake(92.85, 86.33) controlPoint2: CGPointMake(109.45, 103.22)];
//    [_1Path addLineToPoint: CGPointMake(131.45, 146.42)];
//    [_1Path addCurveToPoint: CGPointMake(81.19, 109.03) controlPoint1: CGPointMake(118.7, 143.39) controlPoint2: CGPointMake(98.96, 134.54)];
//    [_1Path addLineToPoint: CGPointMake(68.43, 117.95)];
//    [_1Path addCurveToPoint: CGPointMake(131.45, 162.32) controlPoint1: CGPointMake(90.47, 149.59) controlPoint2: CGPointMake(115.76, 159.4)];
//    [_1Path addLineToPoint: CGPointMake(131.45, 200.42)];
//    [_1Path addCurveToPoint: CGPointMake(88.14, 273.79) controlPoint1: CGPointMake(120.09, 207.07) controlPoint2: CGPointMake(94.48, 226.98)];
//    [_1Path addLineToPoint: CGPointMake(103.56, 275.89)];
//    [_1Path addCurveToPoint: CGPointMake(138.09, 214.6) controlPoint1: CGPointMake(108.83, 237) controlPoint2: CGPointMake(128.98, 220.28)];
//    [_1Path addLineToPoint: CGPointMake(147.13, 214.6)];
//    [_1Path addCurveToPoint: CGPointMake(181.65, 275.89) controlPoint1: CGPointMake(156.23, 220.28) controlPoint2: CGPointMake(176.38, 237)];
//    [_1Path addLineToPoint: CGPointMake(197.08, 273.79)];
//    [_1Path addCurveToPoint: CGPointMake(152.85, 199.9) controlPoint1: CGPointMake(190.56, 225.69) controlPoint2: CGPointMake(163.7, 206)];
//    [_1Path closePath];
//    _1Path.miterLimit = 4;
//    
//    CGContextSaveGState(context);
//    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
//    CGContextBeginTransparencyLayer(context, NULL);
//    CGContextSaveGState(context);
//    [_1Path addClip];
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextDrawTiledImage(context, CGRectMake(68, 0, image.size.width, image.size.height), image.CGImage);
//    CGContextRestoreGState(context);
//    CGContextEndTransparencyLayer(context);
//    CGContextRestoreGState(context);
//}

//- (void)drawRect:(CGRect)rect
//{
//    //// General Declarations
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    //// Gradient Declarations
//    CGFloat gradientLocations[] = {0, 0.32, 1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.greenColor.CGColor, (id)[MKJView mixColor1:[UIColor greenColor] color2:[UIColor whiteColor] ratio:0.5].CGColor, (id)UIColor.whiteColor.CGColor], gradientLocations);
//    
//    //// Oval Drawing
//    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(104, 63, 24, 24)];
//    CGContextSaveGState(context);
//    [ovalPath addClip];
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(116, 63), CGPointMake(116, 87), 0);
//    CGContextRestoreGState(context);
//    
//    
//    //// Text Drawing
////    CGRect textRect = CGRectMake(110, 69, 13, 12);
////    {
////        NSString* textContent = @"D";
////        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
////        textStyle.alignment = NSTextAlignmentLeft;
////        
////        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
////        
////        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
////        CGContextSaveGState(context);
////        CGContextClipToRect(context, textRect);
////        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
////        CGContextRestoreGState(context);
////    }
//    
//    
//    //// Cleanup
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//
//}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 0.32, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.greenColor.CGColor, (id)[MKJView mixColor1:[UIColor greenColor] color2:[UIColor whiteColor] ratio:0.5].CGColor, (id)UIColor.whiteColor.CGColor], gradientLocations);
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 24, 24)];
    CGContextSaveGState(context);
    [ovalPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(12, 0), CGPointMake(12, 24), 0);
    CGContextRestoreGState(context);
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(6, 6, 13, 12);
    {
        NSString* textContent = @"D";
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    
}

+(UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio
{
    if(ratio > 1)
        ratio = 1;
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
    //    NSLog(@"Red1: %f", components1[0]);
    //    NSLog(@"Green1: %f", components1[1]);
    //    NSLog(@"Blue1: %f", components1[2]);
    //    NSLog(@"Red2: %f", components2[0]);
    //    NSLog(@"Green2: %f", components2[1]);
    //    NSLog(@"Blue2: %f", components2[2]);
    
    NSLog(@"ratio = %f",ratio);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    //    CGFloat alpha = components1[3]*ratio + components2[3]*(1-ratio);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
