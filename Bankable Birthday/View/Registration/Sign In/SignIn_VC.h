//
//  SignIn_VC.h
//  Bankable Birthday
//
//  Created by Raj on 29/05/16.
//  Copyright © 2016 Raj Kadam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKLeftViewTF.h"

@interface SignIn_VC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet RKLeftViewTF *txt_username;
@property (weak, nonatomic) IBOutlet RKLeftViewTF *txt_password;
@property (strong, nonatomic) IBOutlet UIImageView *userisIcon;
@property (strong, nonatomic) IBOutlet UIImageView *passwordIcon;

@property (weak, nonatomic) IBOutlet UIButton *btnlogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterNow;
- (IBAction)loginClicked:(id)sender;
- (IBAction)forgotPasswordClicked:(id)sender;
- (IBAction)fbClicked:(id)sender;
- (IBAction)twClicked:(id)sender;
- (IBAction)gmailClicked:(id)sender;
- (IBAction)registerNowClicked:(id)sender;





@end
