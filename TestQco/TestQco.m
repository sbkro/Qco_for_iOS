//
//  TestQco.m
//  TestQco
//
//  Created by sbkro on 12/06/23.
//  Copyright (c) 2012 sbkro-apps. All rights reserved.
//

#import "TestQco.h"

@implementation TestQco

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    NSLog(@"Set-up start.");
    qrcode = [[QCQRCode alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    NSLog(@"Tear-down start.");
    [qrcode release], qrcode = nil;

    
    [super tearDown];
}

#pragma mark - Test case for init
- (void) testInit
{
    NSLog(@"testInit start.");
    STAssertEquals(qrcode.symbolVersion, 0, @"Wrong symbolVersion");
    STAssertEquals(qrcode.moduleSize, 1, @"Wrong moduleSize");
    STAssertEquals(qrcode.correctLevel, QCErrorCorrectLevelLow, @"Wrong init correctLevel");
    STAssertEqualObjects(qrcode.fgColor, [UIColor blackColor], @"Wrong fgColor.");
    STAssertEqualObjects(qrcode.bgColor, [UIColor whiteColor], @"Wrong bgColor.");
}

#pragma mark - Test case for encodeWithText
- (void) testEncodeWithText_moduleSizeTest
{
    NSLog(@"testEncodeWithText_moduleSizeTest start.");
    
    // case 01
    qrcode.moduleSize = 0;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.moduleSize, 1, @"Wrong moduleSize");
    
    // case 02
    qrcode.moduleSize = 1;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.moduleSize, 1, @"Wrong moduleSize");
    
    // case 03
    qrcode.moduleSize = 2;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.moduleSize, 2, @"Wrong moduleSize");
}

- (void) testEncodeWithText_symbolVersionTest
{
    NSLog(@"testEncodeWithText_symbolVersionTest start.");
    
    // case 01
    qrcode.symbolVersion = -1;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.symbolVersion, 0, @"Wrong ");

    // case 02
    qrcode.symbolVersion = 0;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.symbolVersion, 0, @"Wrong ");
    
    // case 03
    qrcode.symbolVersion = 1;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.symbolVersion, 1, @"Wrong ");
    
    // case 04
    qrcode.symbolVersion = 40;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.symbolVersion, 40, @"Wrong ");

    // case 05
    qrcode.symbolVersion = 41;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEquals(qrcode.symbolVersion, 40, @"Wrong ");
}


- (void) testEncodeWithText_bgColorTest
{
    NSLog(@"testEncodeWithText_bgColorTest start.");
    
    // case01
    qrcode.bgColor = nil;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEqualObjects(qrcode.bgColor, [UIColor whiteColor], @"Wrong bgColor");
    
    // case02
    qrcode.bgColor = [UIColor greenColor];
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEqualObjects(qrcode.bgColor, [UIColor greenColor], @"Wrong bgColor");
}

- (void) testEncodeWithText_fgColorTest
{
    NSLog(@"testEncodeWithText_fgColorTest start");

    // case 01
    qrcode.fgColor = nil;
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEqualObjects(qrcode.fgColor, [UIColor blackColor], @"Wrong fgColor");
    
    // case 02
    qrcode.fgColor = [UIColor greenColor];
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    STAssertEqualObjects(qrcode.fgColor, [UIColor greenColor], @"Wrong fgColor");
}

- (void) testEncodeWithText_textTest
{    
    NSLog(@"testEncodeWithText_textText start");
    
    // Encode Capacity (SymbolVersion : 1 / CorrectLevel : High)
    //  Alphabet mode : 25 chars
    //  Number mode   : 41 chars
    //  Kanji mode    : 10 byte
    
    qrcode.correctLevel = QCErrorCorrectLevelHigh;
    qrcode.symbolVersion = 1;

    // case 01 ... Alphabet mode
    image = [qrcode encodeWithText:@"test"];
    STAssertNotNil(image, @"Fail to create QR code.");
    
    // case 02 ... Alphabet mode (capacity over) 
    image = [qrcode encodeWithText:@"abcdefghijklmnopqrstuvwxyz"];
    STAssertNil(image, @"Create QR code.(capacity over case)");

    // case 03 ... Number mode
    image = [qrcode encodeWithText:@"123"];
    STAssertNotNil(image, @"Fail to create QR code.");
    
    // case 04 ... Number mode (capacity over)
    image = [qrcode encodeWithText:@"1234567890123456789012345678901234567890123"];
    STAssertNil(image, @"Create QR code.(capacity over case)");
    
    // case 05 ... Kanji mode
    image = [qrcode encodeWithText:@"あいうえ"];
    STAssertNotNil(image, @"Fail to create QR code.");
    
    // case 06 ... Kanji mode (capacity over)
    image = [qrcode encodeWithText:@"あいうえおかきくけこさ"];
    STAssertNil(image, @"Create QR code.(capacity over case)");
    
    // case 07 ... Text is nil
    image = [qrcode encodeWithText:nil];
    STAssertNil(image, @"Create QR code (Text is nil.)");
    
    // case 08 ... Text is empty string
    image = [qrcode encodeWithText:@""];
    STAssertNil(image, @"Create QR code (Text is empty.)");
}

@end

