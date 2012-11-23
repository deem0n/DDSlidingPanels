//
//  DDSlidingView.h
//  com.yasp.slidingPanels
//
//  Created by Дмитрий Дорофеев on 10/18/12.
//  Copyright (c) 2012 Дмитрий Дорофеев. All rights reserved.
//
/*
 This code is distributed under the terms and conditions of the MIT license.
 
 Copyright (c) 2012 Дмитрий Дорофеев
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <UIKit/UIKit.h>

typedef enum {
    DDSliderPositionLeft,
    DDSliderPositionBottom,
    DDSliderPositionRight,
    DDSliderPositionTop,
} DDSliderPosition;


@interface DDSlidingView : UIView {
    BOOL _isShown;
    NSLayoutConstraint *_positionConstraint;
    float _dragButtonLength; // depend on dragImage
    float _sliderOffset;
    UIPanGestureRecognizer * _panGestureRecognizer;
}

@property (nonatomic, strong) UIImage* showSliderImage;
@property (nonatomic, strong) UIImage* hideSliderImage;

@property (nonatomic, readonly) CGFloat sliderLength;
@property (nonatomic, assign) CGFloat headPadding;
@property (nonatomic, assign) CGFloat trailPadding;
@property (nonatomic, readonly) DDSliderPosition position; // we currently are not allowing to change position
@property (nonatomic, strong, readonly) UIButton* dragButton;
@property (nonatomic, assign) float animationDuration;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) BOOL dragButtonHiddenWhenSliderHidden;
@property (nonatomic, assign) BOOL dragButtonHiddenWhenSliderShown;




- (DDSlidingView*) initWithPosition: (DDSliderPosition) position
                              image: (UIImage*) image
                             length: (CGFloat) length;

- (DDSlidingView*) initWithPosition: (DDSliderPosition) position
                              image: (UIImage*) image
                             length: (CGFloat) length
                        headPadding: (CGFloat) headPadding
                       trailPadding: (CGFloat) trailPadding;

- (void) attachToView: (UIView*) parentView;
- (void) setControllerSubview: (UIView*) subview;
- (void) hideSlider;
- (void) showSlider;
- (void) showSliderWithDuration: (float) time;
- (void) hideSliderWithDuration: (float) time;

@end
