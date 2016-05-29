//
//  ViewController.h
//  Bankable Birthday
//
//  Created by Raj on 29/05/16.
//  Copyright © 2016 Raj Kadam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Help_VC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *helpCollectionView;

// Page controller

@property (weak, nonatomic) IBOutlet UIPageControl *pgControl;


// Skip Btn
- (IBAction)skipClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
@end

