//
//  DDNavigationControllerWithSliders.h
//  com.yasp.slidingPanels
//
//  Created by Дмитрий Дорофеев on 10/24/12.
//  Copyright (c) 2012 Дмитрий Дорофеев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSlidingView.h"

@interface DDNavigationControllerWithSliders : UIViewController

@property (nonatomic, readonly) DDSlidingView* topSlidingView;
@property (nonatomic, readonly) DDSlidingView* leftSlidingView;
@property (nonatomic, readonly) DDSlidingView* rightSlidingView;
@property (nonatomic, readonly) DDSlidingView* bottomSlidingView;

@property (nonatomic, strong) NSString* topSlidingViewControllerId;
@property (nonatomic, strong) NSString* leftSlidingViewControllerId;
@property (nonatomic, strong) NSString* rightSlidingViewControllerId;
@property (nonatomic, strong) NSString* bottomSlidingViewControllerId;


- (void) setTopSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length;
- (void) setLeftSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length;
- (void) setRightSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length;
- (void) setBottomSlidingViewWithSliderImage: (UIImage*) image length: (CGFloat) length;


@end
