//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"

@interface LoginSectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextInput;
@property (assign, nonatomic) BOOL isUserLoginValid;


@end

@implementation LoginSectionViewController

#pragma  viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Allow username/password secure entry
    self.passwordTextInput.secureTextEntry = YES;
    self.usernameTextInput.secureTextEntry = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Navigation
-(IBAction)backButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}
#pragma POST Request 
- (IBAction)loginButtonTapped:(UIButton *)login
{
    // Listen for the post request
    [self receivePostRequestOutput];
    if ([self.usernameTextInput.text isEqualToString:@"SuperBoise"] && [self.passwordTextInput.text isEqualToString:@"qwerty"]) {
        NSLog(@"Correct Username and Passwords!");
    } else {
        NSLog(@"Incorrect Username and Password!");
    }
    // Dismiss keyboard after username/password input
    [self.usernameTextInput endEditing:YES];
    [self.usernameTextInput resignFirstResponder];
    [self.passwordTextInput endEditing:YES];
    [self.passwordTextInput resignFirstResponder];
}
// Initialize POST request
-(void)receivePostRequestOutput {
    // Make a request with correct URL
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:2.0f];

    // Set POST method to the correct username,password
    [request setHTTPMethod:@"POST"];
    NSMutableString *POST = [NSMutableString string];
    [POST appendFormat:@"&%@=%@", @"username", self.usernameTextInput.text];
    [POST appendFormat:@"&%@=%@", @"password", self.passwordTextInput.text];
    

    // Encode the POST
    NSData *postData = [POST dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // Calculate the length of the data
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    // Set url to required URL
    [request setURL:[NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"]];
    NSString *postString = @"username=SuperBoise&password=qwerty";
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    // Set the value for HTTP header field
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // Set an encoded value for HTTP header field
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // Set the HTTP body
    [request setHTTPBody:postData];
    // Set a connection object
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    // Verify if connection was made
    if(connection) {
        NSLog(@"\nConnection successful\n");
        // Send request to background queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSError *requestError = nil;
                NSURLResponse *sessionResponse = nil;
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&sessionResponse error:&requestError];
                // Time how long the api call took
                NSTimeInterval timeAPIRequest = [NSDate timeIntervalSinceReferenceDate];
                // Send request back on main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Time API request in milliseconds (*1000)
                    NSTimeInterval elapsedTimer = ([NSDate timeIntervalSinceReferenceDate] - timeAPIRequest) * 1000;
                    // Translate JSON file into a Dictionary with NSJSONSerializer
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    // UIAlert shows how longh the api call took & a response back w/ code, message
                    UIAlertController *alertMessage = [UIAlertController alertControllerWithTitle:[dict valueForKey:@"code"]
                                                                                   message: [NSString stringWithFormat:@"%@\n\nHello! The API call took %f milliseconds",[dict valueForKey:@"message"], elapsedTimer]
                                                                            preferredStyle:UIAlertControllerStyleActionSheet];
                    // Dismiss alert message
                    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        // Bring action back on main queue
                        if ([[dict valueForKey:@"code"] isEqualToString: @"Success"]) [self backButton:nil];
                    }];
                    [alertMessage addAction:dismiss];
                    // Present alert message
                    [self presentViewController:alertMessage animated:YES completion:nil];
                    
                });
            });

    } else {
        NSLog(@"\nConnection failed\n");
    }
}
-(BOOL)prefersStatusBarHidden {
    // Hide status bar
    return YES;
}
@end
