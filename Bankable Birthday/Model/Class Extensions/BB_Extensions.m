//
//  BB_Extensions.m
//  Wrappd
//
//  Created by Raj on 14/01/16.
//  Copyright (c) 2015 Last Local App Solutions. All rights reserved.
//

#import "BB_Extensions.h"

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <EventKit/EventKit.h>

#ifdef __IPHONE_8_0
#define GregorianCalendar NSCalendarIdentifierGregorian
#else
#define GregorianCalendar NSGregorianCalendar
#endif


#define NAMEREGEX @"[A-Za-z ]+"
#define DIGITSREGEX @"[0-9]*"
#define EMAILREGEX @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
#define PHONEREGEX @"[0-9+/ ]+"


@interface NSString_stripHtml_XMLParsee : NSObject<NSXMLParserDelegate> {
@private
    NSMutableArray* strings;
}
- (NSString*)getCharsFound;
@end

@implementation NSString_stripHtml_XMLParsee
- (id)init {
    if((self = [super init])) {
        strings = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string {
    [strings addObject:string];
}
- (NSString*)getCharsFound {
    return [strings componentsJoinedByString:@""];
}
@end


@implementation UIView (BB_Extensions)
-(void)addDropShadow{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowPath = shadowPath.CGPath;
}

-(void)addBorder:(float)width radius:(float)radius{
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}
- (UIImage*)screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)] ){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end


@implementation UIImage (BB_Extensions)

- (UIImage *)blurredImage:(CGFloat)blurRate
{
    if (blurRate < 0.0 || blurRate > 1.0) {
        blurRate = 0.5;
    }
    
    int boxSize = (int)(blurRate * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (!error) {
            error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        }
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end


@implementation NSString (BB_Extensions)
- (BOOL) validateTextOnly {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", NAMEREGEX];
    
    return [emailTest evaluateWithObject:self];
}
- (BOOL) validatePhoneNumber {
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", PHONEREGEX];
    
    return [emailTest evaluateWithObject:self];
}
- (BOOL) validateDigitOnlyl {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", DIGITSREGEX];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL) validateEmail {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", EMAILREGEX];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL) validateEmpty {
    BOOL isEmpty=YES;
    if ([self isEqualToString:@""] || [self isEqualToString:@" "]) {
        isEmpty=NO;
    }
    return isEmpty;
}



-(NSString*) trimWhitespaces{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)stringByURLDecode {
    
    NSMutableString *tempStr = [NSMutableString stringWithString:self];
    [tempStr replaceOccurrencesOfString:@"+" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempStr length])];
    
    return [[NSString stringWithFormat:@"%@",tempStr] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

- (NSString *) md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr,strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}


- (NSString*)stripHtml {
    // take this string obj and wrap it in a root element to ensure only a single root element exists
    // and that any ampersands are escaped to preserve the escaped sequences
    NSString* string = [self stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    string = [NSString stringWithFormat:@"<root>%@</root>", string];
    
    // add the string to the xml parser
    NSStringEncoding encoding = string.fastestEncoding;
    NSData* data = [string dataUsingEncoding:encoding];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    
    // parse the content keeping track of any chars found outside tags (this will be the stripped content)
    NSString_stripHtml_XMLParsee* parsee = [[NSString_stripHtml_XMLParsee alloc] init];
    parser.delegate = parsee;
    [parser parse];
    
    // log any errors encountered while parsing
    //NSError * error = nil;
    //if((error = [parser parserError])) {
    //    NSLog(@"This is a warning only. There was an error parsing the string to strip HTML. This error may be because the string did not contain valid XML, however the result will likely have been decoded correctly anyway.: %@", error);
    //}
    
    // any chars found while parsing are the stripped content
    NSString* strippedString = [parsee getCharsFound];
    
    // clean up
    
    
    // get the raw text out of the parsee after parsing, and return it
    return strippedString;
}

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end


@implementation NSDate (BB_Extensions)

//-(NSString*)addEventWithName:(NSString*)titleString{
//    EKEventStore *store = [[EKEventStore alloc] init];
//    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        if (!granted) {
//            return;
//        }
//    }];
//}


//authorizationStatusForEntityType

//typedef NS_ENUM(NSInteger, EKAuthorizationStatus) {
//    EKAuthorizationStatusNotDetermined = 0,
//    EKAuthorizationStatusRestricted,
//    EKAuthorizationStatusDenied,
//    EKAuthorizationStatusAuthorized,
//} __OSX_AVAILABLE_STARTING(__MAC_10_8,__IPHONE_6_0);

-(NSString*)addEventToCalender:(NSString *)titleString{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized) {
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = titleString;
        
        NSDate *now = self;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:GregorianCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
        [components setHour:9];
        [components setMinute:00];
        NSDate *morning = [calendar dateFromComponents:components];
        
        
        event.startDate = morning;
        event.endDate = [morning dateByAddingTimeInterval:60*60*1];  //set 1 hour meeting
        [event setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
        return savedEventId;
    }
    return nil;
}

-(void)editEventForID:(NSString*)idString{
    EKEventStore *store = [[EKEventStore alloc] init];
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized) {
        EKEvent *event = [store eventWithIdentifier:idString];
        
        if (event) {
            NSError *err = nil;
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:GregorianCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
            [components setHour:9];
            [components setMinute:00];
            NSDate *morning = [calendar dateFromComponents:components];
            
            event.startDate = morning;
            event.endDate = [morning dateByAddingTimeInterval:60*60*1];  //set 1 hour
            [event setCalendar:[store defaultCalendarForNewEvents]];
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        }
    }
}

-(void)deleteEventForID:(NSString*)idString{
    EKEventStore *store = [[EKEventStore alloc] init];
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized) {
        EKEvent* eventToRemove = [store eventWithIdentifier:idString];
        if (eventToRemove) {
            NSError* err = nil;
            [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&err];
        }
    }
}

-(NSDate*)addDay:(int)days{
    NSDate *newDate = [self dateByAddingTimeInterval: -(60*60*24*days)];
    return newDate;
}

@end

@implementation NSMutableArray (BB_Extensions)

- (void)shuffle
{
    int count = (int)[self count];
    for (uint i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    
    }
}

@end