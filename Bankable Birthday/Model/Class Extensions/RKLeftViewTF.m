//
//  SPLeftViewTF.m
//  Insurance
//
//  Created by Sahil on 07/12/14.
//  Copyright (c) 2014 real360. All rights reserved.
//

#import "RKLeftViewTF.h"

@implementation RKLeftViewTF
-(void) configureForLeftViewUnderline{
    //create a line beneath password field
    UIView *underlineView = [[UIView alloc] initWithFrame:CGRectMake(10.0, self.frame.size.height - 2, self.frame.size.width, 1.0)];
    [underlineView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:underlineView];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBorderStyle:UITextBorderStyleNone];
    [self setTextColor:[UIColor whiteColor]];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    

}

-(void) configureForUnderline{
    //create a line beneath password field
    UIView *underlineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - 2, self.frame.size.width, 1.0)];
    [underlineView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:underlineView];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBorderStyle:UITextBorderStyleNone];
    [self setTextColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    
}

-(void) configureWithoutUnderline{
    //create a line beneath password field
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBorderStyle:UITextBorderStyleNone];
    [self setTextColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
