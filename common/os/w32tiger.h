/* Copyright (C) 2011 TigerVNC Team.  All Rights Reserved.
 *
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this software; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307,
 * USA.
 */

#ifndef OS_W32TIGER_H
#define OS_W32TIGER_H

#ifdef WIN32 

 /* Windows has different names for these */
#define strcasecmp _stricmp
#define strncasecmp _strnicmp

#include <WinSock2.h>
#include <ws2tcpip.h>
#include <Windows.h>
#include <wininet.h>
#include <shlobj.h>

#ifdef __GNUC__

#include <shlguid.h>
#include <wininet.h>

/* MSLLHOOKSTRUCT structure*/
#ifndef LLMHF_INJECTED
#define LLMHF_INJECTED          0x00000001
#endif

#else /*__GNUC__*/

#if defined(_MSC_VER) || defined(_MSC_EXTENSIONS)
#define DELTA_EPOCH_IN_MICROSECS  11644473600000000Ui64
#else
#define DELTA_EPOCH_IN_MICROSECS  11644473600000000ULL
#endif

struct timezone
{
	__int32 tz_minuteswest; /* minutes W of Greenwich */
	BOOL    tz_dsttime;     /* type of dst correction */
};

int gettimeofday(struct timeval *tv, struct timezone *tz);

#endif /*__GNUC__*/

#endif /* WIN32 */
#endif /* OS_W32TIGER_H */
