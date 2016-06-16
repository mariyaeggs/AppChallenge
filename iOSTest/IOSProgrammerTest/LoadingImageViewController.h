//
//  LoadingImageViewController.h
//  IOSProgrammerTest
//
//  Created by Mariya Eggenpserger on 6/15/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingImageViewController : UIViewController {
    
    IBOutlet UIImageView *animatedImageView;
    IBOutlet UIImageView *loadedImageView;
}

-(void)setDelayAnimationOne;
-(void)setDelayAnimationTwo;
-(void)setDelayAnimationThree;

@end
