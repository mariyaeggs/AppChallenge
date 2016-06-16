//
//  LoadingImageViewController.m
//  IOSProgrammerTest
//
//  Created by Mariya Eggensperger on 6/15/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "LoadingImageViewController.h"

@interface LoadingImageViewController ()

@end

@implementation LoadingImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Load images for animation
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"loading_image_iPhone6_loading.png"],
                                        [UIImage imageNamed:@"loading_image_iPhone6_one.png"],
                                        [UIImage imageNamed:@"loading_image_iPhone6_two.png"],
                                        [UIImage imageNamed:@"loading_image_iPhone6_three.png"], nil];
    
    // Set animation duration
    [animatedImageView  setAnimationRepeatCount:1];
    animatedImageView.animationDuration = 3;
    [animatedImageView startAnimating];
    
    [self performSelector:@selector(setDelayAnimationOne) withObject:nil afterDelay:3]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDelayAnimationOne {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [animatedImageView setAlpha:0];
    [UIView commitAnimations];
    
    [self performSelector:@selector(setDelayAnimationTwo) withObject:nil afterDelay:1.0];
    
}
-(void)setDelayAnimationTwo {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [animatedImageView setAlpha:0];
    [UIView commitAnimations];
    
    [self performSelector:@selector(setDelayAnimationThree) withObject:nil afterDelay:1.0];
}
-(void)setDelayAnimationThree {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [loadedImageView setAlpha:0];
    [UIView commitAnimations];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
