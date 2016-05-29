//
//  HelpCollectionViewCell.m
//  Bankable Birthday
//
//  Created by Raj on 29/05/16.
//  Copyright © 2016 Raj Kadam. All rights reserved.
//

#import "HelpCollectionViewCell.h"

@implementation HelpCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.screenNumber.layer.cornerRadius = self.screenNumber.bounds.size.width/2;
    self.screenNumber.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.screenNumber.layer.borderWidth = 0.5f;
}

@end
