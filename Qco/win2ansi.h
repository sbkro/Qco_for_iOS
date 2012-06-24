//
//  win2ansi.h
//  Qco
//
//  Created by sbkro on 12/06/18.
//  Copyright (c) 2012年 sbkro-apps. All rights reserved.
//

#ifndef __WIN32_TO_ANSI__
#define __WIN32_TO_ANSI__

#include <string.h>
#include <stdlib.h>

#ifndef TRUE
#define TRUE  true
#define FALSE false
typedef signed char    BOOL;
#endif

typedef unsigned char   BYTE;
typedef unsigned short  WORD;
typedef char*           LPCSTR;
typedef unsigned char * LPBYTE;

#define lstrlen strlen
#define ZeroMemory(x, y) memset(x, 0, y)
#define min(x, y) x < y ? x : y

#endif