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
@property (weak, nonatomic) IBOutlet UIButton *spinButtonTapped;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (assign, nonatomic) BOOL isRotating;

@end

@implementation AnimationSectionViewController

#pragma  viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initialize tap gesture recognizer on logo image view
    UIPanGestureRecognizer *panLogoGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.logoImageView addGestureRecognizer:panLogoGestureRecognizer];
    

}
#pragma Bounce Animation

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         CGRect frame = CGRectMake(40, 70, 240, 30);
                         self.logoImageView.frame = frame;
                     } completion:NULL];
     
}
#pragma Spin Animation

-(void)startLogoAnimation {
    // Start logo 360 animation when spin button tapped
    self.isRotating = YES;
    [self animateLogo360Degrees];

}
-(void)stopLogoAnimation {
    // Stop logo 360 animation if spin button not tapped
    self.isRotating = NO;    
}
-(void)animateLogo360Degrees {
    
    // Set spin animation on logoImageView
    CABasicAnimation *rotationAnimation = [CABasicAnimation
                                           animationWithKeyPath:@"transform.rotation.z"];
    
    [rotationAnimation setFromValue:DegreesToNumber(0)];
    [rotationAnimation setToValue:DegreesToNumber(360)];
    [rotationAnimation setDuration:3.0f];
    // Rotate logo once when spin button tapped
    [rotationAnimation setRepeatCount:1];
    
    [[[self logoImageView] layer] addAnimation:rotationAnimation forKey:@"rotate"];

}
// Helper methods define degrees and rotation
CGFloat DegreesToRadians(CGFloat degrees)
{
    // Animate logo 360 degrees
    return degrees * M_PI / 180;
}

NSNumber* DegreesToNumber(CGFloat degrees)
{
    // Animate logo counter-clockwise , -degrees
    return [NSNumber numberWithFloat:
            DegreesToRadians(-degrees)];
}
// Check for spin button tapped
- (IBAction)spinAction:(id)sender {
    if (self.spinButtonTapped) {
        [self startLogoAnimation];
    } else {
        [self stopLogoAnimation];
    }
}
#pragma Pan Gesture Recognizer

-(void)handlePan:(UIPanGestureRecognizer *)logoGestureRecognizer {
    
    NSLog(@"Logo image is tapped!");
    // Allow pan movement
    CGPoint translation = [logoGestureRecognizer translationInView:self.view];
    logoGestureRecognizer.view.center = CGPointMake(logoGestureRecognizer.view.center.x + translation.x,logoGestureRecognizer.view.center.y + translation.y);
    [logoGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Navigation

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}
-(BOOL)prefersStatusBarHidden {
    // Hide status bar
    return YES;
}

@end
