//
//  QCQRCode.m
//  Qco for iOS
//
//  Created by sbkro on 12/06/20.
//  Copyright (c) 2012 sbkro-apps. All rights reserved.
//


//-------------------------------------------------------------------
// Libraries
//-------------------------------------------------------------------
#import "QCQRCode.h"
#import "QR_Encode.h"


//-------------------------------------------------------------------
// Define macro
//-------------------------------------------------------------------
#define MIN_MODULE_SIZE         1

#define AUTO_SYMBOL_VERSION     0
#define MIN_SYMBOL_VERSION      1
#define MAX_SYMBOL_VERSION     40


//-------------------------------------------------------------------
// Local Method
//-------------------------------------------------------------------
@interface QCQRCode (Local)
- (void) validate;
@end


//-------------------------------------------------------------------
// Implementation
//-------------------------------------------------------------------
@implementation QCQRCode

#pragma mark - Synthesize

@synthesize moduleSize = moduleSize;
@synthesize correctLevel = correctLevel;
@synthesize symbolVersion = symbolVersion;
@synthesize fgColor = fgColor;
@synthesize bgColor = bgColor;


#pragma mark - Methods

- (id) init
{
    self = [super init];
    
    if (self == nil) {
        return nil;
    }
    
    moduleSize = MIN_MODULE_SIZE;
    correctLevel = QCErrorCorrectLevelLow;
    symbolVersion = AUTO_SYMBOL_VERSION;
    fgColor = [UIColor blackColor];
    bgColor = [UIColor whiteColor];
    
    return self;
}


- (UIImage *) encodeWithText : (NSString *) text
{
    // validate parameters
    [self validate];
    
    if (text == nil || [text length] == 0) {
        return nil;
    }
    
    // -----------------------------------------------------------------
    // Original Method's description (QR_Encode.cpp)
    // Usage  : Data Encode
    // Args   : ErrorCorrectLevel, Version, VersionExtendFlag, MaskingNo, EncodeData, EncodeLength
    // Return : TRUE -> Success, FALSE -> No Data / Capacity over
    // -----------------------------------------------------------------
    CQR_Encode * encoder = new CQR_Encode;
    BOOL ret = encoder->EncodeData(correctLevel, symbolVersion, FALSE, -1, (char *) [text cStringUsingEncoding:NSShiftJISStringEncoding] , 0);
    
    if (ret == FALSE) {
        return nil;
    }
    
    // Create ImageContext
    int pxLength = moduleSize * encoder->m_nSymbleSize;
    UIGraphicsBeginImageContext(CGSizeMake(pxLength, pxLength));
    
    // Draw background
    CGContextRef imgContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(imgContext, bgColor.CGColor);
    
    // Draw foreground
    CGContextFillRect(imgContext, CGRectMake(0, 0, pxLength, pxLength));
    CGContextSetFillColorWithColor(imgContext, fgColor.CGColor);
    for (int y = 0; y < pxLength; y++) {
        for (int x = 0; x < pxLength; x++) {
            if (encoder->m_byModuleData[x][y]) {
                CGContextFillRect(imgContext, CGRectMake(x * moduleSize, y * moduleSize, moduleSize, moduleSize));
            }
        }
    }

    // Create UIImage
    UIImage * image = [UIImage imageWithCGImage:CGBitmapContextCreateImage(imgContext)];
    UIGraphicsEndImageContext();
    
    // Release Encoder
    delete encoder;
    
    return image;
}


- (void) dealloc
{
    [fgColor release], fgColor = nil;
    [bgColor release], bgColor = nil;
    [super dealloc];
}

#pragma mark - Category ... Local

- (void) validate
{
    // moduleSize validation
    if (moduleSize < MIN_MODULE_SIZE) {
        moduleSize = MIN_MODULE_SIZE;
    }
    
    // symbolVersion validation
    if (symbolVersion < AUTO_SYMBOL_VERSION) {
        symbolVersion = AUTO_SYMBOL_VERSION;
    } else if (MAX_SYMBOL_VERSION < symbolVersion) {
        symbolVersion = MAX_SYMBOL_VERSION;
    }
    
    // gbColor validation
    if (bgColor == nil) {
        bgColor = [UIColor whiteColor];
    }
    
    // fgColor validation
    if (fgColor == nil) {
        fgColor = [UIColor blackColor];
    }
}

@end
