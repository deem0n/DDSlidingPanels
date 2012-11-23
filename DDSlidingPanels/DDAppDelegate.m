//
//  DDAppDelegate.m
//  com.yasp.slidingPanels
//
//  Created by Дмитрий Дорофеев on 10/18/12.
//  Copyright (c) 2012 Дмитрий Дорофеев. All rights reserved.
//

#import "DDAppDelegate.h"
#import "DDSlidingView.h"
#import "DDNavigationControllerWithSliders.h"

@implementation DDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   DDNavigationControllerWithSliders* controller = (DDNavigationControllerWithSliders*) self.window.rootViewController;
    UIImage * img = [UIImage imageNamed: @"open_panel.png"];
    UIImage * closeImg = [UIImage imageNamed: @"close_panel.png"];
    
    [controller setLeftSlidingViewWithSliderImage:img length:300.0f];
    controller.leftSlidingViewControllerId = @"toBeEmbedded";
    controller.leftSlidingView.hideSliderImage = closeImg;
    controller.leftSlidingView.headPadding = 44.0f;
    

    UIImage * img1 = [UIImage imageWithCGImage:img.CGImage scale:img.scale orientation:UIImageOrientationUpMirrored];
    UIImage * closeImg1 = [UIImage imageWithCGImage:closeImg.CGImage scale: closeImg.scale orientation:UIImageOrientationUpMirrored];
    
    [controller setRightSlidingViewWithSliderImage:img1 length:300.0f];
    controller.rightSlidingViewControllerId = @"toBeEmbeddedRight";
    controller.rightSlidingView.hideSliderImage = closeImg1;
    controller.rightSlidingView.headPadding = 44.0f;
    controller.rightSlidingView.trailPadding = 44.0f;
    
    img1 = [UIImage imageWithCGImage:img.CGImage scale: img.scale orientation:UIImageOrientationRight];
    closeImg1 = [UIImage imageWithCGImage:closeImg.CGImage scale: closeImg.scale orientation:UIImageOrientationRight];
    [controller setTopSlidingViewWithSliderImage:img1 length:300.0f];
    controller.topSlidingView.backgroundColor = [UIColor redColor];
    controller.topSlidingView.hideSliderImage = closeImg1;
    controller.topSlidingView.dragButtonHiddenWhenSliderHidden = YES;
    
    
    img1 = [UIImage imageWithCGImage:img.CGImage scale:img.scale orientation:UIImageOrientationRightMirrored];
    closeImg1 = [UIImage imageWithCGImage:closeImg.CGImage scale: closeImg.scale orientation:UIImageOrientationRightMirrored];
    [controller setBottomSlidingViewWithSliderImage:img1 length:300.0f];

    controller.bottomSlidingView.backgroundColor = [UIColor greenColor];
    controller.bottomSlidingView.hideSliderImage = closeImg1;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
