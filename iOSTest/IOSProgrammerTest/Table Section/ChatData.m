//
//  ChatData.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/19/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatData.h"
#import "AvatarImageNotification.h"


@implementation ChatData

- (void)loadWithDictionary:(NSDictionary *)dict
{
    self.user_id = [[dict objectForKey:@"user_id"] intValue];
    self.username = [dict objectForKey:@"username"];
    self.avatar_url = [dict objectForKey:@"avatar_url"];
    self.message = [dict objectForKey:@"message"];
    
//     //Start downloading data on the main queue
//     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//         // Enter the back queue
//         UIImage *avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.avatar_url]]];
//         // Re-Enter the main queue
//         dispatch_async(dispatch_get_main_queue(), ^{
//             [[NSNotificationCenter defaultCenter] postNotificationName:AvatarImageNotificationCenter
//                                                                 object:self];
//             
//             self.avatarImage = avatarImage;
//         });
//     });
//
    
    
    }

@end