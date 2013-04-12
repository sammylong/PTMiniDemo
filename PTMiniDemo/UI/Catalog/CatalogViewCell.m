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
#import <AVFoundation/AVFoundation.h>


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
        self.contentView.layer.borderWidth = 4.0f;
        self.contentView.layer.cornerRadius = 8.0f;
        self.contentView.backgroundColor = [UIColor piLightLightGrayColor];
    
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.contentView.layer.borderColor = borderColor.CGColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // center in x direction
    CGFloat horizontalCenter = CGRectGetMidX(self.bounds);
    CGFloat verticalCenter = CGRectGetHeight(self.bounds) * 0.8f;
    self.titleLabel.center = CGPointMake(horizontalCenter, verticalCenter);
    
    if (self.image) {
        if (_imageView == nil) {
            // create one
            _imageView = [[UIImageView alloc] init];
            [self.contentView addSubview:_imageView];
        }
        CGFloat size = CGRectGetWidth(self.bounds) * 0.6f;
        CGRect rect = CGRectMake(0.0f, 0.0f, size, size);
        CGRect bounds = AVMakeRectWithAspectRatioInsideRect(_image.size, rect);
        _imageView.bounds = bounds;
        CGFloat y = CGRectGetHeight(self.bounds) * 0.4f;
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), y);
        _imageView.center = center;
        _imageView.image = self.image;
    }
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
