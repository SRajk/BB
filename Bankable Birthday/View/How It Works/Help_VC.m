//
//  ViewController.m
//  Bankable Birthday
//
//  Created by Raj on 29/05/16.
//  Copyright © 2016 Raj Kadam. All rights reserved.
//

#import "Help_VC.h"
#import "HelpCollectionViewCell.h"
#import "SignIn_VC.h"

@interface Help_VC ()

@end

@implementation Help_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.helpCollectionView registerNib:[UINib nibWithNibName:@"HelpCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    
    self.pgControl.numberOfPages = 3;
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     [collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    float width = collectionView.frame.size.width-0;
    float height = collectionView.frame.size.height-5;
    NSLog(@"Width %f",width);
    
    
    return CGSizeMake(width, height);
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (HelpCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*reuseIdentifier = @"cell";
    HelpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(HelpCollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.screenNumber.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    
    cell.lbl_description.text = @"Birthday[10655:4912432] Width 320.000000 2016-05-29 15:32:30.503 Bankable Birthday[10655:4912432] Width 320.000000 2016-05-29 15:32:30.503 Bankable Birthday[10655:4912432] Width 320.000000";
    
}

#pragma -mark

#pragma -mark S
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _helpCollectionView.frame.size.width;//255.0f; //self.myCollectionView.frame.size.width;
    self.pgControl.currentPage = self.helpCollectionView.contentOffset.x / (pageWidth-10);
   
}



#pragma -mark Skip Btn
- (IBAction)skipClicked:(id)sender {
    
    SignIn_VC*sign_in = [[SignIn_VC alloc] initWithNibName:@"SignIn_VC" bundle:nil];
    
    [self.navigationController pushViewController:sign_in animated:YES];
//    [self presentViewController:sign_in animated:YES completion:nil];
}
@end
