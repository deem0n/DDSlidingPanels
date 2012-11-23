//
//  DDNavigationControllerWithSliders.m
//  com.yasp.slidingPanels
//
//  Created by Дмитрий Дорофеев on 10/24/12.
//  Copyright (c) 2012 Дмитрий Дорофеев. All rights reserved.
//
/*
 This code is distributed under the terms and conditions of the MIT license.
 
 Copyright (c) 2012 Дмитрий Дорофеев
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "DDNavigationControllerWithSliders.h"
#import "DDSlidingView.h"
// make sure non-Clang compilers can still compile
#ifndef __has_feature
#define __has_feature(x) 0
#endif

// no ARC ? -> declare the ARC attributes we use to be a no-op, so the compiler won't whine
#if ! __has_feature( objc_arc )
#define __autoreleasing
#define __bridge
#endif
#define ARRAY(...) ([NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)])

@interface DDNavigationControllerWithSliders ()

@end

@implementation DDNavigationControllerWithSliders

@synthesize topSlidingView=_topSlidingView;
@synthesize leftSlidingView=_leftSlidingView;
@synthesize rightSlidingView=_rightSlidingView;
@synthesize bottomSlidingView=_bottomSlidingView;

@synthesize topSlidingViewControllerId=_topSlidingViewControllerId;
@synthesize leftSlidingViewControllerId=_leftSlidingViewControllerId;
@synthesize rightSlidingViewControllerId=_rightSlidingViewControllerId;
@synthesize bottomSlidingViewControllerId=_bottomSlidingViewControllerId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setTopSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length {
    _topSlidingView = [[DDSlidingView alloc] initWithPosition: DDSliderPositionTop image: image length: length];
    _topSlidingViewControllerId = @"";
}

- (void) setLeftSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length {
    _leftSlidingView = [[DDSlidingView alloc] initWithPosition: DDSliderPositionLeft image: image length: length];
    _leftSlidingViewControllerId = @"";
}

- (void) setRightSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length {
    _rightSlidingView = [[DDSlidingView alloc] initWithPosition: DDSliderPositionRight image: image length: length];
    _rightSlidingViewControllerId = @"";
}

- (void) setBottomSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length {
    _bottomSlidingView = [[DDSlidingView alloc] initWithPosition: DDSliderPositionBottom image: image length: length];
    _bottomSlidingViewControllerId = @"";
}



-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    NSLog(@"%@ DD childs: %@", _leftSlidingViewControllerId, self.childViewControllers);
    
    DDSlidingView *views[] = {_leftSlidingView, _rightSlidingView, _topSlidingView, _bottomSlidingView};
    NSString *ids[] = {_leftSlidingViewControllerId, _rightSlidingViewControllerId, _topSlidingViewControllerId, _bottomSlidingViewControllerId};
    
    for (int i=0; i < 4; i++) {
        DDSlidingView* slidingView = views[i];
        NSString *id = ids[i];
        if ( slidingView != nil ) {
            [slidingView attachToView:self.view];
            
            if ( id.length > 0) {
                // toBeEmbedded
                UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:id];
                if ( vc != nil ){

                    self.definesPresentationContext = YES;
                    
                    [self addChildViewController:vc];
                    
                    [slidingView setControllerSubview: vc.view];
                    slidingView.viewController = vc;
                    [vc didMoveToParentViewController:self];
                    
                    // FIXME = addConstraints
                    slidingView.clipsToBounds = YES;
                }
            }
        }
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
