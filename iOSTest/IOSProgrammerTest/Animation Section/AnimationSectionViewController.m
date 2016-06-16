//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AnimationSectionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fallingLogoView;


@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self animateLogoWithRotation];

}
-(void)animateLogoWithRotation {
    
    // Set spin animation on logoImageView
    CABasicAnimation *rotationAnimation = [CABasicAnimation
                                           animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(0)];
    [rotationAnimation setToValue:DegreesToNumber(360)];
    [rotationAnimation setDuration:3.0f];
    [rotationAnimation setRepeatCount:2000];
    
    [[[self logoImageView] layer] addAnimation:rotationAnimation forKey:@"rotate"];

}
// Helper methods add definitions to degrees and rotation
CGFloat DegreesToRadians(CGFloat degrees)
{
    // Animate 360 degrees
    return degrees * M_PI / 180;
}

NSNumber* DegreesToNumber(CGFloat degrees)
{
    // Animate counter-clockwise
    return [NSNumber numberWithFloat:
            DegreesToRadians(-degrees)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

@end
