//
//  UIColor+ptmini.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. Api rights reserved.
//

#import "UIColor+ptmini.h"

@implementation UIColor (ptmini)

+ (UIColor *)piRedColor {
    return [UIColor colorWithRed:0.855f green:0.315f blue:0.246f alpha:1.0f];
}

+ (UIColor *)piOrangeColor {
    return [UIColor colorWithRed:0.944f green:0.46f blue:0.153f alpha:1.0f];
}

+ (UIColor *)piYellowColor {
    return [UIColor colorWithRed:0.935f green:0.695f blue:0.65f alpha:1.0f];
}

+ (UIColor *)piGreenColor {
    return [UIColor colorWithRed:0.0f green:0.685f blue:0.28f alpha:1.0f];
}

+ (UIColor *)piTealColor {
    return [UIColor colorWithRed:0.135f green:0.883f blue:0.705f alpha:1.0f];
}

+ (UIColor *)piBlueColor {
    return [UIColor colorWithRed:0.0f green:0.095f blue:0.295f alpha:1.0f];
}

+ (UIColor *)piLightBlueColor {
    return [UIColor colorWithRed:0.0f green:0.68f blue:0.935f alpha:1.0f];
}

+ (UIColor *)piLightLightGrayColor {
    return [UIColor colorWithRed:0.945f green:0.945f blue:0.95f alpha:1.0f];
}

+ (UIColor *)piPastGrayColor {
    return [UIColor colorWithRed:0.902f green:0.905f blue:0.909f alpha:1.0f];
}

+ (UIColor *)piLightGrayColor {
    return [UIColor colorWithRed:0.735f green:0.74f blue:0.75f alpha:1.0f];
}

+ (UIColor *)piGrayColor {
    return [UIColor colorWithRed:0.50f green:0.505f blue:0.517f alpha:1.0f];
}

+ (UIColor *)piDarkGrayColor {
    return [UIColor colorWithRed:0.345f green:0.35f blue:0.357f alpha:1.0f];
}

+ (UIColor *)piNightBlueColor {
    return [UIColor colorWithRed:0.25f green:0.337f blue:0.447f alpha:1.0f];
}

+ (UIColor *)piNightDarkBlueColor {
    return [UIColor colorWithRed:0.16f green:0.227f blue:0.33f alpha:1.0f];
}

- (UIColor *)piDarkerColor {
    CGFloat red = 0.0f;
    CGFloat green = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat alpha = 0.0f;
    BOOL success = [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    if (success) {
        return [UIColor colorWithRed:(red * red)
                               green:(green * green)
                                blue:(blue * blue)
                               alpha:(alpha * alpha)];
    } else {
        return nil;
    }
}

@end
