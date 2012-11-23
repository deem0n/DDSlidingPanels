//
//  FisrstViewController.m
//  com.yasp.slidingPanels
//
//  Created by Дмитрий Дорофеев on 11/23/12.
//  Copyright (c) 2012 Дмитрий Дорофеев. All rights reserved.
//

#import "FisrstViewController.h"
#import "DDNavigationControllerWithSliders.h"

@interface FisrstViewController ()

@end

@implementation FisrstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showTopPanel:(id)sender {
    DDNavigationControllerWithSliders * controller = (DDNavigationControllerWithSliders*) [UIApplication sharedApplication].delegate.window.rootViewController;
    [controller.topSlidingView showSlider];
}


// if top panel is shown, hide it before we display secondViewController
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DDNavigationControllerWithSliders * controller = (DDNavigationControllerWithSliders*) [UIApplication sharedApplication].delegate.window.rootViewController;
    [controller.topSlidingView hideSlider];
}
@end
