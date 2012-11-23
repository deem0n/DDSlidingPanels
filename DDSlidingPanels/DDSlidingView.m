//
//  DDSlidingView.m
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

#import <QuartzCore/QuartzCore.h>
#import "DDSlidingView.h"

@implementation DDSlidingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (DDSlidingView*) initWithPosition: (DDSliderPosition) position
                              image: (UIImage*) image
                             length: (CGFloat) length {
    return [self initWithPosition:position image:image length:length headPadding:0.0f trailPadding:0.0f];
}

- (DDSlidingView*) initWithPosition: (DDSliderPosition) position
                              image: (UIImage*) image
                             length: (CGFloat) length
                        headPadding: (CGFloat) headPadding
                       trailPadding: (CGFloat) trailPadding
{
    
    _position = position;
    _sliderOffset = _sliderLength = length;
    _animationDuration = 0.6f;
    _isShown = NO;
    _headPadding = headPadding;
    _trailPadding = trailPadding;
    _dragButtonHiddenWhenSliderHidden = NO;
    _dragButtonHiddenWhenSliderShown = NO;
    _showSliderImage = image;
    
    switch (_position) {
        case DDSliderPositionLeft:
        case DDSliderPositionRight:
            _dragButtonLength = image.size.width;
            break;
        case DDSliderPositionTop:
        case DDSliderPositionBottom:
            _dragButtonLength = image.size.height;
            break;
    }
    
    
    
    self = [super init];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.layer.cornerRadius = 7.0f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 0.5f;
    
    if (self) {
        _dragButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dragButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_dragButton setBackgroundImage:image forState: UIControlStateNormal];
        [_dragButton setBackgroundImage:image forState: UIControlStateHighlighted];
        [_dragButton addTarget:self action:@selector(dragButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDragButton:)];
        
        [_dragButton addGestureRecognizer: _panGestureRecognizer];
        
    }
    return self;
    
}

- (void) setControllerSubview: (UIView*) subview {

    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }

    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: subview];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self,subview);
    
    NSString *constraint = [NSString stringWithFormat: @"|[subview]|"];
    [self addConstraintText:constraint toView:self withDictionary:viewsDictionary];

    constraint = [NSString stringWithFormat: @"V:|[subview]|"];
    [self addConstraintText:constraint toView:self withDictionary:viewsDictionary];
 
}

- (void) addConstraintText: (NSString*) text toView: (UIView*) view withDictionary: (NSDictionary*) dict{

    NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat: text
                                                          options:0
                                                          metrics:nil
                                                            views:dict];
    [view addConstraints:constraints];
}

- (void) attachToView: (UIView*) parentView {
    // if we are reparenting it is probably importnat to clean up constraints ???
    [self removeConstraints: self.constraints];
    [_dragButton removeConstraints: _dragButton.constraints];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [parentView addSubview: self];
    [parentView addSubview: _dragButton];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self,_dragButton);
    NSString * constraint1;
    
    switch (_position) {
        case DDSliderPositionLeft:
            constraint1 = [NSString stringWithFormat: @"V:|-(%f)-[self]-(%f)-|", _headPadding, _trailPadding];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            constraint1 = [NSString stringWithFormat: @"[self(%f)][_dragButton(%f)]", _sliderLength, _dragButtonLength];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            
            _positionConstraint = [NSLayoutConstraint
                                constraintWithItem:parentView
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                         attribute:NSLayoutAttributeLeft
                                        multiplier:1.0
                                          constant:_sliderOffset];
            
            [parentView addConstraint:_positionConstraint];
            
            [parentView addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self
                                                attribute:NSLayoutAttributeCenterY
                                                relatedBy:0
                                                   toItem:_dragButton
                                                attribute:NSLayoutAttributeCenterY
                                               multiplier:1.0
                                                 constant:0]
             ];
            break;
        case DDSliderPositionRight:
            constraint1 = [NSString stringWithFormat: @"V:|-(%f)-[self]-(%f)-|", _headPadding, _trailPadding];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            constraint1 = [NSString stringWithFormat: @"[_dragButton(%f)][self(%f)]",  _dragButtonLength, _sliderLength];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            
            _positionConstraint = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeRight
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parentView
                                   attribute:NSLayoutAttributeRight
                                   multiplier:1.0
                                   constant:_sliderOffset];
            
            [parentView addConstraint:_positionConstraint];
            
            [parentView addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:0
                                       toItem:_dragButton
                                       attribute:NSLayoutAttributeCenterY
                                       multiplier:1.0
                                       constant:0]
             ];
            break;
        case DDSliderPositionTop:
            
            _sliderOffset = _sliderLength;
            
            app = [UIApplication sharedApplication];
            
            constraint1 = [NSString stringWithFormat: @"|-(%f)-[self]-(%f)-|", _headPadding, _trailPadding];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            constraint1 = [NSString stringWithFormat: @"V:[self(%f)][_dragButton(%f)]", _sliderLength, _dragButtonLength];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            
            _positionConstraint = [NSLayoutConstraint
                                   constraintWithItem:parentView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1.0
                                   constant:_sliderOffset];
            
            [parentView addConstraint:_positionConstraint];
            
            [parentView addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:0
                                       toItem:_dragButton
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                       constant:0]
             ];
            break;
        case DDSliderPositionBottom:
            constraint1 = [NSString stringWithFormat: @"|-(%f)-[self]-(%f)-|", _headPadding, _trailPadding];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            constraint1 = [NSString stringWithFormat: @"V:[_dragButton(%f)][self(%f)]", _dragButtonLength, _sliderLength];
            [self addConstraintText:constraint1 toView:parentView withDictionary:viewsDictionary];
            
            
            _positionConstraint = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parentView
                                   attribute:NSLayoutAttributeBottom
                                   multiplier:1.0
                                   constant:_sliderOffset];
            
            [parentView addConstraint:_positionConstraint];
            
            [parentView addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:0
                                       toItem:_dragButton
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                       constant:0]
             ];
            break;

    }
    
    
    [parentView bringSubviewToFront:self];
    [parentView bringSubviewToFront:_dragButton];
    _dragButton.hidden = _dragButtonHiddenWhenSliderHidden;
}



-(void) dragButtonPressed: (UIButton*) button {
    if (_isShown) {
        [self hideSliderWithDuration:_animationDuration];
    } else {
        [self showSliderWithDuration:_animationDuration];
    }
}

-(void) showSliderWithDuration: (float) time {
    
    if ( _isShown ) return;
    
    _isShown = YES;
    
    _positionConstraint.constant = 0.0f;
    
    [UIView animateWithDuration: time
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.superview layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"SHOWN");
                         [_viewController viewDidAppear:YES];
                         _dragButton.hidden = _dragButtonHiddenWhenSliderShown;
                         if ( !_dragButtonHiddenWhenSliderShown && _hideSliderImage ) {
                             [_dragButton setBackgroundImage:_hideSliderImage forState: UIControlStateNormal];
                             [_dragButton setBackgroundImage:_hideSliderImage forState: UIControlStateHighlighted];
                         }
                     }
     ];
}

-(void) hideSlider {
    [self hideSliderWithDuration:_animationDuration];
}


-(void) showSlider {
    [self showSliderWithDuration:_animationDuration];
}

-(void) hideSliderWithDuration: (float) time {

    if ( _isShown == NO ) return;
    
    _isShown = NO;
    
    _positionConstraint.constant = _sliderOffset;
    
    [UIView animateWithDuration: time
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.superview layoutIfNeeded];
                         
                         // don't need it at all,
                         // actually [self layoutIfNeeded] kills animation !!!!
                         //[_dragButton layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"HIDDEN");
                         [_viewController viewDidDisappear:YES];
                         _dragButton.hidden = _dragButtonHiddenWhenSliderHidden;
                         if ( !_dragButtonHiddenWhenSliderHidden && _showSliderImage ) {
                             [_dragButton setBackgroundImage:_showSliderImage forState: UIControlStateNormal];
                             [_dragButton setBackgroundImage:_showSliderImage forState: UIControlStateHighlighted];
                         }
                     }
     ];
}

- (void) panDragButton:(UIPanGestureRecognizer *)gestureRecognizer
{
    //UIView *_dragButton = [gestureRecognizer view];
    float delta = 0.0f;
    
    CGPoint translation = [gestureRecognizer translationInView: self.superview];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        switch (_position) {
            case DDSliderPositionLeft:
                delta =  _positionConstraint.constant - translation.x;
                break;
            case DDSliderPositionRight:
                delta =  _positionConstraint.constant + translation.x;
                break;
            case DDSliderPositionTop:
                delta = _positionConstraint.constant - translation.y;
                break;
            case DDSliderPositionBottom:
                delta = _positionConstraint.constant + translation.y;
                break;
        }

        //NSLog(@"DELTA: %f, TRANS: %f", delta, translation.x);
        if ( delta > _sliderLength) {
            delta = _sliderOffset;
        } else if ( delta < 0) {
            delta = 0;        }
        [gestureRecognizer setTranslation:CGPointZero inView:self.superview];
        _positionConstraint.constant = delta;
        [self layoutIfNeeded];
        [_dragButton layoutIfNeeded];
        
    } else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [gestureRecognizer velocityInView: _dragButton];
        float movement;

        switch (_position) {
            case DDSliderPositionLeft:
                movement = velocity.x;
                break;
            case DDSliderPositionRight:
                movement = -velocity.x;
                break;
            case DDSliderPositionTop:
                movement = velocity.y;
                break;
            case DDSliderPositionBottom:
                movement = -velocity.y;
                break;
        }
        
        float time = fabs(1.0f/movement*800.0f);
        time = time > 0.4 ? 0.4 : time;
        
        // velocity x is either negative (to the left)
        
        if ( movement < 0 ) {
            [self hideSliderWithDuration: time];
        } else if ( movement > 0 ) {
            [self showSliderWithDuration: time];
        } else {
            // fix constraints
            NSLog(@"FIX CONSTRAINTS ???");
        }
    }
}



@end
