//
//  QCQRCode.h
//  Qco for iOS
//
//  Created by sbkro on 12/06/20.
//  Copyright (c) 2012 sbkro-apps. All rights reserved.
//


//-------------------------------------------------------------------
// Libraries
//-------------------------------------------------------------------
#import <UIKit/UIKit.h>


//-------------------------------------------------------------------
// Enumerated Type
//-------------------------------------------------------------------
enum QCErrorCorrectLevel {
     QCErrorCorrectLevelLow     = 0
    ,QCErrorCorrectLevelMid     = 1
    ,QCErrorCorrectLevelQuarter = 2
    ,QCErrorCorrectLevelHigh    = 3
};


//-------------------------------------------------------------------
// This class is encoder class of QRCode. 
// This class has been designed to make a QR code in three steps.
// 
//   1. Initialize
//      - Initialize using "init" method. Parameter sets the initial 
//        value at this time.
//   2. Set parameters
//      - If you would like to change initial value, you can 
//        set parameters using property.
//   3. Encode
//      - You can get QR code image using "encodeWithText:".
// 
// This class is wrapper class of C++ program.
// And it is used part of open source code at "Psytec Inc.".
// In detail, please refer to the following URL.
//  - http://www.psytec.co.jp/freesoft/02/ (Japanese only)
//-------------------------------------------------------------------
@interface QCQRCode : NSObject
{
    @private

    // pixel size per a module.
    // If the value is bigger, QR code is increased.
    int moduleSize;
    
    // Error Correction Level of QR Code.
    // If the value is bigger, QR Code size is increased.
    // Please use "QRErrorCorrectLevel".
    enum QCErrorCorrectLevel correctLevel;
    
    // Version of QR Code. Its range is from 1 to 40.
    // If the value big, QR Code size is increased.
    int symbolVersion;
    
    // Background Color of QR Code
    UIColor * fgColor;
    
    // Foreground Color of QR Code
    UIColor * bgColor;
}


//-------------------------------------------------------------------
// Methods
//-------------------------------------------------------------------

// Initialize Method
// At this time, parameters of this class is initialized as follow.
// If you would like to change initial value, use properties.
// 
//  - moduleSize    :  1px
//  - correctLevel  :  Low (QCErrorCorrectLevelLow)
//  - symbolVersion :  Automatioc. Change by text.
//  - fgColor       :  black
//  - bgColor       :  white
- (id) init;


// This method convert QR Code image from NSString.
// if encode is failed, this method will return nil.
// @param text
// @return QRcode image
- (UIImage *) encodeWithText: (NSString *) text;


//-------------------------------------------------------------------
// Properties
//-------------------------------------------------------------------
@property (readwrite) int moduleSize;
@property (readwrite) enum QCErrorCorrectLevel correctLevel;
@property (readwrite) int symbolVersion;
@property (readwrite, retain) UIColor * fgColor;
@property (readwrite, retain) UIColor * bgColor;

@end
