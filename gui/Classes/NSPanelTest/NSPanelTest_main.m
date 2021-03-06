/*****************************************************************************
FILE:               NSPanelTest_main.m
LANGUAGE:           Objective-C
SYSTEM:             GNUstep
USER-INTERFACE:     None
DESCRIPTION

    This is the entry point of the NSPanelTest application.

AUTHORS
    <PJB> Pascal J. Bourguignon <pjb@imaginet.fr>
MODIFICATIONS
    2000-03-05 <PJB> Creation.
BUGS
LEGAL
    Written by:  Pascal J. Bourguignon <pjb@imaginet.fr>

    Copyright (C) 2000 Free Software Foundation, Inc.

    This  library is  free software;  you can  redistribute  it and/or
    modify it under the terms of the GNU Lesser General Public License
    as published by the Free  Software Foundation; either version 2 of
    the License, or (at your option) any later version.

    This library  is distributed in the  hope that it  will be useful,
    but  WITHOUT ANY WARRANTY;  without even  the implied  warranty of
    MERCHANTABILITY or FITNESS FOR  A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have  received a copy of the  GNU Lesser General Public
    License  along  with this  library;  if  not,  write to  the  Free
    Software  Foundation, Inc.,  59 Temple  Place, Suite  330, Boston,
    MA 02111-1307 USA
*****************************************************************************/
#import <AppKit/AppKit.h>
#import <NSPanelTest.h>

int main(int argc, const char **argv)
{
  [NSApplication sharedApplication];
  [NSApp setDelegate: [NSPanelTest new]];

  return NSApplicationMain(argc, argv);
}

/*** NSPanelTest_main.m               -- 2000-03-10 13:11:30 -- PJB ***/
