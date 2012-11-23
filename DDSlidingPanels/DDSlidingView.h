//
//  DDSlidingView.h
//  com.yasp.slidingPanels
//
//  Created by Дмитрий Дорофеев on 10/18/12.
//  Copyright (c) 2012 Дмитрий Дорофеев. All rights reserved.
//

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
