//
//  TestQco.h
//  TestQco
//
//  Created by sbkro on 12/06/23.
//  Copyright (c) 2012 sbkro-apps All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "QCQRCode.h"

@interface TestQco : SenTestCase
{
    QCQRCode * qrcode;
    UIImage * image;
}

// TestCase for init
- (void) testInit;

// TestCase for encodeWithText:
- (void) testEncodeWithText_moduleSizeTest;
- (void) testEncodeWithText_symbolVersionTest;
- (void) testEncodeWithText_bgColorTest;
- (void) testEncodeWithText_fgColorTest;
- (void) testEncodeWithText_textTest;

@end
