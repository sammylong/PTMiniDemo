//
//  OptionView.m
//  PTMiniDemo
//
//  Created by Sammy Long on 13/4/12.
//  Copyright (c) 2013年 Apexlearn Inc. All rights reserved.
//

#import "OptionView.h"
#import "UIColor+ptmini.h"

@interface OptionView () {
    CGPoint _start;
    CGPoint _relativePos;
}

@end

@implementation OptionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    _textLabel.text = text;
    [_textLabel sizeToFit];    
}

- (void)showInView:(UIView *)view
          animated:(BOOL)animated
          duration:(NSTimeInterval)duration
             delay:(NSTimeInterval)delay
        completion:(ALCompletionBlock)completionBlock {
    // implement in child class
}

- (void)dismiss:(BOOL)animated
       duration:(NSTimeInterval)duration
          delay:(NSTimeInterval)delay
completionBlock:(ALCompletionBlock)completionBlock {
    // implement in child class
}


#pragma mark Private

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.locked == NO) {
        [self.delegate optionViewBeganDragging:self];
        CGPoint point = [[touches anyObject] locationInView:self];
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _start = [[touches anyObject] locationInView:self.superview];
        _relativePos = CGPointMake(center.x - point.x, center.y - point.y);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.locked == NO) {
        CGPoint end = [[touches anyObject] locationInView:self];
        CGFloat dist = (end.x - _start.x) * (end.x - _start.x)
        +  (end.y - _start.y) * (end.y - _start.y);
        if (dist > 40.0f) {
            // call delegate
            [self.delegate optionViewEndDragging:self];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.locked == NO) {
        CGPoint point = [[touches anyObject] locationInView:self.superview];
        CGPoint center = CGPointMake(point.x + _relativePos.x,
                                     point.y + _relativePos.y);
        self.center = center;
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


+ (CGFloat)defaultWidth {
    // child class implement
    return 0.0f;
}
+ (CGFloat)defaultHeight {
    // child class implement
    return 0.0f;
}

@end
