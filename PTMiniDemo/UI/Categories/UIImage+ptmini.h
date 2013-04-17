//
//  UIImage+ptmini.h
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ptmini)

+ (UIImage *)piRoundedRectImageWithSize:(CGSize)size
                              fillColor:(UIColor *)fillColor
                           cornerRadius:(CGFloat)radius;
+ (UIImage *)piStretchableRoundedRectImageWithCornerRadius:(CGFloat)cornerRadius
                                                 lineWidth:(CGFloat)lineWidth
                                               strokeColor:(UIColor *)strokeColor
                                                 fillColor:(UIColor *)fillColor;
@end
