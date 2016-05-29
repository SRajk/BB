//
//  SignIn_VC.m
//  Bankable Birthday
//
//  Created by Raj on 29/05/16.
//  Copyright © 2016 Raj Kadam. All rights reserved.
//

#import "SignIn_VC.h"

@interface SignIn_VC ()

@end

@implementation SignIn_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Navigation Header
    NSString*titleText = @"Log In";
    
    UIFont* titleFont = [UIFont fontWithName:@"Helvetica" size:14];
    CGSize requestedTitleSize = [titleText sizeWithAttributes:@{NSFontAttributeName: titleFont}];
    CGFloat titleWidth = MIN(self.navigationController.navigationBar.frame.size.width - 100, requestedTitleSize.width);
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, 20)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.text = titleText;
    self.navigationItem.titleView = navLabel;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.bgImage.image blurredImage:0.7];
    
    self.btnlogin.layer.borderWidth = 1;
    self.btnlogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.btnlogin.layer.cornerRadius = 4;
    self.btnRegisterNow.layer.borderWidth = 1;
    self.btnRegisterNow.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.btnRegisterNow.layer.cornerRadius = 4;
    
    
    [_userisIcon setFrame:CGRectMake(0.0, 0.0, 45.0, 20.0)];
    [_passwordIcon setFrame:CGRectMake(0.0, 0.0, 45.0, 20.0)];
    
    //userID field
    [_txt_username setLeftView:_userisIcon];
    [_txt_username configureForLeftViewUnderline];
    
    
    //password field
    [_txt_password setLeftView:_passwordIcon];
    [_txt_password configureForLeftViewUnderline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginClicked:(id)sender {
}

- (IBAction)forgotPasswordClicked:(id)sender {
}

- (IBAction)fbClicked:(id)sender {
}

- (IBAction)twClicked:(id)sender {
}

- (IBAction)gmailClicked:(id)sender {
}

- (IBAction)registerNowClicked:(id)sender {
}
@end
