//
//  UIImage+ptmini.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "UIImage+ptmini.h"

@implementation UIImage (ptmini)

+ (UIImage *)piStretchableRoundedRectImageWithCornerRadius:(CGFloat)cornerRadius
                                                 lineWidth:(CGFloat)lineWidth
                                               strokeColor:(UIColor *)strokeColor
                                                 fillColor:(UIColor *)fillColor {
	UIImage *image = nil;
	CGSize size = CGSizeMake(cornerRadius * 2.0f + 1.0f + lineWidth, cornerRadius * 2.0f + 1.0f + lineWidth);
    
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	CGRect rect = CGRectZero;
	rect.size = size;
	rect = CGRectInset(rect, lineWidth/2.0f, lineWidth/2.0f);
	UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    
	CGContextAddPath(ctx, bezierPath.CGPath);
	[fillColor setFill];
	CGContextFillPath(ctx);
    
	CGContextAddPath(ctx, bezierPath.CGPath);
	CGContextSetLineWidth(ctx, lineWidth);
	[strokeColor setStroke];
	CGContextStrokePath(ctx);
    
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
		image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
	} else {
		image = [image stretchableImageWithLeftCapWidth:cornerRadius topCapHeight:cornerRadius];
	}
	return image;
}

@end
