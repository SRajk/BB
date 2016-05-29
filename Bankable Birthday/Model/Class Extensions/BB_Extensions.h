//
//  BB_Extensions.h
//  Wrappd
//
//  Created by Raj on 14/01/16.
//  Copyright (c) 2015 Last Local App Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (BB_Extensions)
- (UIImage*)screenshot;
-(void)addBorder:(float)width radius:(float)radius;
-(void)addDropShadow;
@end

@interface UIImage (BB_Extensions)

- (UIImage *)blurredImage:(CGFloat)blurRate;

@end

@interface NSString (BB_Extensions)
- (BOOL) validateTextOnly;
- (BOOL) validatePhoneNumber;
- (BOOL) validateDigitOnlyl;
- (BOOL) validateEmail;
- (BOOL) validateEmpty;
- (NSString *)urlencode;
-(NSString*) trimWhitespaces;
- (NSString *)stringByURLDecode;
- (NSString *) md5;

- (NSString*)stripHtml;

@end

@interface NSDate (BB_Extensions)

-(NSString*)addEventToCalender:(NSString *)titleString;
-(void)deleteEventForID:(NSString*)idString;
-(void)editEventForID:(NSString*)idString;
-(NSDate*)addDay:(int)days;
@end

@interface NSMutableArray (BB_Extensions)
- (void)shuffle;

@end

