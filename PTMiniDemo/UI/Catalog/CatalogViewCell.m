//
//  CatalogViewCell.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/10.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "CatalogViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ptmini.h"

@interface CatalogViewCell () {
    
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CatalogViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.borderWidth = 5.0f;
        self.contentView.layer.cornerRadius = 8.0f;
        self.contentView.backgroundColor = [UIColor piLightLightGrayColor];
    
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 120.0f, 0.0f, 0.0f)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:28.0];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    // center in x direction
    CGFloat horizontalCenter = CGRectGetMidX(self.bounds);
    self.titleLabel.center = CGPointMake(horizontalCenter, self.titleLabel.center.y);
}

- (void)setImage:(UIImage *)image {
    
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.contentView.layer.borderColor = borderColor.CGColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
